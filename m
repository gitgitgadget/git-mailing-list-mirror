From: "Dmitry V. Levin" <ldv@altlinux.org>
Subject: Q: .gitattributes export-ignore bug
Date: Thu, 12 Feb 2009 18:37:21 +0300
Message-ID: <20090212153721.GA9330@wo.int.altlinux.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9amGYk9869ThD9tj"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 12 16:45:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXdkI-0000oG-Mx
	for gcvg-git-2@gmane.org; Thu, 12 Feb 2009 16:44:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751953AbZBLPna (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Feb 2009 10:43:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751169AbZBLPn3
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Feb 2009 10:43:29 -0500
Received: from vint.altlinux.org ([194.107.17.35]:35385 "EHLO
	vint.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750968AbZBLPn2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Feb 2009 10:43:28 -0500
X-Greylist: delayed 366 seconds by postgrey-1.27 at vger.kernel.org; Thu, 12 Feb 2009 10:43:28 EST
Received: from wo.int.altlinux.org (wo.int.altlinux.org [192.168.1.4])
	by vint.altlinux.org (Postfix) with ESMTP id 3AC2F3F80BF4
	for <git@vger.kernel.org>; Thu, 12 Feb 2009 15:37:21 +0000 (UTC)
Received: by wo.int.altlinux.org (Postfix, from userid 508)
	id 2DE403F48C68; Thu, 12 Feb 2009 18:37:21 +0300 (MSK)
Content-Disposition: inline
X-fingerprint: FE4C 93AB E19A 2E4C CB5D  3E4E 7CAB E6AC 9E35 361E
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109622>


--9amGYk9869ThD9tj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

$ mkdir git && cd git && git init -q && mkdir dir && echo .gitattributes ex=
port-ignore >dir/.gitattributes && git add dir/.gitattributes && git commit=
 -q -m 1st
$ git archive --format=3Dtar HEAD |tar tf -
dir/
$ git archive --format=3Dtar HEAD:dir |tar tf -
=2Egitattributes

A bug?


--=20
ldv

--9amGYk9869ThD9tj
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkmUQjEACgkQfKvmrJ41Nh5XggCdENzdpcX9e/YPcNnFTkVqCgX5
O7gAoIU4U07XTUNfv75oP977yUySvU1a
=9d4M
-----END PGP SIGNATURE-----

--9amGYk9869ThD9tj--
