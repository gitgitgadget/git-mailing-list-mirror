From: Petr Baudis <pasky@suse.cz>
Subject: Re: [RFC+PATCH 1/1] Move SCM interoperability tools into scm/
Date: Mon, 10 Jul 2006 00:13:26 +0200
Message-ID: <20060709221326.GU29115@pasky.or.cz>
References: <11524258261798-git-send-email-ryan@michonline.com> <46a038f90607091426u5a6ea328h2090a876e51725ce@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ryan Anderson <ryan@michonline.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 10 00:13:32 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FzhWt-0003Hp-Hi
	for gcvg-git@gmane.org; Mon, 10 Jul 2006 00:13:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161182AbWGIWN3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 9 Jul 2006 18:13:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161185AbWGIWN3
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Jul 2006 18:13:29 -0400
Received: from w241.dkm.cz ([62.24.88.241]:42193 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1161182AbWGIWN2 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 9 Jul 2006 18:13:28 -0400
Received: (qmail 21513 invoked by uid 2001); 10 Jul 2006 00:13:26 +0200
To: Martin Langhoff <martin.langhoff@gmail.com>
Content-Disposition: inline
In-Reply-To: <46a038f90607091426u5a6ea328h2090a876e51725ce@mail.gmail.com>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23569>

Dear diary, on Sun, Jul 09, 2006 at 11:26:59PM CEST, I got a letter
where Martin Langhoff <martin.langhoff@gmail.com> said that...
> So I have to ask... what are the expected benefits of the move?

I've been meaning to do something like this for some time already; my
itch have been the builtins. The tree size _is_ getting out of hand and
a little more categorization of the sources would certainly help.
Although I'd take a different approach:

	libgit/
	builtin/
	standalone/
	scripts/

> In any case, use /interop instead. /scm in the tree of an SCM could be
> anything ;-)

I agree on this point.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Snow falling on Perl. White noise covering line noise.
Hides all the bugs too. -- J. Putnam
