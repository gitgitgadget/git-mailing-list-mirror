From: Manish Gill <mgill25@outlook.com>
Subject: Problem switching branches in submodule
Date: Thu, 26 Sep 2013 22:50:50 +0530
Message-ID: <BLU0-SMTP17403D5452DA1619FEFCCBAB8280@phx.gbl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="SeAFaKbwHKE0MCITIETcgsFAw2tpoawwa"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 26 19:27:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VPFLz-0000uK-Pk
	for gcvg-git-2@plane.gmane.org; Thu, 26 Sep 2013 19:27:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753748Ab3IZR1s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Sep 2013 13:27:48 -0400
Received: from blu0-omc3-s21.blu0.hotmail.com ([65.55.116.96]:45870 "EHLO
	blu0-omc3-s21.blu0.hotmail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753672Ab3IZR1r (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 26 Sep 2013 13:27:47 -0400
X-Greylist: delayed 409 seconds by postgrey-1.27 at vger.kernel.org; Thu, 26 Sep 2013 13:27:47 EDT
Received: from BLU0-SMTP174 ([65.55.116.74]) by blu0-omc3-s21.blu0.hotmail.com with Microsoft SMTPSVC(6.0.3790.4675);
	 Thu, 26 Sep 2013 10:20:58 -0700
X-TMN: [3n1mmFINl0AjOPxw7U9nSRW9IF50s8vl]
X-Originating-Email: [mgill25@outlook.com]
Received: from [192.168.1.106] ([120.56.147.88]) by BLU0-SMTP174.phx.gbl over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
	 Thu, 26 Sep 2013 10:20:55 -0700
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:17.0) Gecko/20130106 Thunderbird/17.0.2
X-Enigmail-Version: 1.5.2
X-OriginalArrivalTime: 26 Sep 2013 17:20:56.0199 (UTC) FILETIME=[C2ACA970:01CEBADC]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235422>

--SeAFaKbwHKE0MCITIETcgsFAw2tpoawwa
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hello,

I have a git repository with lots of submodules. In one particular
submodule, I'm having the following problem:

If I try to switch branches at the top-level of that submodule, I succeed=
=2E

But, if I try to switch branches in any subsequen levels, I get the
following error:

    fatal: internal error: work tree has already been set
    Current worktree: ../path/Mailman3/rest_project
    New worktree: ../path/Mailman3/rest_project/website/public_rest

Here, Mailman3 is the primary repository and "rest_project" is a
submodule. I can do "git checkout" just fine
inside rest_project, but not after cd-ing into any other repos.

My git version is 1.8.4

Other commands, like git status, push/pull are working fine.

I'd appreciate any help. Thank you.


--SeAFaKbwHKE0MCITIETcgsFAw2tpoawwa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBAgAGBQJSRGzyAAoJEDTnrae/jUU9LwgH/30FBtVJNkJcIprkLBOlRWsr
4gSGV3+iiAeAwm2GHk1nC4aUeKL46bWxc8KdBBthrTOrUjXjGV0IJBzvVo9pMKm+
GbHvdZEVbinpaCbQH2I/h+BQIDa5hlgu03X7H+3Y4AdPKE6bHdS5bl1Wc7jCUKfO
vM8n2Ju7jIpgi0qOQC81RDsSVFgeHz8TwhAJKAsYRSnTr2lS8CvMa6vgQMvIocLJ
ybK+9QibK5emXDuSjPddpJ9flV0q/ey0VErAPxHNZb8FqhH78L9U+WAk0JGUCk7g
sZ6sodYQSbDkJO4XQtFGTVgJa+kb/ZVhLR6o1w8a5J+omS+igz1qeE7g/ySd8Tg=
=XKy7
-----END PGP SIGNATURE-----

--SeAFaKbwHKE0MCITIETcgsFAw2tpoawwa--
