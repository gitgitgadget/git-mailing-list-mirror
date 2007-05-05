From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [RFC?] Telling git about more complex relationships between commits (Was: Re: FFmpeg considering GIT)
Date: Sat, 5 May 2007 20:03:00 +0200
Message-ID: <20070505180300.GB2898@steel.home>
References: <loom.20070502T111026-882@post.gmane.org> <200705041353.17992.johan@herland.net> <20070504221152.GF4033@steel.home> <200705051449.45447.johan@herland.net>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Sat May 05 20:03:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HkOb6-0001HW-1S
	for gcvg-git@gmane.org; Sat, 05 May 2007 20:03:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934208AbXEESDE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 5 May 2007 14:03:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934209AbXEESDE
	(ORCPT <rfc822;git-outgoing>); Sat, 5 May 2007 14:03:04 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.189]:38826 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934208AbXEESDD (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 May 2007 14:03:03 -0400
Received: from tigra.home (195.4.202.37)
	by post.webmailer.de (fruni mo17) (RZmta 5.9)
	with ESMTP id E048e4j45I2MVa ; Sat, 5 May 2007 20:03:00 +0200 (MEST)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 84A93277BD;
	Sat,  5 May 2007 20:03:00 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id 58635D171; Sat,  5 May 2007 20:03:00 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <200705051449.45447.johan@herland.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CcuQaGCTl9Ag==
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46279>

Johan Herland, Sat, May 05, 2007 14:49:42 +0200:
> Can you categorically say that there is no use for the following output? 
> (even if you need to pass an option to "git blame" to get it):
> ====
> ^bb0203a (User A 2007-05-05 12:25:44 +0200 1) foo
> ^bb0203a (User A 2007-05-05 12:25:44 +0200 1) bar
> ^bb0203a (User A 2007-05-05 12:25:44 +0200 3) baz
> ====

Assuming a repo which has 50% of all commits - reverts (just because
someone could not be bothered to learn to use rebase, format-patch
and git-am before sending things upstream) I would use the exact
wording I used before. I'd say "it's dangerous" now. It hides the
mess this repo is.

> > It's useless.
> 
> Maybe. At least some of the fields I proposed are probably useless. But 
> I don't think we should throw away the core idea unless we can show 
> that _all_ fields are useless.

Just think of something you actually _can_ use. Implement it and try.
And than, if you are convinced it actually is useful, try it on your
friends. And after them, if you're still alive, try using it with old
git (like 1.4 from Debian and Ubuntu).
