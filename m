From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 2/7] Change canonicalize_url() to use the SVN 1.7 API
 when available.
Date: Sat, 28 Jul 2012 15:02:06 -0500
Message-ID: <20120728200047.GA4188@burratino>
References: <1343468312-72024-1-git-send-email-schwern@pobox.com>
 <1343468312-72024-3-git-send-email-schwern@pobox.com>
 <20120728135018.GB9715@burratino>
 <50143700.80900@pobox.com>
 <20120728193029.GB3107@burratino>
 <501442D5.6080207@pobox.com>
 <20120728195733.GC3107@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com, robbat2@gentoo.org,
	bwalton@artsci.utoronto.ca, normalperson@yhbt.net
To: Michael G Schwern <schwern@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jul 28 22:03:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SvDEA-0007th-1H
	for gcvg-git-2@plane.gmane.org; Sat, 28 Jul 2012 22:03:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753082Ab2G1UC7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Jul 2012 16:02:59 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:56023 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753054Ab2G1UC6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Jul 2012 16:02:58 -0400
Received: by yenl2 with SMTP id l2so4046236yen.19
        for <git@vger.kernel.org>; Sat, 28 Jul 2012 13:02:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=wtloZ/MpEIKf+bThIaBLOrzs68o9QhmV/KTi4d8aWbQ=;
        b=fapuB+dvWQCmNbTgHtvPEKjSRKAO62AVICb6mOhagMiD9DMqV0OPfzjRtWCT4XMcUT
         BxpbQcauGtpiY9VSjF3XqRv87v8BD/VedeVaRn3Y2PszWNovLesinjnvU3u/S+FkZHRZ
         IGQfXCpdXWYYn1m9Ir2TylcTK4LGvkBeWmr5PkAFtbbIBgyq3ebSyFtQ2wkXyaX0rzFd
         9v37+jfb3DDXYuQzEAMPpigh3KAngYRs51TsCRlnTYNl9diTwXFtPKahgQtpGu9EJ1UW
         yvpt71MeSlB8hIFazopc9lUiHaxD2KkLP2r9MlEKM4txRuZixwNqWSOv3nKzRobqLJjx
         Is3A==
Received: by 10.42.35.82 with SMTP id p18mr4054661icd.15.1343505778077;
        Sat, 28 Jul 2012 13:02:58 -0700 (PDT)
Received: from burratino ([66.99.3.171])
        by mx.google.com with ESMTPS id ai6sm5200317igc.0.2012.07.28.13.02.52
        (version=SSLv3 cipher=OTHER);
        Sat, 28 Jul 2012 13:02:57 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20120728195733.GC3107@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202462>

Jonathan Nieder wrote:
> Michael G Schwern wrote:

>> I would suggest that worrying whether a few lines of code are introduced now
>> or 10 patches later in the same branch which is all going to be merged in one
>> go (and retesting the patches after it) is not the most important thing.
[...]
> In that case they should be one patch, I'd think.
>
> The advantage of introducing changes gradually is that (1) the changes
> can be examined and tested one at a time, and (2) if later a change
> proves to be problematic, it can be isolated, understood, and fixed
> more easily.  The strategy you are suggesting would have neither of
> those advantages.

(To avoid confusion: by "The strategy you are suggesting" I mean
introducing dead code first and activating it later, not the path and
url object idea.  The path and url object approach would be very
nice. :))

Sorry for the lack of clarity.
Jonathan
