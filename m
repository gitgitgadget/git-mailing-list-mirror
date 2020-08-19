Return-Path: <SRS0=/SyM=B5=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88860C433DF
	for <git@archiver.kernel.org>; Wed, 19 Aug 2020 16:44:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 54E6C20888
	for <git@archiver.kernel.org>; Wed, 19 Aug 2020 16:44:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="Zb1bTVsH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727005AbgHSQoR (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Aug 2020 12:44:17 -0400
Received: from mout.web.de ([212.227.15.14]:58365 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726578AbgHSQn6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Aug 2020 12:43:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1597855422;
        bh=AQ/ebxqFqwoWY3/0mXJAHgQCsifLYdDVv38mccjHXxI=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject;
        b=Zb1bTVsHRMLzbCEMpZT7VZAYxIyVkkk22RlNPQ49CiNXs0GEjTF+81I1F1ijDZb1q
         Jao29qUFBtiUs3WRACYDlvT68y8HebAfvMPFByvddFQ1zFVk1WFGGJnLIbL3BTpfqz
         ie51US4DA4OHxiW8grzLj1HUUB4q+uMKOLDuEgBA=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([87.123.206.157]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0Lx73h-1kjegW3VN3-016j9R; Wed, 19
 Aug 2020 18:43:41 +0200
Date:   Wed, 19 Aug 2020 18:43:31 +0200
From:   Lukas Straub <lukasstraub2@web.de>
To:     git <git@vger.kernel.org>
Cc:     Elijah Newren <newren@gmail.com>,
        Brandon Williams <bwilliams.eng@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: [RFC PATCH 0/2] Allow adding .git files and directories
Message-ID: <cover.1597853634.git.lukasstraub2@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/UgTg8h+hmpt1RSi0vanLwkM";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:7mFKShmAB9nd8BlHh/ZR8P632imttyG9vkt1KkdFZk7Uj4u21xn
 yWgDagJ6KT9S63NPRiKicpO3WX2ed/q3EObFM908+rdnSVgRzHPjGo8gi7qChL/IP9lv+WX
 TgxcUOb/s1flbjlqJSGddikOvCyqrKgfJyX9WYQxYKQjYh5ziHN766sWb4TZ1EOzSnlLHKY
 YoQaV4Cvj5dBggE99jeeg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ouqOvqUznJc=:il6iMzr9U4SBwIzLn3eCiB
 k300cVzleKKWd0CED5G9HCr7XHA6/eOus7PwT4PYUylq2bL7h/Qy9PhhDfVU4k3QhEiAz89Ax
 1nrgMbj6D+XHgGuovLhtUBNEGEcJoGNvpgxUkQurGHkmgzR6If39plUw4hvztEBl47XSu32ZC
 /5om2eI5ykIho+0/t7JgDr/+y9Xr5542sb8eveXrOOQPLV1xGCLEQMoCV2PqWwN8q54rvuXMJ
 vc7maOTb6G6cx3SWp8G8TyJdtlc7uiGch6od23ORALpUIPEbAHiKPNfAVWxBPaOFfOsxveWRI
 2AdIhFM1b3i32+VAFyBa8qZAv92hu1KJ2cq8hLm0t6Gbqw/bl2kiphHRh55H0m1c5mB/29QHN
 8gX/Mqz5kDbySkOub07wPhSCHS9LwD8Gnj6lxbhiginIXbcbdrp/QWF8mfw8EzY6gXUJg+fW5
 KzLYKPEMAz10cN6dp+HLzFmc+S/NzxyCkFsl1WThpUx5mak8/5Y11TLJCVB0POisz3sVVyubI
 UtY9jMiTNMKrgqB/9TNPpZJxmj95YnwiFlll0vG/MwBQ5N1/GHEZfEXYhu/AfsNlEZb2KL9Qc
 yRVwaqOD4F29qs+/lWDJ4pC3mM8qwJ3TfFcWJNdQ0hEVdpHfEsfvVxPd0wZnC8faLbaRz2MRV
 T8mgdAn/PwxCwilrfOSjDfmK72cs4eRWzy+SSsjbOSx8e8MrAQXHZORDWkB9KmDOZmRNTG9xg
 R2bl9+qKso8JidgVMgsaduGk2FIsSvCMVcQ1gSCdToCUQfAa47H1w/0F1ETonycGW3Ufongxy
 h3wHvedpeA/zeh2EqqsdbXW5T+zSFOhVoA9MwpItrLIZbdeoJ5Yigg9Whw+KY8L6AD3IEG1+J
 6lWOS5kUmYnbMsxgoSoNg2QJIJOP5omhMkTfzl34h6KcEAeN5GPjwpKU/ZfYDjQ/ddb1RxVBA
 FyAzNrShXFXv3BZwt25dJboSGh6vFyZdT6TUGl4EfUPA+qSJAcyJphZQZE+oXipRQMBmvjRn7
 GuXW1j/jPiU8lHEhsTn4OX06SWo43RxsukYoRst7aB2r9JF+7+2UxS5OJzn/WGq4QJ1T+Y/+a
 GJFiU854u62PrFpW5Y8Z0o1U3DiB53iKJz/2oWGxnEcQ/E3Df+H5cPVZsXtqM2pF4Rkz+FTPa
 9kn9fXxbEQ2mMQxca9qXdqlePlJ+zSorUDAiotDq9YUsk1tehnFKFRu4e7ICoUfml/rxC3vo5
 EopQhuKnIsQbNL7Tum+yfwxNc7xNjp/hF8XoPpg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

--Sig_/UgTg8h+hmpt1RSi0vanLwkM
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hello Everyone,
There have been some requests in the past to allow adding .git files and
directries and nested git repositories as files to a git repository. Usecas=
es
range from including prepared git repos to run tests on to managing arbitra=
ry
files (which may contain git repos) with git/git-annex.

These patches allow this and work well in a quick test. Of course some tests
fail because with this the handling of nested git repos changed. For example
t0008-ignores.sh fails, because in the test repo, the nested git repo is not
added as a submodule and now the files in it aren't ignored.

Now, should the new handling be put behind a configuration variable (allow-=
dotgit?)
or is the change ok as is and the tests should be fixed?

Regards,
Lukas Straub

Lukas Straub (2):
  dir/read-cache: Allow adding .git files and directories
  dir: Recurse into nested git repos if they aren't submodules

 dir.c        |  9 ++++----
 read-cache.c | 59 +++++++++++++++++++++++++++++++---------------------
 2 files changed, 39 insertions(+), 29 deletions(-)

--=20
2.28.0.217.ge805fe7219

--Sig_/UgTg8h+hmpt1RSi0vanLwkM
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAl89VrMACgkQNasLKJxd
sliLhQ/+MIrY4h/3beutiUEkP62oI8XWCXSaaP+odp5C9P6dGVoqAcINWuNDLVGW
izdDeMGIHTIYrnfbOVZZiiwhSA+y0Ced0L8pIUgfES8svhL0aDuUk1hrUWs48Ea8
wJsi58i6V6oOMRPeaF8ccrrP8t+tWe66RnpFnBv84IS6XAV7yR7ftsz8hS8DcMpe
ACNXTvQUnplSOEkUuxDPk31Hg50z917G14MBrC4u1YZoIdv5amVDc6q6vFHBnDwh
5Bhadtht60/rF2P6ua7E/zM8wcNGSXYTSQrcrrMlQ4H74vQbppAPYiPhRujhHKtq
b1G1TM+As8vl4OmaiXADsgLXwpdd4sMZgcVuU3WVotYcbo3kEpc+INBgeBrUjWyM
25RKA2X9aNzPjd9e2T2BIWgefij82FAeYGtvYhkCr+JHpD47At3c128fxFP+0AK1
KUpDdFlZKu0CoO6J2u2XADThYwhVhhpa1efACdnZlqXlGIwkp6XKd5ii2YEb3uKh
9HgOhahjw4CWSUXgxovKjQIOLiSs7aXEnHX44ryvEalHvurCtpiAbMGC6ZP7bx++
5+om/Ub152vaQhfNjLdtEPsE5NOPEj5Mv22V8w6Hq5qMtU3LNLbVIg5SSU1KNOD5
khae7lfg0eP7X+qzkAaCvFg7d5fkJa0oArfxYv3IZwgyHHfONK4=
=KI+F
-----END PGP SIGNATURE-----

--Sig_/UgTg8h+hmpt1RSi0vanLwkM--
