From: Eric Blake <eblake@redhat.com>
Subject: Re: Are the patches used to build git on cygwin available in a git
 	repo somewhere?
Date: Wed, 31 Mar 2010 05:49:21 -0600
Organization: Red Hat
Message-ID: <4BB336C1.4000504@redhat.com>
References: <2cfc40321003300916o305e4c15x7850549beafc26c0@mail.gmail.com>	 <20100331025626.GA13501@progeny.tock>	 <20100331025856.GB13501@progeny.tock> <o2p2cfc40321003310055i4b26d46l29ac6113be9eb980@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigA9EC8BAAC9A656A11C4AD233"
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Ramsay Allan Jones <ramsay@ramsay1.demon.co.uk>,
	Dmitry Potapov <dpotapov@gmail.com>
To: Jon Seymour <jon.seymour@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 31 13:49:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NwwQh-0002kG-L7
	for gcvg-git-2@lo.gmane.org; Wed, 31 Mar 2010 13:49:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756933Ab0CaLtq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Mar 2010 07:49:46 -0400
Received: from qmta06.emeryville.ca.mail.comcast.net ([76.96.30.56]:40607 "EHLO
	qmta06.emeryville.ca.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756841Ab0CaLtp (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 31 Mar 2010 07:49:45 -0400
Received: from omta19.emeryville.ca.mail.comcast.net ([76.96.30.76])
	by qmta06.emeryville.ca.mail.comcast.net with comcast
	id znib1d0031eYJf8A6npmz0; Wed, 31 Mar 2010 11:49:46 +0000
Received: from [192.168.0.5] ([24.10.248.129])
	by omta19.emeryville.ca.mail.comcast.net with comcast
	id znpj1d0082oEyzc01nplfx; Wed, 31 Mar 2010 11:49:45 +0000
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.23) Gecko/20090812 Thunderbird/2.0.0.23 Mnenhy/0.7.6.666
In-Reply-To: <o2p2cfc40321003310055i4b26d46l29ac6113be9eb980@mail.gmail.com>
X-Enigmail-Version: 1.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143663>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigA9EC8BAAC9A656A11C4AD233
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

According to Jon Seymour on 3/31/2010 1:55 AM:
> What I was looking for was a git repo that contains a branch with the
> patches that the cygwin folks mutate the official git release with.
> Such a repo would be quite useful because people could, in theory, use
> these to produce their own cygwin git builds at arbitrary commits
> instead of having to wait for cygwin to catch up.
>=20
> Admittedly, it is not a big deal to build such a branch using the
> patch from the cygwin package source, but I was just wondering whether
> there was a well-known repo that contained the patches already.

Nope - the patchset that I apply when building the cygwin port is so smal=
l
that so far I have just maintained it manually, rather than publishing a
git repo.  But if you want me to make it more public, I can certainly loo=
k
into doing that.  And yes, now that 1.7.x is out for some time now, I
should probably advance the cygwin port beyond 1.6.6.1.

--=20
Eric Blake   eblake@redhat.com    +1-801-349-2682
Libvirt virtualization library http://libvirt.org


--------------enigA9EC8BAAC9A656A11C4AD233
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (Cygwin)
Comment: Public key at home.comcast.net/~ericblake/eblake.gpg
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAkuzNskACgkQ84KuGfSFAYBniQCfWKvMT/Wvy2P8uGjb1Swse/wt
P1kAmgIu2UPW96FKxjdltYFAAUL5XYwh
=d+Jq
-----END PGP SIGNATURE-----

--------------enigA9EC8BAAC9A656A11C4AD233--
