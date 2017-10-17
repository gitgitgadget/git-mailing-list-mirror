Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EB304202A2
	for <e@80x24.org>; Tue, 17 Oct 2017 01:34:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756495AbdJQBeN (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Oct 2017 21:34:13 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:55330 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1756481AbdJQBeM (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 16 Oct 2017 21:34:12 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id E34CC60448;
        Tue, 17 Oct 2017 01:34:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1508204051;
        bh=J4MnhXlc1S+nRzgRca/USQTqPObhhPbrC5CIcQ3WyvM=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=I6i+PY5nuP1W5KGGTwlwnqbyINgt0f8f4jUnyZ08J5bxgFhHM4Vxrki4/Sq+LfGVz
         aB2gleY6cn78cm2S7I0c+1ifiTQUK5tu2n2nSo5hEoEDRhzx7U9GU5vdjkUilD8NZH
         rA+v5+e8hhcwT2YGeST5PYipN2E+T7thmiTqCg6aHPbHfObvZLGkPPIVC0q/CgG9b6
         KcQ+NYcI5VYzTHjyGakPlzoNnrhz8k9hm5H8IfM/3PusVv2peR6o1Z8Jk937fs8BHu
         GYCVWM1NzjOlT+kqFI7/tv6pnRLAngirIqTAX/X6RAtqEgL4sFbuBka0arB+GPvM9h
         b7N8H//9DdlUd9j69ziGmdtL7guSSZOyz0iNNpuRaj/ySSWKcn2XNm/2PJbqmHHncK
         2JvXWE7bhM5z0nrbs6weeeMduF2mwDxPoQJIoqDfxEpno0LvS/hlCTMFnz0BM3hBpY
         8hZm93AkrPqWboN42WYZX4PmSub8pRNEE/n9PqiKkiKMo1isdvw
Date:   Tue, 17 Oct 2017 01:34:05 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Oct 2017, #03; Mon, 16)
Message-ID: <20171017013405.swzjqc3rwvqjfkov@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqqefq3shtr.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="nyon4f2ehsbpfegm"
Content-Disposition: inline
In-Reply-To: <xmqqefq3shtr.fsf@gitster.mtv.corp.google.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.12.0-2-amd64)
User-Agent: NeoMutt/20170609 (1.8.3)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--nyon4f2ehsbpfegm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 16, 2017 at 03:54:56PM +0900, Junio C Hamano wrote:
> * bc/hash-algo (2017-10-04) 6 commits
>  - fixup! hash-algo: integrate hash algorithm support with repo setup
>  - hash-algo: switch empty tree and blob lookups to use hash abstraction
>  - hash-algo: integrate hash algorithm support with repo setup
>  - hash-algo: add structure representing hash algorithm
>  - setup: expose enumerated repo info
>  - Merge branch 'bc/vcs-svn-cleanup' into bc/hash-algo
>=20
>  RFC
>  cf. <20170821000022.26729-1-sandals@crustytoothpaste.net>

I do plan to reroll this, but might not get to it for a while.  Since it
breaks compilation with ASan and friends, feel free to drop it if that
is convenient for you or others, and I'll resubmit with some fixes.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
https://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: https://keybase.io/bk2204

--nyon4f2ehsbpfegm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.1 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlnlXgwACgkQv1NdgR9S
9otx/BAAk6zJXR3gw2qHgZkX6Gq8kDF149wLdoqMo02Da5NiFzsyMzzWb21U0alC
w561SwQD1KNOYhNQXlt1bgmuG+33tgrX5JW3l+QBWqjNpp/WS3eEJ5BkdrpHWRXQ
A39glmRdi/2H+v+I3MshfyJcWpmH405XDZNAFnkf/bm8XcIWqY+SWUtw6Enug+p3
ASJ4TwVhQRKxp30tYuwueVh6dV5NYdlEXanaz2CTkWevvewFbXQm9NVWrGuBvHdF
EKBHX1qh3PXWwbkpIEnSoPl6Ji5U9+Xi/DinmQJVLKrPfplPRDBTeyKR6BS6uW6u
fPNDIWMYIXzX5TF7oZ/iUR9dyAyGM/9Fbcgg3NpPFIHsaUwEHjxcLtttpmn8ycWP
9GkxikSxV089P5JVXMPZ9wa92HdaZRg4qSgo5Y3fbrzb6Upt17Ks+XFc6fEHslZR
6+6U8GDZwRkZkBwqOF7z+De3sLg4JyBCZTr2ozYoRSNIli7dSES/47AKXrjHTO8q
PeNpLZFIZXxLNucXQNqxGWnuI19eADDd+eJJG2ZbBSALYwYMIZpXntAs3b6yOyFE
rM3lR3Va9xq6Y5Tlck8i8A3W7JdW+HVgByhHv41MVHZVXpedtYIZU0JYCmgEl05o
pRdviAcPfiCTqMueHGnG+CVaatlVAFQHJSmkc1EVEOcXUPtUi0M=
=KNvY
-----END PGP SIGNATURE-----

--nyon4f2ehsbpfegm--
