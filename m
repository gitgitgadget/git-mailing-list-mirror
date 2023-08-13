Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31E8AC001DB
	for <git@archiver.kernel.org>; Sun, 13 Aug 2023 19:21:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231185AbjHMTV3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 13 Aug 2023 15:21:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230314AbjHMTV2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 Aug 2023 15:21:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 654F11703
        for <git@vger.kernel.org>; Sun, 13 Aug 2023 12:21:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 03EB860B09
        for <git@vger.kernel.org>; Sun, 13 Aug 2023 19:21:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16D05C433C8
        for <git@vger.kernel.org>; Sun, 13 Aug 2023 19:21:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691954489;
        bh=58S88GmPqEQp78KoCdTcVySj065PBgcZyTuATMk+Me4=;
        h=Date:To:From:Subject:From;
        b=pOWKCDBhLI/tOcwtowQ1Mogg0XRlt1p1ALbX3wWFDzFxFsAe+f6Sh6lXvfhrQuRX1
         1jXE/jZBw1BzbG3/osZikTL0kjiWqanomlcll3v1tk0NNQFoLmmT4zTxk5rIQNBRVh
         9ksc4IlnaBLeGkZqjX8mbgOH6yQGTdny8C2p+0Wqe47gghmhTRDWctoacQ4DCpEM3+
         /11NNdGUdLplLR5P7S9sjj8lKSjWC0Xw88i4JosSwwDBEqou9tim1DpWzAVP1r5RIA
         hlxbJrbPJArKQv81OeULsZ35N2lVD9mGmlyHOI4JTi1+8pQdAeecdh9PVVgtDnVnN4
         4zRaocg7TukjA==
Message-ID: <8bbfa6fe-fdaa-aeaf-51bc-16b3d3f7afaa@kernel.org>
Date:   Sun, 13 Aug 2023 21:21:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.1
Content-Language: en-US
To:     Git Mailing List <git@vger.kernel.org>
From:   Alejandro Colomar <alx@kernel.org>
Subject: [wishlist] git-add(1), git-restore(1): -U for more context (with -p)
Organization: Linux
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------Gd0jWQHAqDWxp6lQHYQdFYh0"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------Gd0jWQHAqDWxp6lQHYQdFYh0
Content-Type: multipart/mixed; boundary="------------4jGOPI0U0UcPLr8TEQb1pT4u";
 protected-headers="v1"
From: Alejandro Colomar <alx@kernel.org>
To: Git Mailing List <git@vger.kernel.org>
Message-ID: <8bbfa6fe-fdaa-aeaf-51bc-16b3d3f7afaa@kernel.org>
Subject: [wishlist] git-add(1), git-restore(1): -U for more context (with -p)

--------------4jGOPI0U0UcPLr8TEQb1pT4u
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi!

It would be useful to have -U in git-add(1) and git-restore(1)
to be able to see more context in combination with -p.

Cheers,
Alex

--=20
<http://www.alejandro-colomar.es/>
GPG key fingerprint: A9348594CE31283A826FBDD8D57633D441E25BB5

--------------4jGOPI0U0UcPLr8TEQb1pT4u--

--------------Gd0jWQHAqDWxp6lQHYQdFYh0
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAmTZLTAACgkQnowa+77/
2zIXyA//ewQPbaeDKN59LjH1ak3zl1MoOjGBj+7yd4/hcwjAc++0sgZaVK8ujU8Y
PTsCiah+np4EmMYsW4SpB5YFKhXcyNos1R8t16RCTH1QOTin8v89FlTdlYww9mGC
yv2yB3n2qUgUHvksZCP8ET45Q8TjbgCfeMFUvroo2hOnKRajQwITDOIvaVOSK8Ou
yDqwzUCPj7GSrIcyaEynb/GnvWvuk9r2ZZb163ybVUQ2yDgS9+ccCmiQhXxRRFk3
epj68F+YkwuGygyyzf8HQxxAr0zAIWy+CijmbS9nrOrwo+oe0bGp0sWhqSJlnP1O
ihra/SjUSV8W1xTGZWlEhw3nia1LXvk020z78fwkq2b/jQO0QUbgj7Rynxk/It46
TsNwxczEFu12iWB3gQLTZwg681egESQ9iN+XoRhqP4zKQNX3E9x/+i5LYDNDbhxv
2y0cwKUDVq0HzRQmhPsIlvkSC0JRxgQBiihtlYuzGdqW3n9Xk20Roas5d5HskVMd
Xtoh6MV5RhQv79gndxkKPBphEyFmiwRkAltC8YmczZgA8ihaXQdm2XLS5/NM93/Y
emD4zz3/RcttJrk26RP3EK6U+i8hD8doKNWi5qDRVCWF/7UyOlFCHjHl85P+r6Dq
S3/Jx6IJTmegEhQUYxA1pAcN9rpTNXU9n/+lSlfFKPiKy18DzCs=
=QSym
-----END PGP SIGNATURE-----

--------------Gd0jWQHAqDWxp6lQHYQdFYh0--
