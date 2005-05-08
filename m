From: Petr Baudis <pasky@ucw.cz>
Subject: Re: [PATCH] Add exclude file support to cg-status
Date: Sun, 8 May 2005 03:50:16 +0200
Message-ID: <20050508015016.GL9495@pasky.ji.cz>
References: <20050502171042.A24299@cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 08 03:44:31 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DUapd-0003LA-6O
	for gcvg-git@gmane.org; Sun, 08 May 2005 03:43:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262779AbVEHBuX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 7 May 2005 21:50:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262786AbVEHBuX
	(ORCPT <rfc822;git-outgoing>); Sat, 7 May 2005 21:50:23 -0400
Received: from w241.dkm.cz ([62.24.88.241]:25545 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S262779AbVEHBuT (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 7 May 2005 21:50:19 -0400
Received: (qmail 14999 invoked by uid 2001); 8 May 2005 01:50:16 -0000
To: Matt Porter <mporter@kernel.crashing.org>
Content-Disposition: inline
In-Reply-To: <20050502171042.A24299@cox.net>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Tue, May 03, 2005 at 02:10:42AM CEST, I got a letter
where Matt Porter <mporter@kernel.crashing.org> told me that...
> Adds a trivial per-repository exclude file implementation for
> cg-status on top of the new git-ls-files option.
> 
> Signed-off-by: Matt Porter <mporter@kernel.crashing.org>

Thanks, applied. I decided to go with this version instead of the
.git/info/exclude one since I *don't* think you want to share this. The
very fact it is in the .git/ directory implies here that these are your
local exclude patterns which are likely temporary and more importantly
you don't want them under version control. Therefore they aren't
really interesting for anyone else and should be kept per-tree. That's
this file's point as I view it. If you want something more persistent,
get it to git's sight.

The fact that we have no support for version-tracked exclude file can't
stop me! ;-)

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
