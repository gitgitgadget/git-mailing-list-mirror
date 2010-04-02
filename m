From: Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH] Makefile: update defaults for modern Cygwin
Date: Fri, 02 Apr 2010 08:03:59 -0600
Organization: Red Hat
Message-ID: <4BB5F94F.3090403@redhat.com>
References: <1270161834-9597-1-git-send-email-eblake@redhat.com> <7vaatmmju9.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig2E668112C2857FDB74859FD6"
Cc: git@vger.kernel.org, jon.seymour@gmail.com, jrnieder@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 02 16:05:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NxhVB-0002Ro-Kc
	for gcvg-git-2@lo.gmane.org; Fri, 02 Apr 2010 16:05:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754254Ab0DBOFX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Apr 2010 10:05:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:61014 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752918Ab0DBOFV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Apr 2010 10:05:21 -0400
Received: from int-mx05.intmail.prod.int.phx2.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.18])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id o32E5Fq9008548
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Fri, 2 Apr 2010 10:05:15 -0400
Received: from [10.11.9.154] (vpn-9-154.rdu.redhat.com [10.11.9.154])
	by int-mx05.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with ESMTP id o32E5DVi032414;
	Fri, 2 Apr 2010 10:05:14 -0400
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.9) Gecko/20100330 Fedora/3.0.4-1.fc12 Lightning/1.0b1 Thunderbird/3.0.4
In-Reply-To: <7vaatmmju9.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 1.0.1
X-Scanned-By: MIMEDefang 2.67 on 10.5.11.18
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143816>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig2E668112C2857FDB74859FD6
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 04/02/2010 12:47 AM, Junio C Hamano wrote:
> Thanks; as I lack Cygwin environment to test this myself, I'll apply th=
is
> directly on 'master' and see if anybody screams ;-)

Thanks.

>=20
>> +	ifneq ($(wordlist 1, 2, $(subst ., ,$(uname_R))),1 7)
>=20
> Do we need to update this part when Cygwin 1.8 is released?

Odd numbers are public cygwin releases (1.5, 1.7), even numbers are Red
Hat releases (1.6, 1.8), so cygwin 1.8 already does exist for Red Hat
licensed customers.  It will probably be years before cygwin 1.9/1.10
exists, at which point 1.5/1.6 will be such a distant memory that we
could just delete this block altogether at that time.

>  Replacing
> this with "ifeq(... ,1 5)" may not be an improvement either, unless we =
are
> sure that nobody is using 1.4 or older, but I wonder if somebody else h=
ave
> better ideas?

Nothing short of using $(shell) and doing some actual computation on the
string in $(uname_R).  But that's not too hard, if people think it's
worth it; speak up if you want me to rework it along those lines,
otherwise I'll assume that things are good enough as-is.

--=20
Eric Blake   eblake@redhat.com    +1-801-349-2682
Libvirt virtualization library http://libvirt.org


--------------enig2E668112C2857FDB74859FD6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Public key at home.comcast.net/~ericblake/eblake.gpg
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAku1+VIACgkQ84KuGfSFAYDSfgCfaqg7xwkg/GrZ1xr5zoBxa6aT
5LYAn0FrUhsqSc55LTCn7/hkS7VcRo/E
=uZVR
-----END PGP SIGNATURE-----

--------------enig2E668112C2857FDB74859FD6--
