From: "Dmitry V. Levin" <ldv@altlinux.org>
Subject: I: git-fetch: -n option disappeared but git-fetch(1) still describe it
Date: Wed, 12 Mar 2008 13:51:02 +0300
Message-ID: <20080312105102.GE14040@wo.int.altlinux.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="a1QUDc0q7S3U7/Jg"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 12 12:01:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZOhy-0006qN-7m
	for gcvg-git-2@gmane.org; Wed, 12 Mar 2008 12:01:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751530AbYCLLAk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Mar 2008 07:00:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751464AbYCLLAk
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Mar 2008 07:00:40 -0400
Received: from vint.altlinux.org ([194.107.17.35]:59725 "EHLO
	vint.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751410AbYCLLAj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Mar 2008 07:00:39 -0400
X-Greylist: delayed 575 seconds by postgrey-1.27 at vger.kernel.org; Wed, 12 Mar 2008 07:00:39 EDT
Received: from wo.int.altlinux.org (wo.int.altlinux.org [192.168.1.4])
	by vint.altlinux.org (Postfix) with ESMTP id A9B613C0082
	for <git@vger.kernel.org>; Wed, 12 Mar 2008 13:51:02 +0300 (MSK)
Received: by wo.int.altlinux.org (Postfix, from userid 508)
	id 9D610B4552A; Wed, 12 Mar 2008 13:51:02 +0300 (MSK)
Content-Disposition: inline
X-fingerprint: FE4C 93AB E19A 2E4C CB5D  3E4E 7CAB E6AC 9E35 361E
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76944>


--a1QUDc0q7S3U7/Jg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

git-fetch builtinification (commit v1.5.3.2-93-gb888d61) apparently
dropped -n option (alias to --no-tags) documented in
Documentation/fetch-options.txt

Either builtin-fetch.c or Documentation/fetch-options.txt should be
adjusted to sync the code with its docs.

Original bug report:
https://bugzilla.altlinux.org/show_bug.cgi?id=3D14870


--=20
ldv

--a1QUDc0q7S3U7/Jg
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.8 (GNU/Linux)

iEYEARECAAYFAkfXtZYACgkQfKvmrJ41Nh7b+gCdHWxqFPZyWdmJ7pk1bDKdzuIu
+ZIAoKNwWfG1acNyzVFXuK10Tb5DiegD
=05CC
-----END PGP SIGNATURE-----

--a1QUDc0q7S3U7/Jg--
