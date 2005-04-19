From: Martin Schlemmer <azarah@nosferatu.za.org>
Subject: Re: [GIT PATCH] I2C and W1 bugfixes for 2.6.12-rc2
Date: Wed, 20 Apr 2005 01:11:57 +0200
Message-ID: <1113952317.2129.17.camel@nosferatu.lan>
References: <20050419043938.GA23724@kroah.com>
	 <20050419185807.GA1191@kroah.com>
	 <Pine.LNX.4.58.0504191204480.19286@ppc970.osdl.org>
	 <20050419194728.GA24367@kroah.com>
	 <Pine.LNX.4.58.0504191316180.19286@ppc970.osdl.org>
	 <20050419214009.GA25681@kroah.com>
	 <Pine.LNX.4.58.0504191449270.2274@ppc970.osdl.org>
	 <1113949783.2129.4.camel@nosferatu.lan>
	 <Pine.LNX.4.58.0504191539000.2274@ppc970.osdl.org>
Reply-To: azarah@nosferatu.za.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-T10SikV9iHyofFtu70la"
Content-Transfer-Encoding: 8bit
Cc: Greg KH <greg@kroah.com>, Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Apr 20 01:04:31 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DO1lI-0001FB-J4
	for gcvg-git@gmane.org; Wed, 20 Apr 2005 01:04:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261736AbVDSXIR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 19 Apr 2005 19:08:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261737AbVDSXIR
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Apr 2005 19:08:17 -0400
Received: from ctb-mesg5.saix.net ([196.25.240.77]:49347 "EHLO
	ctb-mesg5.saix.net") by vger.kernel.org with ESMTP id S261736AbVDSXIH
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Apr 2005 19:08:07 -0400
Received: from gateway.lan (wblv-146-254-56.telkomadsl.co.za [165.146.254.56])
	by ctb-mesg5.saix.net (Postfix) with ESMTP id 1573E3838;
	Wed, 20 Apr 2005 01:08:00 +0200 (SAST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gateway.lan (Postfix) with ESMTP id C4CBA3A2430;
	Wed, 20 Apr 2005 01:14:15 +0200 (SAST)
Received: from gateway.lan ([127.0.0.1])
 by localhost (gateway.lan [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 23217-03; Wed, 20 Apr 2005 01:14:12 +0200 (SAST)
Received: from nosferatu.lan (nosferatu.lan [192.168.0.2])
	(using TLSv1 with cipher IDEA-CBC-SHA (128/128 bits))
	(No client certificate requested)
	by gateway.lan (Postfix) with ESMTP id 20CAA3A241A;
	Wed, 20 Apr 2005 01:14:12 +0200 (SAST)
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0504191539000.2274@ppc970.osdl.org>
X-Mailer: Evolution 2.2.1.1 
X-Virus-Scanned: by amavisd-new using ClamAV at nosferatu.za.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


--=-T10SikV9iHyofFtu70la
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2005-04-19 at 15:43 -0700, Linus Torvalds wrote:
>=20
> On Wed, 20 Apr 2005, Martin Schlemmer wrote:
> >=20
> > Correct me if I am wrong, but the right way to do this is to set the
> > hostname to just that - the hostname, and add 'domain foo.com'
> > to /etc/resolv.conf.=20
>=20
> I'll correct you.
>=20
> The fact is, that's not what people do. Not me, not kernel.org, not _any_
> of the machines I've got access to. They put the fully qualified name in=20
> the hostname, and just do "search foo.com" in /etc/resolv.conf.
>=20
> So clearly, expecting that people work the way you claim is being
> extremely optimistic. I'm sure some people do that too, but I suspect I'm
> in the majority. Both Fedora Core and YellowDog act the way I described,=20
> not the way you do..
>=20

The interesting bit you snipped was the part where you said you do not
know how to get dnsdomainname to work properly, and that I answered.
Why this other crap about how 90% of the world does it?

PS: If you have later tools, setting hostname to the FQDN and then still
adding 'domain' to resolv.conf seems to do the right thing, although it
did not some time back (and was why I said the bit about hostname only
containing the hostname, else you got something like 'hostname -f'
returning 'www1.foo.com.foo.com) ...


--=20
Martin Schlemmer


--=-T10SikV9iHyofFtu70la
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBCZZA9qburzKaJYLYRAuq7AJ9yC5liNEGb1fT+tM5dPNWTMXIAfgCgjAzy
b4ER7noa9gBk7o8NX6WqpGU=
=UsrD
-----END PGP SIGNATURE-----

--=-T10SikV9iHyofFtu70la--

