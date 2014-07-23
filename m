From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: Git + mod_auth_kerb
Date: Wed, 23 Jul 2014 01:59:56 +0000
Message-ID: <20140723015955.GF5616@vauxhall.crustytoothpaste.net>
References: <CAPYmS35cgcEOfKvT17tULYyxL5GgXBavkD6anhV6yJtdoXVE9Q@mail.gmail.com>
 <20140721231721.GB5616@vauxhall.crustytoothpaste.net>
 <CAPYmS36r2fTeY4iB3k7VpgE7brAGxa+wt9HzfXtMStbMW4_Xvg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="VuQYccsttdhdIfIP"
Cc: git <git@vger.kernel.org>
To: Jean-Francois Bouchard <jfbouchard@accedian.com>
X-From: git-owner@vger.kernel.org Wed Jul 23 04:00:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X9lqn-0000rK-9R
	for gcvg-git-2@plane.gmane.org; Wed, 23 Jul 2014 04:00:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752449AbaGWCAG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jul 2014 22:00:06 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:49037 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751839AbaGWCAF (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 22 Jul 2014 22:00:05 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:ddea:7b17:bda6:4f9d])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 23C6C2808E;
	Wed, 23 Jul 2014 02:00:02 +0000 (UTC)
Mail-Followup-To: Jean-Francois Bouchard <jfbouchard@accedian.com>,
	git <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAPYmS36r2fTeY4iB3k7VpgE7brAGxa+wt9HzfXtMStbMW4_Xvg@mail.gmail.com>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 3.16-rc5-amd64)
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Spam-Score: -0.272 () BAYES_00,RDNS_NONE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254054>


--VuQYccsttdhdIfIP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 22, 2014 at 12:41:19PM -0400, Jean-Francois Bouchard wrote:
> Thanks for this info. This make a lot of sense system wise. For a user
> point of view, it is a nightmare. Also, this break a lot of tools that
> are waiting username/password authentication via HTTPS. (I name
> Eclipse).

What you may want to do is have each user adjust their .gitconfig to do
something like:

  [url "https://bmc@git.crustytoothpaste.net/"]
    insteadOf =3D https://git.crustytoothpaste.net/

That way, everyone can continue to use the same URLs, but have git fix
them up per-user.

Hopefully I'll get some time this week to see if making HTTPS requests
provide an empty username by default will work.

> Also, I m not able to reproduce the kerberos login on Ubuntu 14.04. I
> m asked to enter password even if a kerberos ticket is present and
> this even when I've embedded the username in the URI.

This sounds like an issue with Kerberos and curl on Ubuntu 14.04.  I'm
using Debian unstable (from which Ubuntu pulls changes), and at no point
have I had this problem.  Can you send us the output of the push with
the environment GIT_CURL_VERBOSE set to 1 on a system where it works and
one where it doesn't?

> Is there a better way to integrate Kerberos via HTTPS for git ?

I don't know of any better way.  It does work for me, although I'm just
one person.

--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--VuQYccsttdhdIfIP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJTzxcbAAoJEL9TXYEfUvaLTDoP/2l1+EGjE8+AuklFVfEaLiqJ
HqfWLR/mjGQPcCoodmhAPNHx7tru6kSxKIzRYSuQbIjS5AfN2SA6vlyib8/7vltC
tlIClBN/PTmbyxM6H6S9SybwBCn1UOEFkoJGJdPLQNCUz/z3saMx8JAN/nhUTyes
M9w3yAMqJc7X53o9bB9Rvrx/IDucwEpmx7ai81dPyLU3kDw0V6ipsxBuj1M91RTf
+I3XtnfoWdEv4Ob7aVSEShwVaagzkMvaIa/tB8ABYfsX60B59DvCjvyGPEqn4cZg
aUcJ4Frw2hV5dWTazg8tq4soA+FVQvYo5LQ1zZM6y7lVupL0AbCdwDXP1ljwoWIJ
swbM/2Eoc5D6chtt6CMvH6nxKLXIlzHNn3YNZ3fvosXrmp/KWipX9o5BxhQFi8k3
o500ODD8wUtnmKUSjYi2oMdLcOGqSRyEGitEKwu8gOTUyNhg5cioHOSVUqK0cnoY
dDV8NmR09SATPMJqr7SmR8EcKl/uNDz055qRlAAtbAxaj88EMjYeriodFNpR8mEV
Pz0B80aUOK3VVYdGIzjBOtyOXhJtYKamfMZMB/NV4FIqvcc6udJmeeRddznIpHgz
KMchDJ/5EzKxadgKWq6lVnotA9VoRWdXSE35FfQ+JypSPIsC6X5MdMWZ00QGGq8H
7lD9rrchIUvrj/wJWhAm
=3A9X
-----END PGP SIGNATURE-----

--VuQYccsttdhdIfIP--
