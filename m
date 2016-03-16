From: Petr Stodulka <pstodulk@redhat.com>
Subject: Forgotten declaration of function path_name() in revision.h?
Date: Wed, 16 Mar 2016 19:05:49 +0100
Message-ID: <56E9A07D.3080508@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="dtBkHc31ftC7PC8O5tXjEU1Mh4c4eoGGD"
Cc: Junio C Hamano <gitster@pobox.com>
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Mar 16 19:06:02 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1agFpZ-0005jZ-Lp
	for gcvg-git-2@plane.gmane.org; Wed, 16 Mar 2016 19:06:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934171AbcCPSF4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Mar 2016 14:05:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38568 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933380AbcCPSFz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Mar 2016 14:05:55 -0400
Received: from int-mx14.intmail.prod.int.phx2.redhat.com (int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	by mx1.redhat.com (Postfix) with ESMTPS id 2F5E264D20;
	Wed, 16 Mar 2016 18:05:55 +0000 (UTC)
Received: from [10.34.4.235] (unused-4-235.brq.redhat.com [10.34.4.235])
	by int-mx14.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id u2GI5rWJ001150
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 16 Mar 2016 14:05:54 -0400
X-Enigmail-Draft-Status: N1110
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.27
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Wed, 16 Mar 2016 18:05:55 +0000 (UTC)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289008>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--dtBkHc31ftC7PC8O5tXjEU1Mh4c4eoGGD
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,
according to commit 9831e92 (merge) there is maybe by mistake kept declar=
ation
of function path_name() in revision.h, whose definition was removed
and isn't used in git anymore.

Regards,
Petr


=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=46rom ae72c8f9085b3b7bd84f94f90ff5b0416db59d67 Mon Sep 17 00:00:00 2001
From: Petr Stodulka <pstodulk@redhat.com>
Date: Wed, 16 Mar 2016 18:51:53 +0100
Subject: [PATCH] remove obsoleted function path_name() from header file
 revision.h

The function was removed by commit 9831e92 due to possible security
issue.
---
 revision.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/revision.h b/revision.h
index dca0d38..f20168e 100644
--- a/revision.h
+++ b/revision.h
@@ -257,8 +257,6 @@ extern void put_revision_mark(const struct rev_info *=
revs,
 extern void mark_parents_uninteresting(struct commit *commit);
 extern void mark_tree_uninteresting(struct tree *tree);
=20
-char *path_name(struct strbuf *path, const char *name);
-
 extern void show_object_with_name(FILE *, struct object *, const char *)=
;
=20
 extern void add_pending_object(struct rev_info *revs,
--=20
2.4.3


--dtBkHc31ftC7PC8O5tXjEU1Mh4c4eoGGD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJW6aB9AAoJEPiGu5hNgNqProIP/0tJYIQtZnVxvlAN6j8V82fY
8Z6mZb6xFLFc2W4GSFozf00j+TIrxHYbPOSV5EXa7ZNVger9pZMJI+K5BDjTVOzo
z2UuLmtG3wWJBnq+cN1NAE3IaPdXBqP9N0JfayiKKm8VtHAXCgc/8RJqKLhl0HZS
woX4G9MMNiB/SACuEOTMJu/+EqxMRHOHYo/3zttedh4+DpkJlazm/HZ8Sem5r4dD
RESx33UTIhCG7jC3iIvv492fTfAhPF+Hb+PNVZemabwU7Wok9xIrQcIq1ghl9wJU
0orRVlOZXQMgscwuLL6PnpSN/E+LsDNYv2sxcpPU+H+LeNKkpIpGiJe8igW//xLO
zx4GUWSFntgsGRPoPisJeC4QQR+aZpEZYyzhS+5pmUl6fCNBh/d5lY1wN56tepbJ
2FKRZzKDQL4uP+pRXMssPWC3J4B1RfaBcUy5jxuCM3ojtarLC5RXMv8sjvtOjmMb
D/F5TUXJGTEvTHOIBCj9S5RKCJZ/lFOSEFpmsTYquriWgXbgK88A/ZsHCZAVDCIN
w+HDyWlji3RTDxPLK/g7IJZzqKdIP4/hV6rNM6DepJrDCEks57seNgRrqP9e5fbe
4MpawBvhtdLpm5rn0MVGujyyKVzRU0FY266uEXtaVUGUajrN0DvWUXmCZzK5hIel
8JJU0Z3d6ddvotH7vkZC
=X/hT
-----END PGP SIGNATURE-----

--dtBkHc31ftC7PC8O5tXjEU1Mh4c4eoGGD--
