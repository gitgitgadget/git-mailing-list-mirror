Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 494F7C4167B
	for <git@archiver.kernel.org>; Tue,  5 Apr 2022 09:53:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239392AbiDEJxo (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Apr 2022 05:53:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347895AbiDEJ2j (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Apr 2022 05:28:39 -0400
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [IPv6:2600:3c04::f03c:92ff:fe9e:c6d8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DF85DFD62
        for <git@vger.kernel.org>; Tue,  5 Apr 2022 02:15:53 -0700 (PDT)
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:a6ae:7d13:8741:9028])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 1CE635A0EC;
        Tue,  5 Apr 2022 09:15:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1649150153;
        bh=NSjQJnukqLFHUmi1XazPaqJv1z/RSv/zGy+imdaELqs=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=rD3ASpxqLqxatUxWV+97nnSHSLdaThcy/VMRph7HYER+G3X7mlyfDLfCuQQHHzxyW
         eH4hiCtfSXvIeLskIPQgTUQai9FAQ/w6Cy39RG8JkywqaCGDvvvs43EyOgLDQ2NnIM
         dFMgi7DBtU4X9p/9u5TK8hjRZ0NfH7yubQQ+TqJpa8gNAWZYVLN6l5UtKbeS0pg3Z9
         JsF5RgMkTQNm4hwPB4exUK4J3dOWBFFrSFWdPy6SFWarWllk47bEHShqKGM11VuJvX
         tE1SPV6d3FHg8cCmgy/lJOB45W3S5d9Xwr1MgCFJFtGh+VUf7+lhFxNggAfjQlgvoV
         MSU1beP+ULJDzjGvg0Y7MsqOWjMszZBjW0ml/4+agk2NF9hRemhQhkCgJqv3yzl/za
         iRdJ4dc020fX8nEepFhJ3C+Tc+MhKrVF7KjLScCyhFhC3r0PO33Ry5iauRw2luR+KX
         MmfvM3epP7KrA7moFA3K1AbBdulvkrP2pMgG3pKsC53yOMTP50y
Date:   Tue, 5 Apr 2022 09:15:51 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v3 0/4] Importing and exporting stashes to refs
Message-ID: <YkwIuA5dbwf+T2n4@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Phillip Wood <phillip.wood123@gmail.com>
References: <20220310173236.4165310-1-sandals@crustytoothpaste.net>
 <20220403182250.904933-1-sandals@crustytoothpaste.net>
 <xmqqtub9soew.fsf@gitster.g>
 <xmqqpmlxsnc5.fsf@gitster.g>
 <220404.86tub9jql5.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="35AU87It7NFHy14F"
Content-Disposition: inline
In-Reply-To: <220404.86tub9jql5.gmgdl@evledraar.gmail.com>
User-Agent: Mutt/2.1.4 (2021-12-11)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--35AU87It7NFHy14F
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2022-04-04 at 06:20:29, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> I.e. most of that is really feedback/a bug report on [3] and [4],and the
> third hunk here is really an unrelated fix where [4] conflated
> strbuf_reset() with strbuf_release().

Your resolutions seem reasonable.  And yes, I always conflate
strbuf_reset and strbuf_release.

I'll put out a v4 with changes to my series and responses to some other
feedback I've received.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--35AU87It7NFHy14F
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.3.1 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYkwIxwAKCRB8DEliiIei
gVCcAQC2NYtTCUro8dQZ/ZLSW3LR5Jnk+ku5fZpFE5Uf0F0pVgD/QSNnfOAAn1s0
oVCm1U6CleTTWov03dvc2k7lZlSqmAk=
=I1Px
-----END PGP SIGNATURE-----

--35AU87It7NFHy14F--
