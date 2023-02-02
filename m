Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D5C3C61DA4
	for <git@archiver.kernel.org>; Thu,  2 Feb 2023 21:25:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232557AbjBBVZp (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Feb 2023 16:25:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232775AbjBBVZm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Feb 2023 16:25:42 -0500
X-Greylist: delayed 365 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 02 Feb 2023 13:25:41 PST
Received: from kitenet.net (kitenet.net [66.228.36.95])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E0B76E422
        for <git@vger.kernel.org>; Thu,  2 Feb 2023 13:25:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=joeyh.name; s=mail;
        t=1675372770; bh=Ym2dLPCLhB0mffzd88GNvsv4haUvNxqbjbLS2BihQ6Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=E04FvXrHWrOS9LkcY5/+kglOE6vA+ZiVJpybxAeIRC+IAajjwYQ/j1IddIRdbDLs8
         Ij9pdu1C1yzCPZI04NLzkNDgLn9pQJKuPDk/TET1uRFI0kf4eu06H3m6uEh5lApBwd
         homB38s7ETByl4/2BvpcWRPINqf/0hz6vnQjhACc=
X-Question: 42
Date:   Thu, 2 Feb 2023 17:19:30 -0400
From:   Joey Hess <id@joeyh.name>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: Stability of git-archive, breaking (?) the Github universe, and
 a possible solution
Message-ID: <Y9wo4iH2crlt26+d@kitenet.net>
References: <Y9jlWYLzZ/yy4NqD@tapette.crustytoothpaste.net>
 <20230131150555.ewiwsbczwep6ltbi@meerkat.local>
 <Y9mXB1LaYSUJBlwF@tapette.crustytoothpaste.net>
 <230201.86pmatr9mj.gmgdl@evledraar.gmail.com>
 <CANgJU+V0QRFwmTh8ZzY=28kmbUw=DvSLE24LioOXp6_ozq+RdA@mail.gmail.com>
 <20230201122152.GJ19419@kitsune.suse.cz>
 <CANgJU+VLseURimM++38WA81uFPbnoHiToOt4F4UFL9yVbQpBEw@mail.gmail.com>
 <230201.86cz6tqyvy.gmgdl@evledraar.gmail.com>
 <CANgJU+VNY-VziRijSwyb1WF9s31hKroK+2VJ0qEGiYweiA59Ug@mail.gmail.com>
 <Y9q129WbseimgeBS@mit.edu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="OLrszGdVhjPmOCT2"
Content-Disposition: inline
In-Reply-To: <Y9q129WbseimgeBS@mit.edu>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--OLrszGdVhjPmOCT2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

In my opinion as the original developer of pristine-tar, it's too
complicated to be usefully used by git. The problem it solves is of a
larger scope than the problem git has here. (I hope.)

Developing pristine-tar did entail much investigation of past changes in
compressor outputs. I know that gzip's output has sometimes not been
deterministic as recently as 2012, see for example
https://git.savannah.gnu.org/cgit/gzip.git/commit/?id=3D0a284baeaedca68017f=
46d2646e4

--=20
see shy jo

--OLrszGdVhjPmOCT2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEKKUAw1IH6rcvbA8l2xLbD/BfjzgFAmPcKN8ACgkQ2xLbD/Bf
jzgXvA/+K4CKjlH2LNxvPCqjKWuv871j+sltYZZEGKMBmD96+lPUVP22CZvAWdtx
JsptlOokFQff66k/TWOHiDB931b0Tnnt93BUyJxfamIMnnfx15V7AoPMyA8G9jeX
ow92wRSjvQGno394z2aG4xcfp/1B5ZMkX1hOhv75n/Z3YaeVTAxVWD22EPaYR+hR
Y8MOnqKE3sH3QxGogL7vD7Y2BNaqIuAQIOlb9kWkqtH6rGrbHMI7+z0iGf5gl5iI
xIHDBcP4Nm3VhPthTxnNNJpzvHCiq8xFObLiAhcP8Lz97jjtZgyj0FqERuzajE5J
r+D3FZ+/WkEVDtIciN0kEkg+dSMAtHLn/yPqC7IXbLO3UMLEWJLLGveA5ogkNCXo
+Ay4FGaFPvfbuhwAP3Ig0OQVGc32rQzbMKv54P4tcy6U9belXeib8O5/iwgGxPtj
bnywBas83ppXoZjDkc4GqIYnTVvqJZPjzoL5TBwV5FpRv/EoWJ1d13Bl9zC9si0z
LeiVmkPyx20/ylnvYcSmNnbspNawo6M+f6o10nFn+AXhp70GCtCdVPfLWEZiMcMJ
hCgjqrqoHiPCm/03J1KuvabYza9/pJD2qpW388efrH9nyqsEqx1hsZMkGGerzoYS
qy42UvNHUj8VV+ODlAao+fXP+YsbP2AREjri/kYhETap2FmDYpY=
=hE1R
-----END PGP SIGNATURE-----

--OLrszGdVhjPmOCT2--
