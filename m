From: Petr Baudis <pasky@ucw.cz>
Subject: Re: [COGITO PATCH] Allow file list for cg-add through stdin
Date: Sun, 29 May 2005 20:46:42 +0200
Message-ID: <20050529184642.GL1036@pasky.ji.cz>
References: <4299FE8A.1060207@roemling.net> <20050529180442.GK1036@pasky.ji.cz> <429A0818.6080807@roemling.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun May 29 20:44:46 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DcSlp-0002Gc-1S
	for gcvg-git@gmane.org; Sun, 29 May 2005 20:44:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261394AbVE2Sqq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 29 May 2005 14:46:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261399AbVE2Sqq
	(ORCPT <rfc822;git-outgoing>); Sun, 29 May 2005 14:46:46 -0400
Received: from w241.dkm.cz ([62.24.88.241]:27520 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261394AbVE2Sqo (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 29 May 2005 14:46:44 -0400
Received: (qmail 13612 invoked by uid 2001); 29 May 2005 18:46:42 -0000
To: Jochen Roemling <jochen@roemling.net>
Content-Disposition: inline
In-Reply-To: <429A0818.6080807@roemling.net>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Sun, May 29, 2005 at 08:21:12PM CEST, I got a letter
where Jochen Roemling <jochen@roemling.net> told me that...
> Petr Baudis wrote:
>=20
> >>how is the preferred way to add a whole new directory to a=20
> >>git-repository using cogito?
> >>Currently cg-add expects all new files on the command line.
> >>The following patch allows to feed files through stdin, which allow=
s to do
> >>
> >>  find mynewdir -type f | cg-add -
> >>  =20
> >>
> >
> >if you really want to do that, pass it through xargs...
> >
> >=20
> >
> We have 32=B0 in this room and my xargs must have been melted down.

It's awfully hot here too. :/

> How could I forget about one of my favorite commands?
> I promise I will not post to this list anymore today to avoid a bigge=
r mess.

But a patch for cg-add processing directories recursively would be grea=
t
anyway... ;-)

--=20
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
