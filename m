Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 44E081F453
	for <e@80x24.org>; Thu, 18 Oct 2018 00:06:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727258AbeJRIEg (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Oct 2018 04:04:36 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:51306 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727090AbeJRIEg (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 18 Oct 2018 04:04:36 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:90d0:bd19:fb95:28cb])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id A218961B72;
        Thu, 18 Oct 2018 00:06:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1539821184;
        bh=m+iiWCrndwyofBAweyFSM4C6gcFwVH7H2XB7Ap4i1HU=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=u+PMHaJg9ZQtULVOqK/LW0T3smRl3I0PBEgjh7qyvR6XczTLtwe0Pv2epV4G3cina
         aU/z5Hn2NMGncXfKjncjS+/3phxvjhnMfM+eb9++aEgl9QbsdbGdQCHN44g8zjs0sS
         LkDaZisQnGL9TWAVWysJtB6Kn2/i8Rmnvto1d3eOQrefpO/8+awUWc4aUElRxy6ZGz
         y6zy55hwuPhVyQ2dcc2TAw0t8tqtXgQnEVippfaRuOzN1d8uJHqNlFk12OUrySgxS2
         WgZ51rC+W9MA3TyT6nxDZlAHYgjeLFHfC3Nv3ImLcQuQ9LBn5k6CN8+m0MvLYYH735
         as5nOv/JXsV09qdmrk4niZUnclOtIu26Wxar7piFUvLPym0HJSfERVyPHXLNPcX7l0
         QYp+ecuGq+FeEgUdOkey1CQ7046dmN9bNxL/9PwalaXiiJc4zAF5tj7yNugOgiiDRx
         tLw5vfwpv9bN8FsgOOUGezcBmr4DERQnlT/eoLE2eEQeGLB4C3Q
Date:   Thu, 18 Oct 2018 00:06:19 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Derrick Stolee <stolee@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v2 13/13] commit-graph: specify OID version for SHA-256
Message-ID: <20181018000618.GM432229@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Duy Nguyen <pclouds@gmail.com>, Derrick Stolee <stolee@gmail.com>,
        Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
References: <20181015021900.1030041-1-sandals@crustytoothpaste.net>
 <20181015021900.1030041-14-sandals@crustytoothpaste.net>
 <CACsJy8C6o9PAHsm+t7Rijg6jsz5dXZ5pT79nYGdGbKuK6gGTLQ@mail.gmail.com>
 <fbd59390-42ee-8c06-74b7-1e7081680913@gmail.com>
 <CACsJy8Bg6BpQp4dDXzs8Y_d6RHW9ti4+FLqnAqGwW8F-SWUnPg@mail.gmail.com>
 <20181016224404.GD432229@genre.crustytoothpaste.net>
 <CACsJy8C9nySzG0Uqs6_5V2rXHkAKr-ShXU7N9sPp4N5z=D0zQA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="nV0Xx5nODoP5kWxY"
Content-Disposition: inline
In-Reply-To: <CACsJy8C9nySzG0Uqs6_5V2rXHkAKr-ShXU7N9sPp4N5z=D0zQA@mail.gmail.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.17.0-1-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--nV0Xx5nODoP5kWxY
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 17, 2018 at 04:31:19PM +0200, Duy Nguyen wrote:
> On Wed, Oct 17, 2018 at 12:44 AM brian m. carlson
> <sandals@crustytoothpaste.net> wrote:
> > Honestly, anything in the .git directory that is not the v3 pack indexes
> > or the loose object file should be in exactly one hash algorithm.  We
> > could simply just leave this value at 1 all the time and ignore the
> > field, since we already know what algorithm it will use.
>=20
> In this particular case, I agree, but not as a general principle. It's
> nice to have independence for fsck-like tools. I don't know if we have
> a tool that simply validates commit-graph file format (and not trying
> to access any real object). But for such a tool, I guess we can just
> pass the hash algorithm from command line. The user would have to
> guess a bit.

I'm going to drop this patch for now.  I'll send a follow-up series
later which bumps the format version for this and the multi-pack index
and serializes them with the four-byte value.  I probably should have
caught this earlier, but unfortunately I don't always have the time to
look at every series that hits the list.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--nV0Xx5nODoP5kWxY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.10 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlvHznoACgkQv1NdgR9S
9ovFWQ//eVJh1IUIY5lJRpCYUTmonx6og0rG7zo1eIiH3PJGhHMN4BRkjut2hgfi
jbiuOT3iEwWlORFTAJdKxk5EhCJMi1MwydmVWNjR4U/NvZkzf7VKpoCuJemOZ73q
F7QOifjPOc/9H/xLW+nb9yFGGWMgMj4hSrVCdnQ1D6p/L2pBQHytFWOUt9mmvn3r
fhZG1c+yRijyJiBp7JTnA5yul0/DqNtewq/Cd31Zl9Y2lg2TNF5Wlw7jxul7ECM+
/8V/9jsjsWAfawZruW3i8KZvdYkFfLgJ10Htlo6euER4E+BshDqHnWEdcvLrg42D
joI5sspP5TSTcM6lTeZPZrFZ5XQH7Agq+3oDeUDYtEpXW+yP5gqNkxYtCjiCkeao
XLnRXFe0m7oI9NFXD5bfwt+C4hWYrxfgvOc20TqNCzxZLhoTk7/Z8x6bVa6/jgjv
/UzVKj/MYr4LxJBzOSLUxctoKtS2IWrX9Zxo3gg3VkXYci5ndoTUKCJYtJ1mjH8V
29dq5m5fKvSdgFMQ5z3vTOzepFQiA91gIrw2wbu/lWpjJrYatbQ5+VeLZ5pusUfW
3ecK6pNXtWyNdin9qTEpflMK64UAqhPyitvQB005VLF2qt3m9v/tn30TxNywGYt/
hgsJYfFuNUhtKtd/c3h5eG78N9CmmIdy4qltaBbeWB29h9dxL58=
=VS6Q
-----END PGP SIGNATURE-----

--nV0Xx5nODoP5kWxY--
