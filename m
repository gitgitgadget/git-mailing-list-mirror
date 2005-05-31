From: "Thomas Kolejka" <Thomas.Kolejka@gmx.at>
Subject: Re: [gitweb PATCH] Configure encoding
Date: Tue, 31 May 2005 13:12:36 +0200 (MEST)
Message-ID: <11399.1117537956@www67.gmx.net>
References: <20050531104425.GA23755@vrfy.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue May 31 13:11:00 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dd4dG-0006b7-FV
	for gcvg-git@gmane.org; Tue, 31 May 2005 13:10:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261853AbVEaLMl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 31 May 2005 07:12:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261854AbVEaLMl
	(ORCPT <rfc822;git-outgoing>); Tue, 31 May 2005 07:12:41 -0400
Received: from mail.gmx.de ([213.165.64.20]:7822 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261853AbVEaLMi (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 31 May 2005 07:12:38 -0400
Received: (qmail 14241 invoked by uid 0); 31 May 2005 11:12:37 -0000
Received: from 141.130.250.71 by www67.gmx.net with HTTP;
	Tue, 31 May 2005 13:12:36 +0200 (MEST)
To: Kay Sievers <kay.sievers@vrfy.org>
X-Priority: 3 (Normal)
X-Authenticated: #20307258
X-Mailer: WWW-Mail 1.6 (Global Message Exchange)
X-Flags: 0001
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

> --- Urspr=FCngliche Nachricht ---
> Von: Kay Sievers <kay.sievers@vrfy.org>
> An: Petr Baudis <pasky@ucw.cz>
> Kopie: Thomas Kolejka <Thomas.Kolejka@gmx.at>, Git Mailing List
> <git@vger.kernel.org>
> Betreff: Re: [gitweb PATCH] Configure encoding
> Datum: Tue, 31 May 2005 12:44:25 +0200
>=20
> On Tue, May 31, 2005 at 12:12:17PM +0200, Petr Baudis wrote:
> > Dear diary, on Tue, May 31, 2005 at 11:19:55AM CEST, I got a letter
> > where Kay Sievers <kay.sievers@vrfy.org> told me that...
> > > On Tue, May 31, 2005 at 09:55:11AM +0200, Thomas Kolejka wrote:
> > > > The following patch makes it easy to change the encoding:
> > > >=20
> > > >=20
> > > > --- gitweb.cgi.177      2005-05-31 09:43:17.000000000 +0200
> > > > +++ gitweb.cgi.p        2005-05-31 09:48:46.000000000 +0200
> > > > @@ -20,6 +20,9 @@
> > > >  my $my_uri =3D           $cgi->url(-absolute =3D> 1);
> > > >  my $rss_link =3D "";
> > > > =20
> > > > +my $encoding =3D "utf-8";
> > > > +$encoding =3D "iso-8859-1";
> > >=20
> > > The upstream version will not support anything but the one and on=
ly
> > > sane encoding which is utf-8. It will not provide options to swit=
ch
> > > back to the 80's, sorry. :)
> >=20
> > This matters mainly for commits, right?
>=20
> Yes. Also the content of the files, but fortunately they are just pla=
in
> ascii most of the time. :)

I've made this changes becausae the german letters like =E4, =F6, ... a=
re
displayed ugly in the browser.



> > Perhaps I should recode from current locale to utf8 in cg-commit?
>=20
> Everthing else than utf-8 is just a complete mess with data shared
> across multiple machines. All modern distributions defaulting to utf-=
8
> anyway, so I think it is sane to recode that utf-8.
>=20
> Kay
> -

The patch is to _change_ the encoding easy .. or to leave it unchanged.


Thomas

--=20
Geschenkt: 3 Monate GMX ProMail gratis + 3 Ausgaben stern gratis
++ Jetzt anmelden & testen ++ http://www.gmx.net/de/go/promail ++
