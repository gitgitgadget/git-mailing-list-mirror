Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4DCCC7EE25
	for <git@archiver.kernel.org>; Thu,  8 Jun 2023 19:45:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235390AbjFHTpX (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Jun 2023 15:45:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230100AbjFHTpW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Jun 2023 15:45:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B8E32D52
        for <git@vger.kernel.org>; Thu,  8 Jun 2023 12:45:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 045F260ACE
        for <git@vger.kernel.org>; Thu,  8 Jun 2023 19:45:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DCAAC433EF
        for <git@vger.kernel.org>; Thu,  8 Jun 2023 19:45:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686253517;
        bh=2IzoDrbBR6uyTWVrutNF68keW6okx1ZTPPlBidNx58E=;
        h=Date:To:From:Subject:From;
        b=U4Kzswb+0F4pleRRnprNZseUWTKlVBgA0YhwgETzmWphxzju2tL2RHQQYFJlXdjYh
         dnANQFsEYoc/OGfGfstlN4x8PRWBwp3XwRVk80e48c+h5O9uMs9CkZdv+l7laMQutr
         rQpLDb5bsGCnI3mXhkjcIRuny0QFTzpOeI73sEn7kJVUmJR8k0h1Om2dkorX4xT3fO
         iJeZlhUWRNTmcyTp+Ss9deRpyNq8bfkRJVDQGnURPsNnzqHBGFDXIhTiNc0L1PhJ3Y
         scwjEDRu+vyJLTfq0RhgnnYb7mFk/LkQvnN8XuZmAofyI4zytjFLR1ZJW+cocrqxJk
         VpQFn8Mm2Cq+w==
Message-ID: <1309b98d-90a0-adce-7eec-8d035b727bf9@kernel.org>
Date:   Thu, 8 Jun 2023 21:45:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Content-Language: en-US
To:     Git Mailing List <git@vger.kernel.org>
From:   Alejandro Colomar <alx@kernel.org>
Subject: git-send-email(1): Encrypted email
Organization: Linux
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------Cc1wgcfT1DqxwsSsvzqE04ix"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------Cc1wgcfT1DqxwsSsvzqE04ix
Content-Type: multipart/mixed; boundary="------------v09ZpW9mdMr9W0toibiqxQUa";
 protected-headers="v1"
From: Alejandro Colomar <alx@kernel.org>
To: Git Mailing List <git@vger.kernel.org>
Message-ID: <1309b98d-90a0-adce-7eec-8d035b727bf9@kernel.org>
Subject: git-send-email(1): Encrypted email

--------------v09ZpW9mdMr9W0toibiqxQUa
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi!

When there's a vulnerability, many projects require that patches (and
related discussions) are encrypted with the GPG keys of the maintainers.

It would be nice to be able to send such patches with git-send-email(1),
which would have to use the GPG keyring (git(1) already has code to use
the keyring, for example for git-commit(1) -S (--gpg-sign), so I guess
it's not crazy to extend such use of the keyring to encrypt patches.

What do you think about it?

Thanks,
Alex

--=20
<http://www.alejandro-colomar.es/>
GPG key fingerprint: A9348594CE31283A826FBDD8D57633D441E25BB5

--------------v09ZpW9mdMr9W0toibiqxQUa--

--------------Cc1wgcfT1DqxwsSsvzqE04ix
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAmSCL8sACgkQnowa+77/
2zL1bg/8C/Bz78RSQQk5ACQoSTLCdbruGZLiEzJoXvlHOWyYYMhEz3oAk5eWPE10
DVhpn7pJ/tJpRBZGTn0WqcFu9xXUSDogILRhJpx3zEWSqSTTtZC06mQWN1XuL501
zcrQgz2pTMQ4risnvP8DR+EtJIENB1BEYq2kvnY0ES1sAt2fID+c5YtNITZTzBo7
SMRYmh2L4wPWkxXzSh6Aam6ovG8UtUbD5xikqmTWL1kl9Tp/qZSdNpzbHoQ//+N/
deZtsab9QWDy+K2rSQ7N/n4pbykqQ0CL2c7fVnmEvdQF6L55iwdqA6s73NR2z3Li
/BHsa9J8AnjNeBfHqc4PjHivstrll7sr2tBGrHuDvGKioiINIdtfil0KJxar6aYb
tc1K4pN7qT4/2S7Y2GPxp7LLR1sY4eQjcAFVV3f1ohj8K6sAjGcgdGmGFs0iwswm
3MbcLff36mWVcpseAn1ZrnG5Ty/87B1q08SP0j42WOTX1vrYFUtFdYielV8PlPgy
oL1f2L/07+Za5q3bWHT6Ds/ydoKM5npFcnqCNpMQOxcyJrkmSoZIkQ70meJtFw8d
mI2ZlJ/++RwlY0+7gIEmx/6qpXg/KSPHZQDHf+eL3Tpid1KGsZzEhu4dPr/hU3NX
woRsL0ShVMCPirjWkCJO5ratK83x1vyxwENw6im7cCcT09HWtiE=
=99zA
-----END PGP SIGNATURE-----

--------------Cc1wgcfT1DqxwsSsvzqE04ix--
