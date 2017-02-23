Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 164EC2022D
	for <e@80x24.org>; Thu, 23 Feb 2017 16:52:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751320AbdBWQwo (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Feb 2017 11:52:44 -0500
Received: from kitenet.net ([66.228.36.95]:33944 "EHLO kitenet.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751119AbdBWQwn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Feb 2017 11:52:43 -0500
X-Greylist: delayed 389 seconds by postgrey-1.27 at vger.kernel.org; Thu, 23 Feb 2017 11:52:43 EST
X-Question: 42
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=joeyh.name; s=mail;
        t=1487868372; bh=oQwLSpCbsNaFhIPDGiYNLoO0PCRl7hfFCt3GizIGtRQ=;
        h=Date:From:To:Subject:From;
        b=E0fhJWRntZw78fZ3X5xo8uZjh9aTFGu5Yq/vJF8sAVjkBIxoQz2uuR4KFfixv+PjC
         6kabGRnRNzPS7n5R99WVZ9dePTm2RBD2DybZYJfHAkWtTr4dp+H0a2K/PmtY1a1vV/
         F0hyLOtJfcWZ3QqnJdSEp/nZa+67yPbTQqGTkzq4=
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=joeyh.name; s=mail;
        t=1487868186; bh=oQwLSpCbsNaFhIPDGiYNLoO0PCRl7hfFCt3GizIGtRQ=;
        h=Date:From:To:Subject:From;
        b=eqe90P2w94P4JixsYVdqLU91BS5nCj7f+PqnwxcEV23mYh6gdoeSpe8hK8TWjNgb/
         en1a7hhM4OY9eBVQYqpVHq99NNlClKkjSscMrdsIByVG1h6v6/urDOzsm4aBo7XTMI
         Os8JoeF20aYn+LWN30fQdyVTnDb/vEHpgl/uk76I=
Date:   Thu, 23 Feb 2017 12:43:06 -0400
From:   Joey Hess <id@joeyh.name>
To:     git@vger.kernel.org
Subject: SHA1 collisions found
Message-ID: <20170223164306.spg2avxzukkggrpb@kitenet.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="2gtyzd63bduirdmw"
Content-Disposition: inline
User-Agent: NeoMutt/20161126 (1.7.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--2gtyzd63bduirdmw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

https://shattered.io/static/shattered.pdf
https://freedom-to-tinker.com/2017/02/23/rip-sha-1/

IIRC someone has been working on parameterizing git's SHA1 assumptions
so a repository could eventually use a more secure hash. How far has
that gotten? There are still many "40" constants in git.git HEAD.

In the meantime, git commit -S, and checks that commits are signed,
seems like the only way to mitigate against attacks such as
the ones described in the threads at
https://joeyh.name/blog/sha-1/ and
https://joeyh.name/blog/entry/size_of_the_git_sha1_collision_attack_surface/

Since we now have collisions in valid PDF files, collisions in valid git
commit and tree objects are probably able to be constructed.

--=20
see shy jo

--2gtyzd63bduirdmw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE6FpfY7MdJMHr8NgcyRDZIiUS48cFAlivERoACgkQyRDZIiUS
48eaoA//chGZEsK1QlW/tDMeG21rQ5Qz/RoI76UYwWLLouVqzeTxaxfYRgjj7QUG
6azLobp0zx0UmLwviJ4z+f+sYWbuM1z5Gucz2MwPSsaGWOjhs0FbxFwtS1Aldm6D
bx6ZB6J5VdQAXO+Pxul2/0xu5aAoNIgjmw9bXzo7IdtAotreRLCoWE+VWuwjEoc4
RUm1/jgDf4NQAMRVMo7+EA02Lm2VXK9jJR5wjSOjneCqdUw8s8vWfDwSx5NDi0NE
Hgwrx0f+dMrs43UUIHLlLXGT8suVuwvCCX2ujIwzPs2lmBHH7XPsZ+yynWVg8ZVZ
YwH9esVOAR+q8JiYoHOFb/okHPgbiboMYBUXJiE4vYg4KbVRvVQVYQF1p8OLk3/r
046oWrBQFofxABRXvSdQbah9OL5M1TW3n40eIozTnS+s6Hw2cdU44EGw5PLkSHb2
oSgHiC7GQe/L0fpC2NUO/ut8QNv7nKDJKp0CzYdvQUpigszMvfJumy64qEPK8IoS
Rx8AuaSt6FzBZkaNhHTbouA/iO9IiIdsz4hMuQsffE9zdbqzaSAvKQwquA9zaTFA
dz1gLh1If6m/+8H8b1z4icgz+CWHcEkOX9/+eRISiBX/DqH2XoqtPpiOeXpGDAmW
C99uDdQcyWpE0kZ1VHLwiv92ZYw8SkEo7Sk8cjYgGGOO1Sk+uGw=
=R1UC
-----END PGP SIGNATURE-----

--2gtyzd63bduirdmw--
