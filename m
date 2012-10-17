From: Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH] notes: mention --notes in more places
Date: Wed, 17 Oct 2012 07:30:56 -0600
Organization: Red Hat
Message-ID: <507EB310.8020904@redhat.com>
References: <1350443975-19935-1-git-send-email-eblake@redhat.com> <20121017055136.GA12301@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------enig542D52258D97AC61FB8E0009"
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Oct 17 15:31:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TOTiU-0006hZ-Pm
	for gcvg-git-2@plane.gmane.org; Wed, 17 Oct 2012 15:31:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756799Ab2JQNbM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Oct 2012 09:31:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:19633 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756086Ab2JQNbL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Oct 2012 09:31:11 -0400
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id q9HDV4im005879
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Wed, 17 Oct 2012 09:31:05 -0400
Received: from [10.3.113.82] (ovpn-113-82.phx2.redhat.com [10.3.113.82])
	by int-mx11.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id q9HDV1FT015648;
	Wed, 17 Oct 2012 09:31:04 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:16.0) Gecko/20121009 Thunderbird/16.0
In-Reply-To: <20121017055136.GA12301@sigill.intra.peff.net>
X-Enigmail-Version: 1.4.5
OpenPGP: url=http://people.redhat.com/eblake/eblake.gpg
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.24
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207918>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig542D52258D97AC61FB8E0009
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 10/16/2012 11:51 PM, Jeff King wrote:
> It may also make sense to show notes differently when outputting the
> "email" format as format-patch does. E.g., using a triple-dash would
> keep them separate from the commit message when using "git am". Like:
>=20
>   your commit message
>=20
>   Signed-off-by: You
>   ---
>   your notes go here

That's _precisely_ what I want!  I want to use notes as a way of
tracking my edits for what I did in v2 of a patch, at the time I commit
my v2, so that I can send a revised series including the notes in a
manner most efficient for someone else using 'git am' on the series to
see why I sent a v2 but without polluting the upstream repository with
useless versioning information from the email.

>=20
> We've talked about it several times, but it's never happened (probably
> because most people don't actually use notes).

And people (like me) don't use notes because they aren't documented.
Catch-22, so we have to start somewhere.

I'll submit a v2 with the non-controversial edits, and spend some time
trying to figure out how to isolate the portion of pretty-options.txt
that is relevant to format-patch.  If it's easy enough, I can also
consider using --- instead of Notes: as the separator when using
format-patch.

--=20
Eric Blake   eblake@redhat.com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--------------enig542D52258D97AC61FB8E0009
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Mozilla - http://www.enigmail.net/

iQEcBAEBCAAGBQJQfrMQAAoJEKeha0olJ0Nqen0IAK9bL/FIVpngepiSgNuL6+Ux
36L9tfRiJQ5NJ38Xos+mW1Xcw7DTaVpd+i1G8Do/36GAMDCL4kICM1Kh607jmXpN
Oj0M9ehTmvtQZVrem+sjWT6mAmFWQEMDO3/c6NG+vWCYR1pZ6GwyLEiSrhaiPSif
5mDk3a811JN90MIONURGXdFXqNoyGlFD0NAyowD5u1c9oxFB4rlaSPGjpY4r/36t
zNEtyLXyEjoUuuMBPXjHNlf/d5FX7lBZrqdnt4XcP+CS2vZDh5M7bGnzx2qY+dit
tv+hB9hyOqLKKvTFjprjbOxIR81m67iQLWP1F2nVNXqiqdwM1EoObCIksKsz+2Y=
=4V93
-----END PGP SIGNATURE-----

--------------enig542D52258D97AC61FB8E0009--
