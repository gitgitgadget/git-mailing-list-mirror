From: Steffen Daode Nurpmeso <sdaoden@googlemail.com>
Subject: Re: [PATCH] progress: use \r as EOL only if isatty(stderr) is true
Date: Tue, 28 Jun 2011 20:04:39 +0200
Message-ID: <20110628180439.GA86588@sherwood.local>
References: <1309272009-23076-1-git-send-email-sdaoden@gmail.com>
 <BANLkTinRe=pA=_obCmPKBjJMXH_pDfwCtw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 28 20:26:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QbczF-00047P-J7
	for gcvg-git-2@lo.gmane.org; Tue, 28 Jun 2011 20:26:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753589Ab1F1SFp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Jun 2011 14:05:45 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:37970 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760402Ab1F1SEs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jun 2011 14:04:48 -0400
Received: by bwd5 with SMTP id 5so390944bwd.19
        for <git@vger.kernel.org>; Tue, 28 Jun 2011 11:04:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=lLEzm3G0dVmirHXF6PG/eLGbHDeGpFZXhUhF5MyjzdM=;
        b=dyl4NGvW/XlNegb8ScUJnK6mLR9yOevtJoqhJLLCDFSfAxOTA1JbmjTBgZhJmb6rMA
         TCUcHBq/1Xsq7NAXaRhLFGl8j6UYdKjbB4HzZVNtJv0pkkDLLqsDBUOYModcTugh4dMc
         p2ANhCrgHQ895ENk1HMdGIhSfy0jTXNbB03sk=
Received: by 10.204.19.19 with SMTP id y19mr5707816bka.164.1309284286324;
        Tue, 28 Jun 2011 11:04:46 -0700 (PDT)
Received: from sherwood.local ([82.113.99.172])
        by mx.google.com with ESMTPS id u6sm404293bkj.6.2011.06.28.11.04.44
        (version=SSLv3 cipher=OTHER);
        Tue, 28 Jun 2011 11:04:45 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <BANLkTinRe=pA=_obCmPKBjJMXH_pDfwCtw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176411>

@ Tay Ray Chuan <rctay89@gmail.com> wrote (2011-06-28 18:27+0200):
> hmm, shouldn't the onus of checking tty fall on to callers of
> progress* functions?

Ok, in the meanwhile i have understood what you ment, but
unfortunately i have thrown away the logfile which caused me to
write the patch, and even more unfortunately i could not reproduce
in the last hour or what any 'xy  ^Mxy  ^M' dump with the current
state of the repos.  A short 'git grep -F progress' is useless
from my current point of view (and with the amount of my free
time).  The script contains these git(1) related commands anyway:

    git pull -v --ff-only --stat --prune && git gc
    git svn rebase [not at the time of the log: && git gc]

But that is true: i have had a log file with the mentioned content.

--
Ciao, Steffen
sdaoden(*)(gmail.com)
() ascii ribbon campaign - against html e-mail
/\ www.asciiribbon.org - against proprietary attachments
