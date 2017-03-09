Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0DB1D20135
	for <e@80x24.org>; Thu,  9 Mar 2017 01:02:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754760AbdCIBCC (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Mar 2017 20:02:02 -0500
Received: from castro.crustytoothpaste.net ([75.10.60.170]:43704 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754729AbdCIBCB (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 8 Mar 2017 20:02:01 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id AACE5280AD;
        Thu,  9 Mar 2017 01:01:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1489021318;
        bh=04C/rmWghhAvJbusKuZv4heD5fVp3eQHVYvywf7LHEA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XL2XxzcqgZhIr8nrMmwmDizvOsnJXAIhpv2Yf+ePEMt0Xr3ZnJtF4UamtAsDJ57H5
         TbLbWf3uYu64UdnQovM/J+NKhk+E3nznYmOmXDIYWgllNk5UULM7MGAxAaOo5Pl5QV
         LE/hXvQNzlx9GLME7WvWYF+xp8KXYwJPJow3OaKNh5mR1wqBTvEi5/cmuHlKlHFfGg
         VOwvgq6k1r8bm+uNroc+1/kE2wCfURQeMvJ/ZlPYRHAlsM77tUjC9e4DxIKifqcgCP
         wW+Wtt8y9jzHN9HLx2usHupNoxS7/oKcuYazywUW57nON+nRd9L9DEYJ69LLd/qvmh
         aKGugz2bIkDXozbvBzNWl2Rx81gT1B+31FMN88akmopNBzYGoGLPfutyf2ckZZL6mN
         SYmRPzep2nT7oju1+IDQNiSG30QKQjmsReBgZD45f/+iIN035nBN4v5Hg+YWifvMou
         bHbU2T+X80Fa5c3u8VhkO1Ziq8tBDQObJJLefV6j5iJGO84W7s7
Date:   Thu, 9 Mar 2017 01:01:52 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Mar 2017, #03; Wed, 8)
Message-ID: <20170309010152.klyhhth3ekm2iia2@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqqvarjz5yv.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5ukjqcjcnhiv757t"
Content-Disposition: inline
In-Reply-To: <xmqqvarjz5yv.fsf@gitster.mtv.corp.google.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.9.0-2-amd64)
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--5ukjqcjcnhiv757t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 08, 2017 at 03:47:20PM -0800, Junio C Hamano wrote:
> * bc/object-id (2017-02-22) 19 commits
>  - wt-status: convert to struct object_id
>  - builtin/merge-base: convert to struct object_id
>  - Convert object iteration callbacks to struct object_id
>  - sha1_file: introduce an nth_packed_object_oid function
>  - refs: simplify parsing of reflog entries
>  - refs: convert each_reflog_ent_fn to struct object_id
>  - reflog-walk: convert struct reflog_info to struct object_id
>  - builtin/replace: convert to struct object_id
>  - Convert remaining callers of resolve_refdup to object_id
>  - builtin/merge: convert to struct object_id
>  - builtin/clone: convert to struct object_id
>  - builtin/branch: convert to struct object_id
>  - builtin/grep: convert to struct object_id
>  - builtin/fmt-merge-message: convert to struct object_id
>  - builtin/fast-export: convert to struct object_id
>  - builtin/describe: convert to struct object_id
>  - builtin/diff-tree: convert to struct object_id
>  - builtin/commit: convert to struct object_id
>  - hex: introduce parse_oid_hex
>=20
>  "uchar [40]" to "struct object_id" conversion continues.
>=20
>  Now at v5.
>  cf. <20170221234737.894681-1-sandals@crustytoothpaste.net>

Were you expecting more work on this series?  I believe I've addressed
all the review comments that were outstanding, but if I've missed
something, please let me know.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | https://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: https://keybase.io/bk2204

--5ukjqcjcnhiv757t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.1.18 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAljAqYAACgkQv1NdgR9S
9osPYQ/9EJ0h7oBHHgVq4LCz/BOlhD2CDZ/PVoC6lAp2dpLZkVkfHIsS196K/+kP
iGoeIMR8tFzvnhuKv8G/kV4d/Scma8EL4ED2DBi87OaBM6cXxw4A9iEiDxA9683c
vQ1thSUkQ6kZ8tnl6p2SHI5OW5DDiK07YKHgQSi+bn555I+syAYkkfihDDaX9Gsn
QTAS6wnUR/8Ai0kZyJ4f7WcCiOvKM3WjL5ILxk+mf1AYBVRd4fHBgBZCLuUNxEVe
BsHdVEuqDCS5UAxsmoObH3B52CT+UtTUe8ig+3HNXT0VoT5smIj1YfCis65wzADj
sBEf0yP1ise7cb0TI/0iqGYsgRjzjGXPbCWjnJuikjpuGSi48NUj8gDqoImRhy1m
BH7FJNHISnbxpk/ks9HY/TFlizq9Mjr4nCuNJzUKj5QqxybpD5773Cvu4HUMzuaN
0sNGZ092gRzg2nCcK+UTDwfwd5dQlrC4hmUEiYoTBBmkN80D3JF9SL15GdU0HGtB
hS28QKtbMQzTSFNVqe8Cnvw+HfyF/WPRSpjDxaDv546xY9YKC1yxz9qREFHNAsYL
sRc9yTr9xFpP/3RgcfTKh/raTXgbFWIUmhQGXftgvWTOysw3gllWnvuNJWI2lKQK
6ZmG/5v7wNpR1hG9g3hSXS7vC72PkR6E58JQ/6tcyn/dTvG9BwQ=
=4/Ye
-----END PGP SIGNATURE-----

--5ukjqcjcnhiv757t--
