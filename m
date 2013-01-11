From: Eric Blake <eblake@redhat.com>
Subject: git send-email should not allow 'y' for in-reply-to
Date: Fri, 11 Jan 2013 09:39:06 -0700
Organization: Red Hat, Inc.
Message-ID: <50F0402A.1000108@redhat.com>
References: <y> <1357885869-20815-1-git-send-email-cyliu@suse.com> <50EFD066.60501@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------enig1510E709F8AA3DD2A2D98443"
Cc: libvir-list@redhat.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 11 17:39:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tthdh-0000bF-Q1
	for gcvg-git-2@plane.gmane.org; Fri, 11 Jan 2013 17:39:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754860Ab3AKQjI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jan 2013 11:39:08 -0500
Received: from mx1.redhat.com ([209.132.183.28]:61632 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754711Ab3AKQjH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jan 2013 11:39:07 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r0BGd7St026799
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <git@vger.kernel.org>; Fri, 11 Jan 2013 11:39:07 -0500
Received: from [10.3.113.92] (ovpn-113-92.phx2.redhat.com [10.3.113.92])
	by int-mx10.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id r0BGd6Sd016616;
	Fri, 11 Jan 2013 11:39:06 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/17.0 Thunderbird/17.0
In-Reply-To: <50EFD066.60501@redhat.com>
X-Enigmail-Version: 1.4.6
OpenPGP: url=http://people.redhat.com/eblake/eblake.gpg
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.23
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213223>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig1510E709F8AA3DD2A2D98443
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

[raising this UI wart to the git list]

On 01/11/2013 01:42 AM, Peter Krempa wrote:
> On 01/11/13 07:31, Chunyan Liu wrote:
>> This patch series is to...
[snip]

>=20
> Please don't answer "y" when git send email shows the following prompt:=

>=20
> "Message-ID to be used as In-Reply-To for the first email?"
>=20
> you should respond with a message ID there. Unfortunately we have a
> growing thread that contains submissions with this mistake.

Anyone willing to patch upstream 'git send-email' to reject a simple 'y'
rather than blindly sending a bad messageID for the in-reply-to field,
to help future users avoid this mistake?  Obviously, it won't help until
the patch eventually percolates into distros, so it would be a few more
months before we see the benefits, but down the road it will prevent
confusing threads.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--------------enig1510E709F8AA3DD2A2D98443
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.13 (GNU/Linux)
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iQEcBAEBCAAGBQJQ8EAqAAoJEKeha0olJ0NqsQQIAK0SouueMDXlfgSl3ghSebHL
NFCCA0tyhFHIygfzLUvXa0xGZTYjHgkVCuPDzR2VJvtRF79pPALWd7t/GIJJzEby
98tFTn5HJSlNd2MwbrehkugRTNW5yI0vCEUi3AWAUJbj2y4pAvRcbUadRwlVLq7W
QIHwRznqWt2vRADfi/9otwW3nBNCugmOnZi2HKBY+1eohDhFIuB6B1IP5/elJvRb
DKtbEQh9Unpg9QWLPHg1duy5Vu1IOyfhKOpgy/rDrXn/Nwo/YMQOgdjKLILnsf9g
JyV31NaqSozJfmcDj6xJuDMMicMakeaTw83qE/zDc0m0+eUlZABdMYkgNf0zBsU=
=/SoM
-----END PGP SIGNATURE-----

--------------enig1510E709F8AA3DD2A2D98443--
