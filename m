From: Eric Blake <eblake@redhat.com>
Subject: Re: git send-email should not allow 'y' for in-reply-to
Date: Fri, 11 Jan 2013 10:51:42 -0700
Organization: Red Hat, Inc.
Message-ID: <50F0512E.8000205@redhat.com>
References: <y> <1357885869-20815-1-git-send-email-cyliu@suse.com> <50EFD066.60501@redhat.com> <50F0402A.1000108@redhat.com> <20130111164730.GA7921@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------enig427F01367B5C92E6934EC639"
Cc: git@vger.kernel.org, libvir-list@redhat.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jan 11 18:52:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ttilz-00021F-Tc
	for gcvg-git-2@plane.gmane.org; Fri, 11 Jan 2013 18:52:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754209Ab3AKRvr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jan 2013 12:51:47 -0500
Received: from mx1.redhat.com ([209.132.183.28]:16592 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751775Ab3AKRvr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jan 2013 12:51:47 -0500
Received: from int-mx01.intmail.prod.int.phx2.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r0BHphMW030359
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Fri, 11 Jan 2013 12:51:43 -0500
Received: from [10.3.113.92] (ovpn-113-92.phx2.redhat.com [10.3.113.92])
	by int-mx01.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with ESMTP id r0BHpgc7021142;
	Fri, 11 Jan 2013 12:51:43 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/17.0 Thunderbird/17.0
In-Reply-To: <20130111164730.GA7921@sigill.intra.peff.net>
X-Enigmail-Version: 1.4.6
OpenPGP: url=http://people.redhat.com/eblake/eblake.gpg
X-Scanned-By: MIMEDefang 2.67 on 10.5.11.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213228>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig427F01367B5C92E6934EC639
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 01/11/2013 09:47 AM, Jeff King wrote:
> On Fri, Jan 11, 2013 at 09:39:06AM -0700, Eric Blake wrote:
>=20
>>> Please don't answer "y" when git send email shows the following promp=
t:
>>>

>>
>> Anyone willing to patch upstream 'git send-email' to reject a simple '=
y'

> What version of git? Commit 51bbccf is in v1.7.12.1 and higher, and
> says:
>=20
>   $ git show 51bbccf
>   commit 51bbccfd1b4a9e2807413022c56ab05c835164fb
>   Author: Junio C Hamano <gitster@pobox.com>
>   Date:   Tue Aug 14 15:15:53 2012 -0700
>=20
>   send-email: validate & reconfirm interactive responses
>=20
>   People answer 'y' to "Who should the emails appear to be from?"  and
>   'n' to "Message-ID to be used as In-Reply-To for the first email?"
>   for some unknown reason.  While it is possible that your local
>   username really is "y" and you are sending the mail to your local
>   colleagues, it is possible, and some might even say it is likely,
>   that it is a user error.

Awesome!  Already implemented!  In the case that sparked this particular
email, the culprit was using 1.7.3.4; earlier this month, a separate
culprit to the same libvirt mailing list was using 1.7.11.7.

I was right about it needing to take a few months to percolate to the
actual users.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--------------enig427F01367B5C92E6934EC639
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.13 (GNU/Linux)
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iQEcBAEBCAAGBQJQ8FEuAAoJEKeha0olJ0NqvpUH/jeOGbPToM5lE9gdI6smbm0F
z0DeKHOUChrQfJs2f8fhOaTeW6sQOmeS8sxlBocpuA/lIYFpxfrX7CrSdmokkzAe
6cBcKPFypBed+2x/KKlxVPDnF6REup0NHuL3ScOgwZjV9Zdrn6jr7+V9CXIyeSTT
uMv4uWTFHCS1YB8r6AOJeuizeUFAiVrDgjpJVYvL/fZjJ7Fk336n8DMmcw1ZQ4nN
pDyb4z+9yrt7JWXGY5rWQY2aqphwgJSIhp9FA0pySa/I9wfLv69pp7lTa02r6P8v
PGLH99DsflLXeEXInhtlTGcmV09rqa63TZWlIDArsjEr2jye04ZTNj0KIhe/fSU=
=0SMG
-----END PGP SIGNATURE-----

--------------enig427F01367B5C92E6934EC639--
