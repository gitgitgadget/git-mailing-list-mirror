Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6F8A01F453
	for <e@80x24.org>; Fri, 26 Apr 2019 20:59:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726314AbfDZU7G (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Apr 2019 16:59:06 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:35726 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725966AbfDZU7G (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 26 Apr 2019 16:59:06 -0400
Received: from genre.crustytoothpaste.net (castro.crustytoothpaste.net [75.10.60.170])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id CC25E60458;
        Fri, 26 Apr 2019 20:59:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1556312344;
        bh=piuECw/7/5byBeI4zktNbhfn5Kl4/RTMvInRhCGHV10=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=i7Zu2T1+dTYOqE+0hjxRcZMO/HUgkjcbkcLmJlbJ1DlcuDDaoWwWM6LIj8u/uPJT1
         OXnlMqVY9ZNDuO+h335uqfmEUlpageHRdD8c00R/oIHXiTvcM1YpUgYfUDN26ShWtD
         B0gW5xB/VSfTL57lBGc5lVnHOfjGLySBQVHgJmR1yfiyXaswQzVwQ5OMtAzDD0GYjC
         3GrqL1l1CQK/4pG+qQMWKYDalY9tAxlDhoTqe+YwwQK6+H62cfGT0iZ2mB1eCW3q6z
         l53ozBtpTbw3+SgdhFdCGGs6Hlxou6HJ4R9pm9sdVamfbzUn56pR8MMC7N3CDpZroq
         E7rmWjLaQ0vq+F0wcOwm9dgQzV7n9frlub2fefXOu3arcUGrrOsLimWunr7XGVSbUT
         UykqXEdIg+Lk8lTdc56wCEKL3llz1xAgbt4PObUqIO3f/7FSUcbKbtUEHOCYPuI05e
         wx7q1BM6CU+rRBQTJhP3nbYgOyNknoHR/LjVJZkbshlAl7T4hg5
Date:   Fri, 26 Apr 2019 20:58:59 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Jeff King <peff@peff.net>, Duy Nguyen <pclouds@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/5] run-command: add preliminary support for multiple
 hooks
Message-ID: <20190426205859.GO6316@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Johannes Sixt <j6t@kdbg.org>, Junio C Hamano <gitster@pobox.com>,
        git@vger.kernel.org, Jeff King <peff@peff.net>,
        Duy Nguyen <pclouds@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <20190424004948.728326-1-sandals@crustytoothpaste.net>
 <20190424004948.728326-2-sandals@crustytoothpaste.net>
 <xmqqo94w2l3k.fsf@gitster-ct.c.googlers.com>
 <8f79d251-58d9-f63b-7171-7f1fbd11c6f9@kdbg.org>
 <xmqqo94uzyxa.fsf@gitster-ct.c.googlers.com>
 <2a511c3c-ef8d-07c5-80e2-398780ee6ed4@kdbg.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="/NwG7NuG0/W8LcLh"
Content-Disposition: inline
In-Reply-To: <2a511c3c-ef8d-07c5-80e2-398780ee6ed4@kdbg.org>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.19.0-4-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--/NwG7NuG0/W8LcLh
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 25, 2019 at 09:40:34PM +0200, Johannes Sixt wrote:
> Am 25.04.19 um 02:55 schrieb Junio C Hamano:
> > Johannes Sixt <j6t@kdbg.org> writes:
> >=20
> >> Furthermore, basing a decision on whether a file is executable won't
> >> work on Windows as intended. So, it is better to aim for an existence =
check.
> >=20
> > That is a good point.
> >=20
> > So it may be OK for "do we have a single hook script for this hook
> > name?" to say "no" when the path exists but not executable on
> > POSIXPERM systems, but it is better to say "yes" for consistency
> > across platforms (I think that is one of the reasons why we use
> > .sample suffix these days).
>=20
> All correct.

I would like to point out that we still have to perform an executability
check before we run the hook or we'll get errors printed to the user. As
I mentioned, there are many people with repositories that have the
non-.sample files. For me, any repository older than about five years
will likely have those files.

> > And for the same reason, for the purpose of deciding "because we do
> > not have a single hook script, let's peek into .d directory
> > ourselves", mere presence of the file with that name, regardless of
> > the executable bit, should signal that we should not handle the .d
> > directory.
> >=20
> > IOW, you think access(X_OK) should be more like access(F_OK)?
>=20
> Yes, that's my conclusion.

Right now, we have a standard way to handle the way we handle hooks: if
they are not executable, we warn and pretend there's no hook. With this
new paradigm, we have to check whether the main hook is executable, and
if it's not, we then have to check whether it's present, and if so, we
skip the multiple hooks.

I understand the executable bit is not useful on Windows, but on Unix,
we should be consistent with how we treat the hooks.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--/NwG7NuG0/W8LcLh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.15 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlzDcRIACgkQv1NdgR9S
9ovnKRAAl9N0M2RNZc2Dg9eLmz8zDUrKsN+mR4Ki7wQoihZh/3WqxF8JvgZ7Yvky
cIGV3Ya2yjOeC6TLHK9GEM//OGfQGKiQXoA53/QBXczsBsgFo1T+HDTcCKtHeR60
gI8Br4WOVKWNRBuV63YEUDV6Gzlp7vsY8j7RrrUmfCXtDgDfP3pNQCG3lZ7bvfy7
Gwmcrcccvve7kviYDT03J/pBbB/BCcQIm7vSB0D+JOTBYnEVKkpCzQ5oi/pbkpnD
qvfST8ZvuoU05uAf67oj3myMfeEZ0zCNmmkdDTpFjy6R44lZQPCRD68wIVlCpxLs
/dIyWc+jN8WpSeDLjQiWH6U9fnZsYPs8oRfKxXcFpDoiu3DcbtUCeEpAT4QkqT2S
Kpa2EnDEjR1qVwU0iqBKr4MQqwrjUM9wP55gbOOkNT/+69f//RuPjG5hCqqQUs6e
wrG0FcaHH96ggq8yTHQQJdrRFsDZuZKm6C4WFi5hvGGzb4HlxKkhBooeJzk6WjwA
7Ex2tFjVPTlQIHTm8BICfzkAJ4Z8E066UvVVsXglRenm8lkFA6/2+qE4NsUxr6V0
6TtJOWNln9s6kvjrAnB0HGaO3yOwPTs2c/LJMwFdYOMM42H+ANFYfyuMR5niGR/j
Oal3k0oil7fTPxYztPZBhBtW8kJPwGgWdB8RZN36tzthTFShV4U=
=5zIJ
-----END PGP SIGNATURE-----

--/NwG7NuG0/W8LcLh--
