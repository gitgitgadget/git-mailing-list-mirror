From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: change remote to track new branch
Date: Sat, 03 Aug 2013 09:14:59 +0200
Message-ID: <m2d2pvp7nw.fsf@linux-m68k.org>
References: <20130803024032.GA28666@analysisandsolutions.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git Mailing List <git@vger.kernel.org>
To: Daniel Convissor <danielc@analysisandsolutions.com>
X-From: git-owner@vger.kernel.org Sat Aug 03 09:15:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V5W3X-0002v1-Mv
	for gcvg-git-2@plane.gmane.org; Sat, 03 Aug 2013 09:15:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751211Ab3HCHPK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Aug 2013 03:15:10 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:49070 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751138Ab3HCHPJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Aug 2013 03:15:09 -0400
Received: from frontend1.mail.m-online.net (frontend1.mail.intern.m-online.net [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 3c6c2H26c3z3hhYD;
	Sat,  3 Aug 2013 09:15:02 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
	by mail.m-online.net (Postfix) with ESMTP id 3c6c2G5n0rzbbng;
	Sat,  3 Aug 2013 09:15:02 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.180])
	by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavisd-new, port 10024)
	with ESMTP id YOEStc58MREW; Sat,  3 Aug 2013 09:15:01 +0200 (CEST)
X-Auth-Info: vbv/tZ6r1J+rhKRg5sOA9ItrLmUn22zedlJBPjcNguQ=
Received: from linux.local (ppp-93-104-143-60.dynamic.mnet-online.de [93.104.143.60])
	by mail.mnet-online.de (Postfix) with ESMTPA;
	Sat,  3 Aug 2013 09:15:01 +0200 (CEST)
Received: by linux.local (Postfix, from userid 501)
	id 1DD021E57D5; Sat,  3 Aug 2013 09:15:00 +0200 (CEST)
X-Yow: TAILFINS!!  ...click...
In-Reply-To: <20130803024032.GA28666@analysisandsolutions.com> (Daniel
	Convissor's message of "Fri, 2 Aug 2013 22:40:32 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231568>

Daniel Convissor <danielc@analysisandsolutions.com> writes:

> Long ago I added a remote to my repo.  It is set to track what was then
> WordPress' main release branch (3.4-branch) and created a local branch
> to use it.  Well, time marches on.  I want to update my remote and
> branch to track the new main release branch (3.6-branch).
>
> Here's how I set things up at the time:
>
> git remote add -t 3.4-branch -f wp https://github.com/WordPress/WordPress
> git checkout -b wp wp/3.4-branch

Use "git remote set-branches" to change the tracked branches of a
remote.  Use "git branch --set-upstream-to" to change the upstream of a
branch (or create a new branch from the new upstream).

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
