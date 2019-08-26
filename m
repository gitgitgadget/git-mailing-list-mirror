Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2B5381F461
	for <e@80x24.org>; Mon, 26 Aug 2019 23:07:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726663AbfHZXHL (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Aug 2019 19:07:11 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:58366 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726278AbfHZXHK (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 26 Aug 2019 19:07:10 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:60b7:b124:ccfa:d51])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id D9BBF6140C;
        Mon, 26 Aug 2019 23:07:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1566860829;
        bh=/sUxyGf1WzF7M2aUAreejJCzcBZ/sKUx2EQKxEGOe+U=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=XfgVjMfLmRDRwyRrw+vULPE4IblTe74ggNA9MCTRGrz4FQy545vR3XtngbBzNvxlx
         DKeO4wisLvLkkTNGFX/vvP/KKoq7eJb0aIXQcQNqOLIUQPmIUNvLm0+L7pslRj82nT
         3tsGCrpjmep/vc7Sq5K8GW9orfd0Gj25NtJiMO3RS//F38YJHzIWSrdxAn8HfAL3cW
         fCMLmQV3YomWNqTZMVIMXRP+PkBX/tvbWzARVhJrYTa0loEdrbsDkF3ufWKWybUQJE
         BH4MsoPi9qUMQCGo707PbV+CKiRD5sKjKXx758+f6nyF1YOm2PE/gG88GT2p0eYThV
         Gt0Tljx72ZapD7xnFey3Jxv1L3v5Z+y95127j9Q3TxyBM+pGu91pUsaVBGdAjNTYjH
         WABPwTtt0hqF8oEfuyYm/S2KTQejCEwTeiYPgqxPSNPmbFRhFVg+cBz4vNjJdkX664
         tNGS4bDzag5CxVF2QucdEFRqsAvxda8czvyGgcAqZnwnzNFNzwc
Date:   Mon, 26 Aug 2019 23:07:04 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Ibrahim El <ibrahim.el@pm.me>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 5/5] Signing API: Duplicated signing tests using new
 config aliases
Message-ID: <20190826230704.GC11334@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Ibrahim El <ibrahim.el@pm.me>, git@vger.kernel.org
References: <xidzc1zBudSNNUInNKpDPgAw3AlwtABPT9VpKuPpAfVodvQejHn5WHIYTrqlMlJEYB11iMVhxNCQKBnx7phcHaiPQhHLaqKgeVZwPTCx4n4=@pm.me>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="QRj9sO5tAVLaXnSD"
Content-Disposition: inline
In-Reply-To: <xidzc1zBudSNNUInNKpDPgAw3AlwtABPT9VpKuPpAfVodvQejHn5WHIYTrqlMlJEYB11iMVhxNCQKBnx7phcHaiPQhHLaqKgeVZwPTCx4n4=@pm.me>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.19.0-5-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--QRj9sO5tAVLaXnSD
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2019-08-26 at 19:58:10, Ibrahim El wrote:
> From: Ibrahim El Rhezzali <ibrahim.el@pm.me>
>=20
> c6a1d1c21 Duplicated signing tests using new config aliases
>=20
> Duplicating existing tests that are signature related and updating them t=
o use the new config aliases

I don't think we want to duplicate all of these tests.  Perhaps we could
add a small number of additional tests in an existing signing test that
makes sure both the new and the old configuration work as expected, and
assume that the entire codebase will honor those config settings.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--QRj9sO5tAVLaXnSD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.17 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAl1kZhgACgkQv1NdgR9S
9ossAQ//Y6c6bVAuL/l6OCs7p5eNer9xtU80awInGeY0JCd9ox8PpohCpBlfRDSP
y8m+AgvKPscmAHezC6A5s3Zx9EB0oinnTvMS3qcdI1OAtCbFaz/9JJ7cn5xJOacE
fNvQgsFH+H4hlwdoFGn0EZDoHTBbvNf5L5C7LitopefKj1R8TJRP/s7+eLIPB/s7
M2x6AJe376UF2G0/v4jQ0ybAYfC2L7dbPRYQP7BDf2u0lED6Itw8UqRXot2xodG4
9b73ULNPeOD6URWmU3j8HHGIsstTyEMHVYq6gDTc10ewBEASzkRErFt0/G3E9EH+
CMhg8eIrK/L+1nYSY4s23ncTqZxnFnRyxEP7hRURfZWabBceMzLHjBT4Q0D1YR1k
8UDUuepOFmG5EyXy8NrQJ0uq3EK/z/AqoCAiCIh4bLJdjcUk+y8VKtKFj+MtrYHD
J+bh0y1Dyt4HETnPlYYuIRWkSAxQE94rYHEUx9ZkRudsYdHX4RHO3yESpybtqtv/
qjMFbdKf+HrMWL27kcye+ZlfElKuC4TdNWOAaNKxK3a0tigWmwW1YhVw2uyp795M
X8q23K8B7tXTlxEbHGXK2tGn+TxCMYnxG1b6Tgp8YwKn0T2VWznfCtuKIXwMAzcW
/0gnErD2kdd/onREPkxjIfXPr90YMQlNScKEUaVEsvPNTypKjTQ=
=iPrw
-----END PGP SIGNATURE-----

--QRj9sO5tAVLaXnSD--
