From: Petr Stodulka <pstodulk@redhat.com>
Subject: Re: Forgotten declaration of function path_name() in revision.h?
Date: Wed, 16 Mar 2016 20:08:50 +0100
Message-ID: <56E9AF42.1010907@redhat.com>
References: <56E9A07D.3080508@redhat.com>
 <20160316184853.GA32615@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="0lmsRgFIJwL6L4mh5xFBX1FC5aJXc3b5x"
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Mar 16 20:09:03 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1agGoY-0002j9-B1
	for gcvg-git-2@plane.gmane.org; Wed, 16 Mar 2016 20:09:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755306AbcCPTI5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Mar 2016 15:08:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53814 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752216AbcCPTI5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Mar 2016 15:08:57 -0400
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	by mx1.redhat.com (Postfix) with ESMTPS id 6FF3464445;
	Wed, 16 Mar 2016 19:08:56 +0000 (UTC)
Received: from [10.34.4.235] (unused-4-235.brq.redhat.com [10.34.4.235])
	by int-mx10.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id u2GJ8sTH024895
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 16 Mar 2016 15:08:55 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
In-Reply-To: <20160316184853.GA32615@sigill.intra.peff.net>
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Wed, 16 Mar 2016 19:08:56 +0000 (UTC)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289018>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--0lmsRgFIJwL6L4mh5xFBX1FC5aJXc3b5x
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 16.3.2016 19:48, Jeff King wrote:
> On Wed, Mar 16, 2016 at 07:05:49PM +0100, Petr Stodulka wrote:
>=20
>> according to commit 9831e92 (merge) there is maybe by mistake kept dec=
laration
>> of function path_name() in revision.h, whose definition was removed
>> and isn't used in git anymore.
>=20
> Yes, this should have been part of de1e67d (list-objects: pass full
> pathname to callbacks, 2016-02-11), but I missed it.
>=20
> The patch itself looks fine to me (though it probably makes more sense
> to point to de1e67d than the merge).
>=20
> Note also that:
>=20
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> From ae72c8f9085b3b7bd84f94f90ff5b0416db59d67 Mon Sep 17 00:00:00 2001=

>> From: Petr Stodulka <pstodulk@redhat.com>
>> Date: Wed, 16 Mar 2016 18:51:53 +0100
>> Subject: [PATCH] remove obsoleted function path_name() from header fil=
e
>>  revision.h
>=20
> It makes things easier on the maintainer if you format your patch such
> that "git am" can apply it directly. Use scissors like:
>=20
> -- >8 --
>=20
> to separate the patch from anything that should not go into the commit
> message (rather than "=3D=3D=3D=3D=3D..." as you have here).
>=20
> Drop the "From " line which says nothing (it is an mbox separator, but
> we are already inside a message).
>=20
> The rest of the headers do not hurt, but are generally redundant with
> what is in your email header (though in this case, the Subject is
> different, so you would want to retain that).
>=20
> -Peff
>=20

Thanks for advice. I will remember this. When I have time, I will look
at git-send-mail eventually.

Petr


--0lmsRgFIJwL6L4mh5xFBX1FC5aJXc3b5x
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJW6a9CAAoJEPiGu5hNgNqPqnIQAJM3uQCObftSsI+Fke2xN6p9
NQ7yNDgUkK9Es84y7zjSrsOq3GtsnXVq8jVngGpgi2H/APBJAzlZNgezAJGUCnTX
0KFAkThPfoLadeu/R00fPhebXMiLgmcCJLZm4cMBuSbl3uN5lLlaj0Zt2AFsWPAn
T8sX4jL3xGeqtZFcvg9+XiA5BsQosJfBFkmSdYLnHgWhAdlMzGTCM/Q+KfRMDVuK
VpOFgjwKg+QXtMEsIRwW09zcxgO1j5niJoUcFxrHZcMdawn+RdrguHzU/CdmcC+c
6uGW6VDE4cYX56sSa0P5jKDC7Y1q2E3s5lpBr6z/clwO9p0T5p4JSEy/fT25ro+Q
Z/FDBWXUE2fpfsqLDa36POQO4NsKH/UAWD1/Kec8igI6J2FG+uzdIorTv5bsAYGm
/0HEP2idTsjcV/Kl3wKwr2fptUg0y9BenkfuRzavur5nMlpicCB4Vc+BIY+Cs9p0
xhuCi/h4/zDD2eI+1MB4o33hJ6ksLFK+XbfhjkuRZ85d/v+BY7dGtspX+DkfM0YR
/ZoknEr2SkOpK1Zt0RGrvGpWuU3oW+9kseswLwTEGacWQwmFcvVD/rj7u8lsBLEs
1xXo4XPJo2DYL5CSt9tMV4JL623aSS1VlnrxiZd+JN/+8mZqGl2VG7aionDyRheH
PpjQvDiS2vSwCdt9txHe
=GcaL
-----END PGP SIGNATURE-----

--0lmsRgFIJwL6L4mh5xFBX1FC5aJXc3b5x--
