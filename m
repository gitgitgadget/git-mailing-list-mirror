Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 529DFC433F5
	for <git@archiver.kernel.org>; Wed, 10 Nov 2021 19:02:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3895461027
	for <git@archiver.kernel.org>; Wed, 10 Nov 2021 19:02:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233217AbhKJTFb (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Nov 2021 14:05:31 -0500
Received: from hahler.de ([188.40.33.212]:42418 "EHLO elfe.thequod.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233792AbhKJTFH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Nov 2021 14:05:07 -0500
X-Greylist: delayed 430 seconds by postgrey-1.27 at vger.kernel.org; Wed, 10 Nov 2021 14:05:06 EST
Received: from localhost (amavis [10.122.1.24])
        by elfe.thequod.de (Postfix) with ESMTP id 2B3B9620F9
        for <git@vger.kernel.org>; Wed, 10 Nov 2021 19:55:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=thequod.de; h=
        content-type:content-type:subject:subject:from:from
        :content-language:user-agent:mime-version:date:date:message-id
        :received:received; s=postfix2; t=1636570507; bh=rgXl/hDyIeCjFjE
        urrr42EMigNz8El3jvqQPhlBkRUU=; b=AjzkWYxxH2DNx3/76Ec4nkQiGiW2W/o
        pjAJSHQiNjHoSyJjgLmLqcxs5VPlSTGR929INrDo0OEaSsHZsjmuFTbr6XSHSBcu
        V56y5Nj3AqdSApJBTRQgtNC/ESTjLNAqGVZtGXK0wNZKBG3S+2AgVPltHv+pIgRu
        xVyCfHCHg+hY=
Received: from elfe.thequod.de ([10.122.1.25])
        by localhost (amavis.thequod.de [10.122.1.24]) (amavisd-new, port 10026)
        with ESMTP id HRfcASLFyfyz for <git@vger.kernel.org>;
        Wed, 10 Nov 2021 19:55:07 +0100 (CET)
Received: from [192.168.2.107] (dynamic-077-010-017-213.77.10.pool.telefonica.de [77.10.17.213])
        by elfe.thequod.de (Postfix) with ESMTPSA
        for <git@vger.kernel.org>; Wed, 10 Nov 2021 19:55:07 +0100 (CET)
Message-ID: <693b55f9-3c0e-5a31-5a43-d6495d689779@hahler.de>
Date:   Wed, 10 Nov 2021 19:55:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Content-Language: en-GB
To:     git@vger.kernel.org
From:   Daniel Hahler <git@thequod.de>
Subject: [BUG] git-stash does not handle branch name with slash correctly
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------3oU8mZAc9sr1dAOT1DJD8ZX8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------3oU8mZAc9sr1dAOT1DJD8ZX8
Content-Type: multipart/mixed; boundary="------------U3C6CLpN5JSCYkC9DSfcKOdH";
 protected-headers="v1"
From: Daniel Hahler <git@thequod.de>
To: git@vger.kernel.org
Message-ID: <693b55f9-3c0e-5a31-5a43-d6495d689779@hahler.de>
Subject: [BUG] git-stash does not handle branch name with slash correctly

--------------U3C6CLpN5JSCYkC9DSfcKOdH
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

VGhlIGRlZmF1bHQgKGNvbW1pdCkgbWVzc2FnZSB3aGVuIGNyZWF0aW5nIGEgc3Rhc2ggc3Ry
aXBzIHRoZSBiZWdpbm5pbmcgb2YNCmJyYW5jaCBuYW1lcyBpZiB0aGV5IGNvbnRhaW4gYSBz
bGFzaCwNCmUuZy4gIldJUCBvbiAzLjIueDog4oCmIiBpbnN0ZWFkIG9mICJXSVAgb24gc3Rh
YmxlLzMuMi54OiDigKYiDQoNCiBGcm9tIGJ1aWx0aW4vc3Rhc2guYyAoaW4gZG9fY3JlYXRl
X3N0YXNoKToNCg0KCWJyYW5jaF9yZWYgPSByZXNvbHZlX3JlZl91bnNhZmUoIkhFQUQiLCAw
LCBOVUxMLCAmZmxhZ3MpOw0KCWlmIChmbGFncyAmIFJFRl9JU1NZTVJFRikNCgkJYnJhbmNo
X25hbWUgPSBzdHJyY2hyKGJyYW5jaF9yZWYsICcvJykgKyAxOw0KDQoNCldoZXJlYXMgZ2l0
LWxlZ2FjeS1zdGFzaCBoYXMgdGhpcyAoaW4gY3JlYXRlX3N0YXNoKToNCg0KCWlmIGJyYW5j
aD0kKGdpdCBzeW1ib2xpYy1yZWYgLXEgSEVBRCkNCgl0aGVuDQoJCWJyYW5jaD0ke2JyYW5j
aCNyZWZzL2hlYWRzL30NCgllbHNlDQoJCWJyYW5jaD0nKG5vIGJyYW5jaCknDQoJZmkNCglt
c2c9JChwcmludGYgJyVzOiAlcycgIiRicmFuY2giICIkaGVhZCIpDQoNCkkgdGhpbmsgaXQg
c2hvdWxkIGFsc28gc3RyaXAgb25seSAicmVmcy9oZWFkcy8iIG9yIHVzZSBhbm90aGVyIG1l
dGhvZCB0aGF0DQprZWVwcyB0aGUgYnJhbmNoIG5hbWUgaW50YWN0Lg0KDQooSSBoYXZlIG5v
dGljZWQgdGhpcyB3aXRoIGEgc2NyaXB0L2Z1bmN0aW9uIHRoYXQgd2FybnMgbWUgd2hlbiB0
cnlpbmcgdG8NCnBvcCBhIHN0YXNoIHRvIGFub3RoZXIgYnJhbmNoIHRoYW4gd2hlcmUgaXQg
d2FzIHN0YXNoZWQgZnJvbSBpbml0aWFsbHksDQp3aGljaCBwYXJzZXMgb3V0IHRoZSAob3Jp
Z2luYWwpIGJyYW5jaCBuYW1lIGZyb20gdGhpcyBtZXNzYWdlLikNCg0KDQpbU3lzdGVtIElu
Zm9dDQpnaXQgdmVyc2lvbjoNCmdpdCB2ZXJzaW9uIDIuMzMuMQ0K

--------------U3C6CLpN5JSCYkC9DSfcKOdH--

--------------3oU8mZAc9sr1dAOT1DJD8ZX8
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEYyavMIi5wJGyJAsQmBmTlbt44wQFAmGMFYoACgkQmBmTlbt4
4wRWWBAArKdKRly7wMQHMOOfJvQG1GjGtv94g777+qTF2D67VZIKje3KQoiTv7SJ
hlAWfNt7u/8PLMLzL9Vd+AoNNu/HNVEYZKigT621wU0ecnos9mjrcAURdjy3oP5u
azceMMdp9ht78hjly+7cUlSidmKqG3yJKhtN4/lDFNnwuc0MJcxNf09gtbljYTxW
RPT9svGD4iTSeEcWxgf9KAwv10ManwI48Ov4ly+sgXAjfwpLieymCUfzqIOSOtGX
5nqpVEBb/83ODOwdVeGetvfjN9AmaREykytm103lbU5jda8Y00AHFcbhPqtVBkfw
d+1N6Cbaxr7lQ9unLOzvWFNpgWwek/Pr2FLsf7HKA4gjn7cRT1m3blJx+3dizcoR
Ek3/JhHbT/ipQ3Cb9XSoXPLEa2XrZkqQ/y7HW9kqQhhvE+CjJOGm5wi8Kth9EAFZ
BkXWIeET2jNal+FWRfKqTE8tliZNwHSixNpVeGBFyovS52I7TR2zt3dIEfVqAjdC
IrmKio6BAHeTJvdoUtcLDuOvLSQHXrzGLLKvdbnquGQUtfIFb80IHoysRLNLjlAR
8TGvkLJHe8ed04Zuf/XwwPnq/jld4hE5tfNXgGKy92fD4aiXfqkYlvF/pRV10IJd
JJENSNySTYk5EQiJm8tX8YAVI2pWvKMNg4G3zakS+MMX3Bpokt8=
=2pXY
-----END PGP SIGNATURE-----

--------------3oU8mZAc9sr1dAOT1DJD8ZX8--
