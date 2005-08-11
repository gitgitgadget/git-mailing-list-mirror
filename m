From: Sebastian Kuzminsky <seb@highlab.com>
Subject: Re: [PATCH] Debian packaging for 0.99.4
Date: Thu, 11 Aug 2005 14:44:29 -0600
Message-ID: <E1E3Juf-0005YZ-PR@highlab.com>
References: <46a038f9050810155642bb5580@mail.gmail.com> <20050810233953.GV28270@kiste.smurf.noris.de> <E1E33Zb-0004dT-Bx@highlab.com> <46a038f90508102144358a4bcf@mail.gmail.com> <Pine.LNX.4.58.0508102200560.3295@g5.osdl.org> <E1E35vU-0004nP-JR@highlab.com> <Pine.LNX.4.58.0508110915210.3295@g5.osdl.org> <E1E3IOG-0005HO-AK@highlab.com> <20050811201558.GA2874@mars.ravnborg.org> <E1E3Jag-0005Tm-EQ@highlab.com> <20050811203248.GC5411@kiste.smurf.noris.de>
Cc: Sam Ravnborg <sam@ravnborg.org>,
	Linus Torvalds <torvalds@osdl.org>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 11 22:43:54 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E3Jsk-0006HL-Nx
	for gcvg-git@gmane.org; Thu, 11 Aug 2005 22:42:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932391AbVHKUm2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 11 Aug 2005 16:42:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932399AbVHKUm2
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Aug 2005 16:42:28 -0400
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:26516 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S932391AbVHKUm2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Aug 2005 16:42:28 -0400
Received: from highlab.com ([67.165.222.77])
          by comcast.net (rwcrmhc13) with ESMTP
          id <20050811204226015004qum9e>; Thu, 11 Aug 2005 20:42:27 +0000
Received: from seb (helo=highlab.com)
	by highlab.com with local-esmtp (Exim 4.50)
	id 1E3Juf-0005YZ-PR; Thu, 11 Aug 2005 14:44:29 -0600
To: Matthias Urlichs <smurf@smurf.noris.de>
In-reply-to: <20050811203248.GC5411@kiste.smurf.noris.de> 
Comments: In-reply-to Matthias Urlichs <smurf@smurf.noris.de>
   message dated "Thu, 11 Aug 2005 22:32:48 +0200."
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Matthias Urlichs <smurf@smurf.noris.de> wrote:
> Another possible solution: Rename git's git to X and install ours as Y.
> Ask the user which should be symlinked to /usr/bin/git, if both are
> installed, via the existing "alternatives" system.

I suggested this on debian-devel, and was told that update-alternatives is
not to be used for programs that do not do the same thing.  Debian Policy
Manual, section 10.1.

It's ok for vim and nvi to use update-alternatives to pick who gets
to be vi, because no matter which alternative is active, running "vi"
does what you expect.  It's not ok to use it for git and GNU Interactive
Tools, because they do such different things.

Thanks for working with me on this, I appreciate all the suggestions.
I hope we can make Debian not suck at git.


-- 
Sebastian Kuzminsky
