From: Keith Packard <keithp@keithp.com>
Subject: Fixes to parsecvs
Date: Wed, 05 Apr 2006 23:36:32 -0700
Message-ID: <1144305392.2303.240.camel@neko.keithp.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-MtXQfFuBGDbBzsaEUHIf"
Cc: keithp@keithp.com
X-From: git-owner@vger.kernel.org Thu Apr 06 08:37:11 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FRO7B-0002Z4-Iy
	for gcvg-git@gmane.org; Thu, 06 Apr 2006 08:37:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751126AbWDFGhG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 6 Apr 2006 02:37:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751130AbWDFGhG
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Apr 2006 02:37:06 -0400
Received: from home.keithp.com ([63.227.221.253]:19729 "EHLO keithp.com")
	by vger.kernel.org with ESMTP id S1751126AbWDFGhE (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 6 Apr 2006 02:37:04 -0400
Received: from localhost (localhost [127.0.0.1])
	by keithp.com (Postfix) with ESMTP id 7F8BD130020;
	Wed,  5 Apr 2006 23:36:59 -0700 (PDT)
Received: from keithp.com ([127.0.0.1])
	by localhost (keithp.com [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 03503-04; Wed, 5 Apr 2006 23:36:59 -0700 (PDT)
Received: by keithp.com (Postfix, from userid 1033)
	id 1436013001F; Wed,  5 Apr 2006 23:36:58 -0700 (PDT)
Received: from neko.keithp.com (localhost [127.0.0.1])
	by keithp.com (Postfix) with ESMTP id 0005114001;
	Wed,  5 Apr 2006 23:36:58 -0700 (PDT)
Received: by neko.keithp.com (Postfix, from userid 1488)
	id 4887B543DC; Wed,  5 Apr 2006 23:36:32 -0700 (PDT)
To: Git Mailing List <git@vger.kernel.org>
X-Mailer: Evolution 2.4.2.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18466>


--=-MtXQfFuBGDbBzsaEUHIf
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

note, parsecvs remains available from:

	git://git.freedesktop.org/~keithp/parsecvs

I've "fixed" the lexer to permit getc/ungetc in the data parsing
functions. This should resolve the flex -l / -X problems.

Jim Radford send a patch to add '/' as a legal tag character

I added my custom edit-change-log script for people dealing with
X.org-style commit messages.

And, it deals with import branch revisions that aren't supposed to
get merged back to the trunk, creating a custom branch name based on the
branch revision (which must be global across all files).

5e5f4c012aec2db012a08b1c7ed5219ed5100111

--=20
keith.packard@intel.com


--=-MtXQfFuBGDbBzsaEUHIf
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQBENLbvQp8BWwlsTdMRAiXXAKDJ1FxWRhbNDGXpZFc58Hk96GXCfACgtGEs
mXubt0xh1KqnngmV1N+4KJ4=
=fL9X
-----END PGP SIGNATURE-----

--=-MtXQfFuBGDbBzsaEUHIf--
