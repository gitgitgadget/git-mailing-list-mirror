Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8604E2021E
	for <e@80x24.org>; Mon, 31 Oct 2016 23:16:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S947936AbcJaXQY (ORCPT <rfc822;e@80x24.org>);
        Mon, 31 Oct 2016 19:16:24 -0400
Received: from zucker.schokokeks.org ([178.63.68.96]:55595 "EHLO
        zucker.schokokeks.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S947923AbcJaXQX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Oct 2016 19:16:23 -0400
Received: from localhost ([::1])
  (AUTH: PLAIN simon@ruderich.org, TLS: TLSv1/SSLv3,256bits,ECDHE-RSA-AES256-GCM-SHA384)
  by zucker.schokokeks.org with ESMTPSA; Tue, 01 Nov 2016 00:16:21 +0100
  id 000000000000007E.000000005817D0C5.00001C75
Date:   Tue, 1 Nov 2016 00:16:21 +0100
From:   Simon Ruderich <simon@ruderich.org>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [ANNOUNCE] Git v2.11.0-rc0
Message-ID: <20161031231620.ewhdy2zwgzlczy5o@ruderich.org>
References: <xmqq1sywrxxl.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512; protocol="application/pgp-signature"; boundary="=_zucker.schokokeks.org-7285-1477955781-0001-2"
Content-Disposition: inline
In-Reply-To: <xmqq1sywrxxl.fsf@gitster.mtv.corp.google.com>
User-Agent: NeoMutt/20161014 (1.7.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_zucker.schokokeks.org-7285-1477955781-0001-2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 31, 2016 at 02:49:42PM -0700, Junio C Hamano wrote:
> [snip]

Hello,

I noticed a few minor typos in the changelog.

>  * The default abbreviation length, which has historically been 7, now
>    scales as the repository grows, using the approximate number of
>    objects in the reopsitory and a bit of math around the birthday
                    ^^^^^^^^^^
                    repository

>    paradox.  The logic suggests to use 12 hexdigits for the Linux
>    kernel, and 9 to 10 for Git itself.
>
>
> Updates since v2.10
> -------------------
>
> [snip]
>
>  * "git clone --resurse-submodules --reference $path $URL" is a way to
                  ^^^^^^^
                  recurse

>    reduce network transfer cost by borrowing objects in an existing
>    $path repository when cloning the superproject from $URL; it
>    learned to also peek into $path for presense of corresponding
                                         ^^^^^^^^
                                         presence

> [snip]
>
>  * Output from "git diff" can be made easier to read by selecting
>    which lines are common and which lines are added/deleted
>    intelligently when the lines before and after the changed section
>    are the same.  A command line option is added to help with the
>    experiment to find a good heuristics.

Maybe the name of the command line option should be added here.

Regards
Simon
--=20
+ privacy is necessary
+ using gnupg http://gnupg.org
+ public key id: 0x92FEFDB7E44C32F9

--=_zucker.schokokeks.org-7285-1477955781-0001-2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCgAGBQJYF9DAAAoJEJL+/bfkTDL5lyoP/i5ECvBbikaxUUR8hfpY9AcH
EjSoYv/Nml/gizgY8bmCLRCnZ7zfbGTLrrIVYdDQWwdmFddswKu8c7fvlc5e3Pf8
esBg5Nj8NFouCrV+zE/b2bnd7udHUOCD6XKyg9zAuHwMcwxGbUX/PQhW4fwWqsC2
C3/U83JudGDG4Dc3ra2zVry3Zf75kllvFrzcliaqxbXLJtX/HKiOo0kqGZrjNHWQ
cBUvAK/xhehheR9D5kv8Z1J+HE5eFpqzGBZjzoxTioqZciYenOcl4pebfDva3PHC
JspnS3kxKAOMYcUtIGfMAoigfiAB9URUp21dWNXiFhDJ0efFl22C/B7WXDB2gYm4
fmxO3E4m97l/O/Ljmxsbu6ZubJjTeOWojU3oUh5LsOb1xNoWvpVH12zkKVkOoeZr
c3TsqWAiOJkqZm/8VAHCZKAbEuESUWmJ6IY+WfIBMK4MV67ztCXWVVpN8AVS5D3h
UkoZCDpU1xT8r80S0Ir8xZ1DVXJtvCLzVnjuNmZY4BhfckEc8RPpW6goV7PpZZyn
dbWvEOmMKri/eOKEynBcTJrcPp8EX2owXdrmMFr1+ktYm7Vay5YVQFNfubrVHVET
eGiWsl93sIIivkjct+br22k6UtFFYtSqSaHkw7pac8FRvFmbCjl+4007AOE3hHM1
WCjudgkZJ4fmVx/ZMnTr
=7Un6
-----END PGP SIGNATURE-----

--=_zucker.schokokeks.org-7285-1477955781-0001-2--
