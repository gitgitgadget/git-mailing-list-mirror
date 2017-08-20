Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2584320899
	for <e@80x24.org>; Sun, 20 Aug 2017 20:25:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753239AbdHTUZV (ORCPT <rfc822;e@80x24.org>);
        Sun, 20 Aug 2017 16:25:21 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:56948 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753191AbdHTUZU (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 20 Aug 2017 16:25:20 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 388D0280AD;
        Sun, 20 Aug 2017 20:25:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1503260718;
        bh=d2zuAnzxl19087W28DNOBxG88L5SDEKw9/Rj5UKRR1M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=j2+9iXVJtODjv/wBdo5+vEHz1ldd+AklFFFepnaKD61mVcMwXFY3yQXTys/POUYha
         ECPXz7rvGuJGttUBSIJ3+Qz2lHVLlJuNv/qccwazZs/aUpGncYlK+RcSiwFJdedo2K
         QUyvB1lPG/k6ZZozV8t5juh/R49Iyzh+9KSXCVabkvvivxHahkDQoOcpCTxISaUOUi
         6bRi0OYtl4NxbrGVrx/3pTxAJGipRFfovX723u2Na/pJEXpTxQHqZVYrXNJKW9JCOW
         mFoaZvb0JvHngqayCKk9FE6Tad04aVik98LAbAPbnat0WkucNBEUojstNFwMaPF1mP
         flZ+A5mS3oLIiDCSedVDElB6kdXeaNK7IW3ocBBExrbE61OFfBIcgjhWhV0huf1ZRt
         v2Mz8OSOtGYi72eWUU61C/AxxYxA+/OcgKFzWCkcgyCv7KYJZezMxqZASbAgCrjNvW
         3WeCPMGsDBb/vEQDoTCcT/e9u0RXIxvFYqaCrRELtzQBcMDeOOq
Date:   Sun, 20 Aug 2017 20:25:11 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Patryk Obara <patryk.obara@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/6] Convert hash-object to struct object_id
Message-ID: <20170820202511.m23njssyika5ufa6@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Patryk Obara <patryk.obara@gmail.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>
References: <cover.1503258223.git.patryk.obara@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7zif7dphglzntqff"
Content-Disposition: inline
In-Reply-To: <cover.1503258223.git.patryk.obara@gmail.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.11.0-2-amd64)
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--7zif7dphglzntqff
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 20, 2017 at 10:09:25PM +0200, Patryk Obara wrote:
> This enabled conversion of few functions in sha1_file, which
> had almost all callers converted already.
>=20
> I hope I'm not stepping on anyone's toes with this patch series.
> If I do - is there some email thread or document in which I can
> coordinate with other developers, regarding which code regions
> are being converted to struct object_id next?

We don't have a coordinated thread at the moment.  You can see what I'm
working on at https://github.com/bk2204/git.git in the object-id-part10
and object-id-part11 branches (based on an older next).

However, having said that, I don't mind if you or others pick up various
parts of the codebase.  At worst, I drop a few patches for things others
have already converted.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
https://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: https://keybase.io/bk2204

--7zif7dphglzntqff
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.1.23 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlmZ8CcACgkQv1NdgR9S
9ovuZA/+JKB54zpjyFAzMNTssQOCsB3O2sAsubnGmIrwyXCSa3YWtM4svJFk8jjm
tq3j3w9unqJ8odddYT0X1V3NjkxCLbq9lawKVPxSZeASpBDE6aAvNi4cfiBXlI/x
/41//9K3d6DAFC3mJO6YPv9CR1ET6Vn6GVNAv+SPmsaTMbtr4KRPuzbBZir7EScx
GlsQ6XMJrbxFwzDv9CV4RfpUpECeFNZ2kPdRqbx9ZG1/Cj66t9ulKBcYnOHNR2Li
YJN71RamimcWi3py3kKnGuqGdJDacLWlaaJipHhCidx9uhZRJuuZ7m2dZV/P/EDm
p02Er9DfDjLCNlw5S27teLZM1BZmqHLrt4daK3hGrqogLUqLI+Apqz4SRHnbRvoI
6R3Jqsc1Lq+lJ25yiy+4ETa6L2+6DIZmsxfaE1evIqXegdiChXw5y0LFPWByFO0o
vZgl0DCxBe2fJHS8NZan5xTY61bQ7aK0Ee4k0Drm5DP0+meEYBwgg/0InqIXtGfV
i7Gt3XC90yal3/CcYG/TuFwJFXPPtlLRmeMZyHaWkMDUBHznFyqFF8fChPGkcJTw
Crol5PmlVag4VAUzwewPNSJM9D8eaBhtUM6GJ1WMAvExHIio/NX7ja9jx/jXSJIp
nW63sMUNph3sPHt+F6m8sPrXvsEzA5/rNe/tWgVdCSxhTMQE/go=
=PBh7
-----END PGP SIGNATURE-----

--7zif7dphglzntqff--
