Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B273A1F404
	for <e@80x24.org>; Sat, 27 Jan 2018 00:12:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751599AbeA0AMb (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Jan 2018 19:12:31 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:58324 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751450AbeA0AMa (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 26 Jan 2018 19:12:30 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:e6b3:18ff:fe98:41a3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id B3E4E61382;
        Sat, 27 Jan 2018 00:12:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1517011949;
        bh=JpCRUJXoPdMNuXt5hGij+PGB5UTEZDlqZZUOxu7yHT4=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=HS1XIREzSfFQlB2tdt878UR4W4WfoSyd2XqBGzYbyIQKFtFUQANXUhrjcQI5ZeXL5
         2WCCSLwtjnuS95f0C9ZF7zSibzOgxpkRtDjWN+fjGOdDN/u+kQnVBFaEgMEGW83U8h
         OwlWwb0aX/SkjASkyY8DRWzz7r+tE7tbBelBnydYqptQxarsHcImrtuvKndZ2c+Di/
         gdK8cfa+0rcmPy3POqPEyPbGGWo5u0O7g36rZok6SThji/jsuYLvL8qulwlkWVPgvv
         4t4wEDpnrI+UlxRglyO2HTwmRQVCHJn7FCFWauL/AoVydgs2ByX1jYnokhBAsz3xpH
         Uo4znxw43UtvDql+Lv+ss9Dwy5NwQ+iPZ8orjqBusjCPZtrmqjVMOWOP+fzHCicFHJ
         HpnbJS+L2Bc7Od1TwvGofZ/zKHGPbZSWauabccuujtoExQhR8SnKj1yeUh7mWozz5w
         JOWo0jiX3bineGiEWQZUfGd4yn9KOM5xeB8dsjX9EWIb2+vc44M
Date:   Sat, 27 Jan 2018 00:12:23 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Patryk Obara <patryk.obara@gmail.com>, git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH v3 00/14] Some fixes and bunch of object_id conversions
Message-ID: <20180127001222.GD431130@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>,
        Patryk Obara <patryk.obara@gmail.com>, git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>
References: <cover.1516617960.git.patryk.obara@gmail.com>
 <cover.1516790478.git.patryk.obara@gmail.com>
 <xmqqinbraqa4.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="bajzpZikUji1w+G9"
Content-Disposition: inline
In-Reply-To: <xmqqinbraqa4.fsf@gitster.mtv.corp.google.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.15.0-rc8-amd64)
User-Agent: Mutt/1.9.2 (2017-12-15)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--bajzpZikUji1w+G9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 24, 2018 at 01:41:07PM -0800, Junio C Hamano wrote:
> Patryk Obara <patryk.obara@gmail.com> writes:
>=20
> > Patryk Obara (14):
> >   http-push: improve error log
> >   clang-format: adjust penalty for return type line break
> >   sha1_file: convert pretend_sha1_file to object_id
> >   dir: convert struct sha1_stat to use object_id
> >   sha1_file: convert hash_sha1_file to object_id
> >   cache: clear whole hash buffer with oidclr
> >   match-trees: convert splice_tree to object_id
> >   commit: convert commit_tree* to object_id
> >   notes: convert combine_notes_* to object_id
> >   notes: convert write_notes_tree to object_id
> >   sha1_file: convert write_sha1_file to object_id
> >   sha1_file: convert force_object_loose to object_id
> >   sha1_file: convert write_loose_object to object_id
> >   sha1_file: rename hash_sha1_file_literally
>=20
> These were mostly pleasant read.  I'll queue these on two topic
> branches and wait to see what others say.

Other than the one typo, looks good to me.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
https://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: https://keybase.io/bk2204

--bajzpZikUji1w+G9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.4 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlprw+YACgkQv1NdgR9S
9otJnA//cIxTSBtXRvj7ewkrxbV3aqkJt7JcnYqhuRDua2XAziq6AQcrcOkCtpwf
+IIfYrq9fH5U4MItsTYwv52WxanvRv4/PVjh6eq1ZMqUDdfHYDs4f98htmq++RBN
osG1LHiNCXwAyKqWlFE7ZSfGRcUpF6DDuikqW4zWmlNmZosQ9LMc5vZ5EOdsvSQS
cqKF6t2Tlfl9PkjX7wH2IT/aoKrkCHH78NjdXHK2IoUpPOHpDqpE/ZF8O06nrI+4
kTReqV/qZKULdwVijGYADSOGOUhmbavLt8lq9VtYxdwijyMXjI94c2bzxHIzwbDd
a6FThUussiWnMnkb5j1BZjMJ8k91lp+lCn9APBWaqVrJ6tV2wAvHH+Hs3W9ZJzl1
VOtaO2Ur0kUJBCdh6c0WgBmMaie2bPSYiF7lfYXxzQTkdG1XGAl4EbB67NlOxr6p
UliiACHo1JbhrQTtiZNs1xyEKzQtEZH8nnan1QJgr6rIiZ6zE0zDzG83XqQxumQk
Ct0yFVsuSr5KKFwU+GQHtum4jwP9RkNmZbNUC6axjjap8skiAPXBrIfPvqgvDMxq
6V67r7QRdVWvVSjne86IdiDY7A+dGGUIRDAz3VegrvAWzUntXI0ipaKXyI/hPDNZ
euymy48iHCru0cG6O8Pfn+Ubxe2ITtaN+MORHeSiXNSJCgW8cBU=
=u1fZ
-----END PGP SIGNATURE-----

--bajzpZikUji1w+G9--
