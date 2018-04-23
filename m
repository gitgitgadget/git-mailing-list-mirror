Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 183321F424
	for <e@80x24.org>; Mon, 23 Apr 2018 20:07:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932433AbeDWUHH (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Apr 2018 16:07:07 -0400
Received: from smtp.gentoo.org ([140.211.166.183]:41182 "EHLO smtp.gentoo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932306AbeDWUHG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Apr 2018 16:07:06 -0400
Received: from grubbs.orbis-terrarum.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by smtp.gentoo.org (Postfix) with ESMTPS id E6D54335C61
        for <git@vger.kernel.org>; Mon, 23 Apr 2018 20:07:05 +0000 (UTC)
Received: (qmail 23550 invoked by uid 10000); 23 Apr 2018 20:07:04 -0000
Date:   Mon, 23 Apr 2018 20:07:04 +0000
From:   "Robin H. Johnson" <robbat2@gentoo.org>
To:     =?utf-8?B?TWljaGHFgiBHw7Nybnk=?= <mgorny@gentoo.org>,
        Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [RFC PATCH] checkout: Force matching mtime between files
Message-ID: <robbat2-20180423T200557-844830385Z@orbis-terrarum.net>
References: <20180413170129.15310-1-mgorny@gentoo.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="+mr2ctTDD1GjnQwB"
Content-Disposition: inline
In-Reply-To: <20180413170129.15310-1-mgorny@gentoo.org>
User-Agent: Mutt/1.8.2 (2017-04-18)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--+mr2ctTDD1GjnQwB
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 13, 2018 at 07:01:29PM +0200, Micha=C5=82 G=C3=B3rny wrote:
> Currently git does not control mtimes of files being checked out.  This
> means that the only assumption you could make is that all files created
> or modified within a single checkout action will have mtime between
> start time and end time of this checkout.  The relations between mtimes
> of different files depend on the order in which they are checked out,
> filesystem speed and timestamp precision.
> ...
Junio: ping for review or inclusion of this patch?

--=20
Robin Hugh Johnson
Gentoo Linux: Dev, Infra Lead, Foundation Treasurer
E-Mail   : robbat2@gentoo.org
GnuPG FP : 11ACBA4F 4778E3F6 E4EDF38E B27B944E 34884E85
GnuPG FP : 7D0B3CEB E9B85B1F 825BCECF EE05E6F6 A48F6136

--+mr2ctTDD1GjnQwB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Robbat2 @ Orbis-Terrarum Networks - The text below is a digital signature. If it doesn't make any sense to you, ignore it.

iQKTBAEBCgB9FiEEveu2pS8Vb98xaNkRGTlfI8WIJsQFAlrePOdfFIAAAAAALgAo
aXNzdWVyLWZwckBub3RhdGlvbnMub3BlbnBncC5maWZ0aGhvcnNlbWFuLm5ldEJE
RUJCNkE1MkYxNTZGREYzMTY4RDkxMTE5Mzk1RjIzQzU4ODI2QzQACgkQGTlfI8WI
JsTyaA/+LFxya2x7mHiAtOeoypZcuixImuNZVSgGktUPsXTttEIhlE47lBWQ0Q1d
iG9f+XTymfa3Vjd+wwLnxK/HNyDGKxrlkKH2/g0NfVlsJc0I8VKqX5ZooK2gWVoL
UxrHxbUvP7XhFY5/9OihlOB94q/KI4xGhZ9hByVaaqJulsBu83qCefOd87Hpxg1V
B2U3n3Fvr592KcQpu09tHxkaT/WAHqzrXtxs+jr5CEFYD0WJbON9j6Ze/H9c1ct7
o7s4G8MYLXRN4RFh1fRyV2LA+np53YInJWQaEM6yGe/bxqvcDtiwporhDpB927NQ
bO3vs/Hk2ffBdGXXCA+ps5Mu1Z2s+7yV1Fj//tEQzgreqB5PcRcFPwO5j6xqr6nA
QMhUgBO+mH5JVOtSzHDPpJemQaB7sJdE7JSCVgPZD1HOMF0SCfT8WSaykJsGlQvY
WbSOVWjYpgzxTp5xQaIlnMzD8RSAcapsg9F1ynIcG5t2oxe/vfrOC6/AJ1lZYp/U
0t7y48xkufou6rRUF6QifGJNhqfShISF10lJWm+XEYUmbIAB33qrNdq2k07tba91
lVU2shCxa2b4V6HmgRWissjTm7YTdAP/a+57+VE5hXjnhZZnJyz01Qhk1CShdDsW
y7iULsEgGpLjBAGOf29dRXcFpkwHhkOLnxoD4ewBeADC4Jw4+AY=
=ZiCC
-----END PGP SIGNATURE-----

--+mr2ctTDD1GjnQwB--
