From: Martin Schlemmer <azarah@nosferatu.za.org>
Subject: Re: [GIT PATCH] I2C and W1 bugfixes for 2.6.12-rc2
Date: Wed, 20 Apr 2005 00:29:43 +0200
Message-ID: <1113949783.2129.4.camel@nosferatu.lan>
References: <20050419043938.GA23724@kroah.com>
	 <20050419185807.GA1191@kroah.com>
	 <Pine.LNX.4.58.0504191204480.19286@ppc970.osdl.org>
	 <20050419194728.GA24367@kroah.com>
	 <Pine.LNX.4.58.0504191316180.19286@ppc970.osdl.org>
	 <20050419214009.GA25681@kroah.com>
	 <Pine.LNX.4.58.0504191449270.2274@ppc970.osdl.org>
Reply-To: azarah@nosferatu.za.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-MCQ8TmnxBqvoX1nWr4nZ"
Content-Transfer-Encoding: 8bit
Cc: Greg KH <greg@kroah.com>, Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Apr 20 00:22:08 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DO16R-0005JS-IB
	for gcvg-git@gmane.org; Wed, 20 Apr 2005 00:21:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261692AbVDSW0F (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 19 Apr 2005 18:26:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261698AbVDSW0F
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Apr 2005 18:26:05 -0400
Received: from ctb-mesg2.saix.net ([196.25.240.74]:23732 "EHLO
	ctb-mesg2.saix.net") by vger.kernel.org with ESMTP id S261692AbVDSWZx
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Apr 2005 18:25:53 -0400
Received: from gateway.lan (wblv-146-254-56.telkomadsl.co.za [165.146.254.56])
	by ctb-mesg2.saix.net (Postfix) with ESMTP id 140223ED9;
	Wed, 20 Apr 2005 00:25:48 +0200 (SAST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gateway.lan (Postfix) with ESMTP id AC6B33A2430;
	Wed, 20 Apr 2005 00:32:03 +0200 (SAST)
Received: from gateway.lan ([127.0.0.1])
 by localhost (gateway.lan [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 29606-11; Wed, 20 Apr 2005 00:31:59 +0200 (SAST)
Received: from nosferatu.lan (nosferatu.lan [192.168.0.2])
	(using TLSv1 with cipher IDEA-CBC-SHA (128/128 bits))
	(No client certificate requested)
	by gateway.lan (Postfix) with ESMTP id 977643A241A;
	Wed, 20 Apr 2005 00:31:59 +0200 (SAST)
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0504191449270.2274@ppc970.osdl.org>
X-Mailer: Evolution 2.2.1.1 
X-Virus-Scanned: by amavisd-new using ClamAV at nosferatu.za.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


--=-MCQ8TmnxBqvoX1nWr4nZ
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2005-04-19 at 15:00 -0700, Linus Torvalds wrote:
>=20
> On Tue, 19 Apr 2005, Greg KH wrote:
> >=20
> > It looks like your domain name isn't set up properly for your box (whic=
h
> > is why it worked for you, but not me before, causing that patch).
>=20
> No, I think it's a bug in your domainname changes. I don't think you
> should do the domainname at all if the hostname has a dot in it.
>=20
> Most machines I have access to (and that includes machines that are
> professionally maintained, not just my own cruddy setup) says "(none)" to
> domainname and have the full hostname in hostname.
>=20
> And even the ones that use domainname tend to not have a fully qualified=20
> DNS domain there. You need to use dnsdomainname to get that, and I don't=20
> even know how to do it with standard libc.
>=20

Correct me if I am wrong, but the right way to do this is to set the
hostname to just that - the hostname, and add 'domain foo.com'
to /etc/resolv.conf.  Then you should get something like (for say
www1.foo.com):

 $ hostname
www1
 $ dnsdomainname
foo.com
 $ hostname -f
www1.foo.com

I know for some buggy software the workaround was to set the hostname to
the FQDN, but that is really just a kludge, and the software should
rather be fixed (had to patch postfix some time back for instance).


--=20
Martin Schlemmer


--=-MCQ8TmnxBqvoX1nWr4nZ
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBCZYZXqburzKaJYLYRAldhAJ9uT5mimMYi2b2iqeQEJNnwEQjXNQCgjE6b
7A8+Cf8GgTXcIMoz/9YWCSU=
=p0ql
-----END PGP SIGNATURE-----

--=-MCQ8TmnxBqvoX1nWr4nZ--

