From: Kay Sievers <kay.sievers@vrfy.org>
Subject: Re: [gitweb PATCH] Configure encoding
Date: Tue, 31 May 2005 14:21:30 +0200
Message-ID: <20050531122130.GA24395@vrfy.org>
References: <20050531104425.GA23755@vrfy.org> <11399.1117537956@www67.gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue May 31 14:20:08 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dd5hw-0006W8-Nu
	for gcvg-git@gmane.org; Tue, 31 May 2005 14:18:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261881AbVEaMVj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 31 May 2005 08:21:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261882AbVEaMVi
	(ORCPT <rfc822;git-outgoing>); Tue, 31 May 2005 08:21:38 -0400
Received: from soundwarez.org ([217.160.171.123]:33163 "EHLO soundwarez.org")
	by vger.kernel.org with ESMTP id S261881AbVEaMVf (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 31 May 2005 08:21:35 -0400
Received: by soundwarez.org (Postfix, from userid 2702)
	id B7D133B04A; Tue, 31 May 2005 14:21:30 +0200 (CEST)
To: Thomas Kolejka <Thomas.Kolejka@gmx.at>
Content-Disposition: inline
In-Reply-To: <11399.1117537956@www67.gmx.net>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Tue, May 31, 2005 at 01:12:36PM +0200, Thomas Kolejka wrote:
> > --- Urspr=C3=BCngliche Nachricht ---
> > Von: Kay Sievers <kay.sievers@vrfy.org>
> > An: Petr Baudis <pasky@ucw.cz>
> > Kopie: Thomas Kolejka <Thomas.Kolejka@gmx.at>, Git Mailing List
> > <git@vger.kernel.org>
> > Betreff: Re: [gitweb PATCH] Configure encoding
> > Datum: Tue, 31 May 2005 12:44:25 +0200
> >=20
> > On Tue, May 31, 2005 at 12:12:17PM +0200, Petr Baudis wrote:
> > > Dear diary, on Tue, May 31, 2005 at 11:19:55AM CEST, I got a lett=
er
> > > where Kay Sievers <kay.sievers@vrfy.org> told me that...
> > > > On Tue, May 31, 2005 at 09:55:11AM +0200, Thomas Kolejka wrote:
> > > > > The following patch makes it easy to change the encoding:
> > > > >=20
> > > > >=20
> > > > > --- gitweb.cgi.177      2005-05-31 09:43:17.000000000 +0200
> > > > > +++ gitweb.cgi.p        2005-05-31 09:48:46.000000000 +0200
> > > > > @@ -20,6 +20,9 @@
> > > > >  my $my_uri =3D           $cgi->url(-absolute =3D> 1);
> > > > >  my $rss_link =3D "";
> > > > > =20
> > > > > +my $encoding =3D "utf-8";
> > > > > +$encoding =3D "iso-8859-1";
> > > >=20
> > > > The upstream version will not support anything but the one and =
only
> > > > sane encoding which is utf-8. It will not provide options to sw=
itch
> > > > back to the 80's, sorry. :)
> > >=20
> > > This matters mainly for commits, right?
> >=20
> > Yes. Also the content of the files, but fortunately they are just p=
lain
> > ascii most of the time. :)
>=20
> I've made this changes becausae the german letters like =C3=A4, =C3=B6=
, ... are
> displayed ugly in the browser.

So use a sane encoding in your commit-text. We don't store the encoding
with the commit, so you don't have any sane other option besides using
utf-8 if you don't use plain ascii.

> > > Perhaps I should recode from current locale to utf8 in cg-commit?
> >=20
> > Everthing else than utf-8 is just a complete mess with data shared
> > across multiple machines. All modern distributions defaulting to ut=
f-8
> > anyway, so I think it is sane to recode that utf-8.
>=20
> The patch is to _change_ the encoding easy .. or to leave it unchange=
d.

Exactly. Change to other encodings is not supported upstream and will
not be a configuration value, sorry.

Kay

