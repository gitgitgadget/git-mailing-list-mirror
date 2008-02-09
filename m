From: Jan Hudec <bulb@ucw.cz>
Subject: Re: [PATCH] RFC: git lazy clone proof-of-concept
Date: Sat, 9 Feb 2008 22:20:59 +0100
Message-ID: <20080209212059.GB17147@efreet.light.src>
References: <200802081828.43849.kendy@suse.cz> <alpine.LSU.1.00.0802081905580.11591@racer.site> <foihu9$110$1@ger.gmane.org> <alpine.LSU.1.00.0802082151570.11591@racer.site> <20080208220356.GA22064@glandium.org> <alpine.LSU.1.00.0802082234170.11591@racer.site> <20080208225024.GA26975@glandium.org> <alpine.LSU.1.00.0802082312520.11591@racer.site> <20080208233856.GA31593@glandium.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Y7xTucakfITjPcLV"
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Sat Feb 09 22:22:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JNx96-0008AI-Sz
	for gcvg-git-2@gmane.org; Sat, 09 Feb 2008 22:22:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755534AbYBIVVL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Feb 2008 16:21:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754396AbYBIVVK
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Feb 2008 16:21:10 -0500
Received: from ns1.bluetone.cz ([212.158.128.13]:60734 "EHLO ns1.bluetone.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754755AbYBIVVJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Feb 2008 16:21:09 -0500
Received: from localhost (spamhole.bluetone.cz [192.168.13.2])
	by ns1.bluetone.cz (Postfix) with ESMTP id 39A29572BE;
	Sat,  9 Feb 2008 22:21:07 +0100 (CET)
Received: from ns1.bluetone.cz ([192.168.13.1])
	by localhost (spamhole.bluetone.cz [192.168.13.2]) (amavisd-new, port 10026)
	with ESMTP id qYMeexmx9lCN; Sat,  9 Feb 2008 22:21:04 +0100 (CET)
Received: from efreet.light.src (145-119-207-85.strcechy.adsl-llu.static.bluetone.cz [85.207.119.145])
	by ns1.bluetone.cz (Postfix) with ESMTP id D4DEB57242;
	Sat,  9 Feb 2008 22:21:03 +0100 (CET)
Received: from bulb by efreet.light.src with local (Exim 4.69)
	(envelope-from <bulb@ucw.cz>)
	id 1JNx87-0007IE-F8; Sat, 09 Feb 2008 22:20:59 +0100
Content-Disposition: inline
In-Reply-To: <20080208233856.GA31593@glandium.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73268>


--Y7xTucakfITjPcLV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 09, 2008 at 00:38:56 +0100, Mike Hommey wrote:
> On Fri, Feb 08, 2008 at 11:14:40PM +0000, Johannes Schindelin wrote:
> > On Fri, 8 Feb 2008, Mike Hommey wrote:
> > > On Fri, Feb 08, 2008 at 10:34:55PM +0000, Johannes Schindelin wrote:
> > > > On Fri, 8 Feb 2008, Mike Hommey wrote:
> > > > > Also note that the http transport uses info/http-alternates for=
=20
> > > > > http:// urls. By the way, it doesn't make much sense that only=20
> > > > > http-fetch uses it.
> > > >=20
> > > > I think it does make sense: nobody else needs http-alternates.
> > >=20
> > > If you're setting an http-alternate, it means objects are missing in =
the=20
> > > repo. If they are missing in the repo and are not in alternates, how =
can=20
> > > any other command needing objects out there work on the repo ?
> >=20
> > The point is: if you have a bare repository on a server that uses=20
> > alternates, that path stored in info/alternates is usable by git-daemon=
=2E =20
> > But it is not usable by git-http-fetch, since that does not have a=20
> > git-aware server side.  So if you want to reuse the _same_ bare reposit=
ory=20
> > _with_ alternates for both git:// transport and http:// transport, you=
=20
> > _need_ to _different_ alternates: one being a path on the server, and=
=20
> > another being an http:// url for http-fetch.
>=20
> But nothing prevents you from only setting an http-alternate. Also not
> http-fetch can deal fine with info/alternates if it contains relative
> paths.

They still may not work because of whatever mapping of paths to URLs the ht=
tp
server does. Also relative paths in info/alternates don't actually work; or
rather, they do, but /not recursively/ (the code seems fixable, just someone
would have to make sure the proper base is always used).

--=20
						 Jan 'Bulb' Hudec <bulb@ucw.cz>

--Y7xTucakfITjPcLV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHrhk7Rel1vVwhjGURAg53AKCa7dztiIutLadjC14IWBazcC1HLQCdEJLc
0tzfdJc4qduoxYe9Bu/MuuY=
=n1At
-----END PGP SIGNATURE-----

--Y7xTucakfITjPcLV--
