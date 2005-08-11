From: Sebastian Kuzminsky <seb@highlab.com>
Subject: Re: [PATCH] Debian packaging for 0.99.4
Date: Thu, 11 Aug 2005 14:23:50 -0600
Message-ID: <E1E3Jag-0005Tm-EQ@highlab.com>
References: <pan.2005.08.10.21.15.41.143251@smurf.noris.de> <pan.2005.08.10.22.11.25.242201@smurf.noris.de> <46a038f9050810155642bb5580@mail.gmail.com> <20050810233953.GV28270@kiste.smurf.noris.de> <E1E33Zb-0004dT-Bx@highlab.com> <46a038f90508102144358a4bcf@mail.gmail.com> <Pine.LNX.4.58.0508102200560.3295@g5.osdl.org> <E1E35vU-0004nP-JR@highlab.com> <Pine.LNX.4.58.0508110915210.3295@g5.osdl.org> <E1E3IOG-0005HO-AK@highlab.com> <20050811201558.GA2874@mars.ravnborg.org>
Cc: Linus Torvalds <torvalds@osdl.org>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	Matthias Urlichs <smurf@smurf.noris.de>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 11 22:23:16 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E3JZc-0003bP-3g
	for gcvg-git@gmane.org; Thu, 11 Aug 2005 22:22:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932429AbVHKUW3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 11 Aug 2005 16:22:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932431AbVHKUW3
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Aug 2005 16:22:29 -0400
Received: from rwcrmhc11.comcast.net ([216.148.227.117]:22258 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S932429AbVHKUW2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Aug 2005 16:22:28 -0400
Received: from highlab.com ([67.165.222.77])
          by comcast.net (rwcrmhc11) with ESMTP
          id <2005081120214601300oiit2e>; Thu, 11 Aug 2005 20:21:46 +0000
Received: from seb (helo=highlab.com)
	by highlab.com with local-esmtp (Exim 4.50)
	id 1E3Jag-0005Tm-EQ; Thu, 11 Aug 2005 14:23:50 -0600
To: Sam Ravnborg <sam@ravnborg.org>
In-reply-to: <20050811201558.GA2874@mars.ravnborg.org> 
Comments: In-reply-to Sam Ravnborg <sam@ravnborg.org>
   message dated "Thu, 11 Aug 2005 22:15:58 +0200."
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Sam Ravnborg <sam@ravnborg.org> wrote:
> > 
> > Anyway, enough of this.  I understand the name will not change and I'm
> > ok with that.  I'll deal with it on our (Debian's) end.
> 
> The easy fix is to kill the small git script that is not
> mandatory anyway (as far as my quick grep told me).
> 
> The cg script has a bit more value.

Tried that too, and I got the bug reports to prove it.  ;-)

The problem there is that tons of docs and webpages and mailing list
archives talk about running "git this" and "git that".  So the poor
confused Debian user tries the recipe and gets "command not found", and
gives up in disgust.  Or worse, mails the git list saying it doesnt work,
and wasting everyones time debugging the intentional package mungling.

Really, the bottom line is we should all mean the same thing when we say
"git-core" and "cogito".


-- 
Sebastian Kuzminsky
