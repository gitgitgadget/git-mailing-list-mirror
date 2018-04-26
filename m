Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 47B721F424
	for <e@80x24.org>; Thu, 26 Apr 2018 01:13:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751528AbeDZBNp (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Apr 2018 21:13:45 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:33884 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751435AbeDZBNn (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 25 Apr 2018 21:13:43 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:e6b3:18ff:fe98:41a3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 72DDB60400;
        Thu, 26 Apr 2018 01:13:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1524705222;
        bh=Rb9SUmKx+ID2BMwCSDwyETZq1xwXa3jZkcDAIbG5NeU=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=WjrIrs5anWb5jk7+OLBUCjr4ldIC4EgN3MYufKWuVDXA8d5HtlC1awq6/P/DtvDm/
         7oXdPySdUHNBIFfkTPbCIEXGlog/Lc7uO6zT/kS/MjvVmfgakKkMNG6XgjabDYhkju
         0Ym3/HjaM+H+b+TsvbROYtExj/ueglmMWQgmGD/dLVfDK9JijAe+OrLoLJSpzbU/QL
         pqLzBpOZYIoDakmzQwR0/N7O2noA2q/HkG59kE/ZlxIBhc8xKyfbBu/1B6BFcGNP12
         Y8oDuiZim1VaCcOn9esAEaRlUytn18rc1+1Z8T/6L+gr9mmoidQnIMOFXGuc4G/GCn
         GYnVNtDdnU+B+Y4suSjwSflfZvMte7/0U/iDNki6xtBlIdHFzB/eDv97M5/JRv1Kgo
         hHLn3AwP3LsAPeHENxKTDKDcdNiKqjvhRn4ItL1oSERu02lii9fdHJUzpVZbEbmpLU
         y7hKC7fa8mLRtH0Vpc+x/b+Mmy17zlWd7JWjRAs46kT5loQLP1J
Date:   Thu, 26 Apr 2018 01:13:37 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Apr 2018, #03; Wed, 25)
Message-ID: <20180426011337.GA722934@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqqmuxr4r6n.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="dDRMvlgZJXvWKvBx"
Content-Disposition: inline
In-Reply-To: <xmqqmuxr4r6n.fsf@gitster-ct.c.googlers.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.16.0-trunk-amd64)
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--dDRMvlgZJXvWKvBx
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 25, 2018 at 05:37:52PM +0900, Junio C Hamano wrote:
> * bc/object-id (2018-04-24) 41 commits
>  - merge-one-file: compute empty blob object ID
>  - add--interactive: compute the empty tree value
>  - Update shell scripts to compute empty tree object ID
>  - sha1_file: only expose empty object constants through git_hash_algo
>  - dir: use the_hash_algo for empty blob object ID
>  - sequencer: use the_hash_algo for empty tree object ID
>  - cache-tree: use is_empty_tree_oid
>  - sha1_file: convert cached object code to struct object_id
>  - builtin/reset: convert use of EMPTY_TREE_SHA1_BIN
>  - builtin/receive-pack: convert one use of EMPTY_TREE_SHA1_HEX
>  - wt-status: convert two uses of EMPTY_TREE_SHA1_HEX
>  - submodule: convert several uses of EMPTY_TREE_SHA1_HEX
>  - sequencer: convert one use of EMPTY_TREE_SHA1_HEX
>  - merge: convert empty tree constant to the_hash_algo
>  - builtin/merge: switch tree functions to use object_id
>  - builtin/am: convert uses of EMPTY_TREE_SHA1_BIN to the_hash_algo
>  - builtin/receive-pack: avoid hard-coded constants for push certs
>  - diff: specify abbreviation size in terms of the_hash_algo
>  - upload-pack: replace use of several hard-coded constants
>  - revision: replace use of hard-coded constants
>  - http: eliminate hard-coded constants
>  - dir: convert struct untracked_cache_dir to object_id
>  - commit: convert uses of get_sha1_hex to get_oid_hex
>  - index-pack: abstract away hash function constant
>  - pack-redundant: convert linked lists to use struct object_id
>  - Update struct index_state to use struct object_id
>  - split-index: convert struct split_index to object_id
>  - submodule-config: convert structures to object_id
>  - fsck: convert static functions to struct object_id
>  - tree-walk: convert get_tree_entry_follow_symlinks to object_id
>  - tree-walk: avoid hard-coded 20 constant
>  - pack-redundant: abstract away hash algorithm
>  - pack-objects: abstract away hash algorithm
>  - packfile: abstract away hash constant values
>  - packfile: convert find_pack_entry to object_id
>  - sha1_file: convert freshen functions to object_id
>  - packfile: convert has_sha1_pack to object_id
>  - packfile: remove unused member from struct pack_entry
>  - Remove unused member in struct object_context
>  - server-info: remove unused members from struct pack_info
>  - cache: add a function to read an object ID from a buffer
>=20
>  Conversion from uchar[20] to struct object_id continues.

I do plan to reroll this, and if you want to forge my sign-off on the
patch I missed in the mean time, please do.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--dDRMvlgZJXvWKvBx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.5 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlrhJ8AACgkQv1NdgR9S
9ouIohAAvdK5ULZsFVr2YJcxdyFLSo+KuvUnR1tx4SP1hXDGu+iCutwWlzPUMVFe
XQ5lr9uGXDViDlSNCnpjN4DKCmM1PNH2mL7DMQOnzYOg+72geEVgIDpbgidsnpMP
soSv8Nj/+7RP1CPprx5IEkmSrBFVIP4D8dVcHG9zuQrdddDpO8uQ+6pPKD1NWQ24
jo0jAMl7HBNUf5oFL0ctJJqLseUqDczy+iJnh6Lp++qxz3bPJwAh+AChh3neWpi9
ivumeOSX9lcMVq1YUoCalxslcCY0Ii+3rotnznj0oWPhIZB57YRechHW0VtQwVfg
KDHT7NpSqIJ7UFvmv9ED0pfnnK3krOnLg3jKy64LoGhwdeIPwbCJZHWxROzwp5K9
vYgcPXagM9XSy8CaDF45iV9+A6+CciSDOzDBqlUnw3HpbnwsCRIggxe7d6x28jb2
5vsTq3/HEjlFFvK7cvuQElX3mkH6y9B6No/s5fL/k4ogT2aIUHxwJBM0lDAC/xfP
cF6ABKTssNHA9oPhWYrAZXJaTW/ihkEXT626Tpt9gwyUEB/GAarqQgts964JjlYA
kPoYhE2ztjxUc6F2AN54F3FIQm0/M0bEEB7d8kq5c3nR6QqrPPxRBSj2Ymv4fXrY
AWsWynUbJuSKf0t6a77OKqhPbOL2/qfcSsHX0qCFODhk1TyYpo0=
=Vub/
-----END PGP SIGNATURE-----

--dDRMvlgZJXvWKvBx--
