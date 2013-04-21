From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v3 1/1] git-multimail: a replacement for
 post-receive-email
Date: Sun, 21 Apr 2013 04:07:07 -0700
Message-ID: <20130421110707.GB28959@elie.Belkin>
References: <1366541380-10786-1-git-send-email-mhagger@alum.mit.edu>
 <1366541380-10786-2-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Chris Hiestand <chrishiestand@gmail.com>,
	Marc Branchaud <mbranchaud@xiplink.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Michiel Holtkamp <git@elfstone.nl>,
	Stefan =?utf-8?B?TsOkd2U=?= <stefan.naewe@gmail.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Sun Apr 21 13:07:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UTs7G-0006jL-HF
	for gcvg-git-2@plane.gmane.org; Sun, 21 Apr 2013 13:07:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751224Ab3DULHS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Apr 2013 07:07:18 -0400
Received: from mail-pa0-f44.google.com ([209.85.220.44]:60118 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751012Ab3DULHR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Apr 2013 07:07:17 -0400
Received: by mail-pa0-f44.google.com with SMTP id bi5so3049221pad.17
        for <git@vger.kernel.org>; Sun, 21 Apr 2013 04:07:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=IkYESoOYjCk14/B34URFzsINqtdKpP14DeZyr+vPbMU=;
        b=LRqsfRu0q/FrxsvMR26AzkCcE1sjHnINewXQ63OYGSfu2AapETrl9do0kWA/I/rAq9
         0O3eHadHi6dQIZovA89bRwAk9ydEBCZNfY6n7Xk3r/1R+DX4YAUNkqwTrkpORWEXy28/
         xLOLhwco35PMjeVPlT1ziipG4/yS5lu2wo84ikh7gYIKAf9KKsiwl1XqIDlnkbfEAqUc
         wNtPtM520PPsmT9dTHoYQ97JuzqTPlj3UvoqPm9I4Ni+flxjGU/I+6OYC4M6tWIvIFVO
         j23xi012AsYD4qnM5aJXNC/QO/H+7KJdnQxbUBzWy85bgrOtcAYtRWI8go1q/aBZQaCK
         +CXQ==
X-Received: by 10.66.235.3 with SMTP id ui3mr10767677pac.200.1366542436500;
        Sun, 21 Apr 2013 04:07:16 -0700 (PDT)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPS id o7sm20592092pbs.45.2013.04.21.04.07.14
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 21 Apr 2013 04:07:15 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1366541380-10786-2-git-send-email-mhagger@alum.mit.edu>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221944>

Michael Haggerty wrote:

> Add git-multimail, a tool for generating notification emails for
> pushes to a Git repository.  It is largely plug-in compatible with
> post-receive-email, and is proposed to eventually replace that script.
> The advantages of git-multimail relative to post-receive-email are
> described in README.migrate-from-post-receive-email.

Very nice.

For what it's worth, I'd be happy to see this in contrib/.  It is good
to see an actively maintained analog to post-receive-email, and the
one-mail-per-commit functionality looks fun and useful.

Jonathan

[1] http://thread.gmane.org/gmane.comp.version-control.git/137426
