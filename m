Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=unavailable
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 730701F4B5
	for <e@80x24.org>; Tue, 12 Nov 2019 18:36:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727064AbfKLSgt (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Nov 2019 13:36:49 -0500
Received: from mout.web.de ([212.227.17.12]:54685 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726985AbfKLSgt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Nov 2019 13:36:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1573583807;
        bh=Gato5DE8UFRQGKB4f4CRHZjZrVMxI8pNLP1qKnQWeTM=;
        h=X-UI-Sender-Class:To:Cc:From:Subject:Date;
        b=l3Gy/pNcsuHa9mGcrX+wpW+E/880Ap04QyG0zaaK6CL33Hv4FdCwnHVEAe7tWhIRv
         TBk0KkUKjabRTRYjpukfF4fjR/g8M1B7+yX0fEPqubvcw+0Y98CPY/pZWJP6ty2otS
         DxmUQh8/xWoQsGvqN7IZQzt3mGcm4mvYeKTqxmVw=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([78.49.102.255]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MVLak-1iOQ651l7O-00YhRt; Tue, 12
 Nov 2019 19:36:47 +0100
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
From:   Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] coccinelle: merge three rules from qsort.cocci
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <41723f0e-1c8b-5e5d-9d8c-b0df1482166d@web.de>
Date:   Tue, 12 Nov 2019 19:36:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:1oLi2nFMlZPpimG1Qmygdic269tC4M40mQAomEhwmyYjTemQE0N
 /CDuFZxKfyKq/e6+Ca9tCNxJ8I8RrkcbGk/v5LBGbM10aNTxO2E4UqkkN7IsmoraQlPx3Rp
 zzPZzHJxNC2sPbdXVT6oFNhRUhR2thbG05Nh9OWTlW2FJzsBkB6M8xi7wZYBO9jUV9bqlH/
 21dYUhdBi+q1/tbhLySOw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:6AR1eCMTdr4=:W8wBrRUJ9Bfqse/ZlxGztU
 MI7l0fBH9UPja0HfTiSVSY4+YpyjjzvW8nQqF4ka/HT429jujs34jSAdYdHChJyZj28OCrPM7
 l5dO+U+YxTUb8TLtw1zaR1B2IilyKo0KhiM+LMPbWg+44n96Jwkuc8VTiAVjXi8rxbuMn1lPk
 2EU0qwvZhVCtcJb9L+wzsOKPCs6FrGfrw2O0uC/EjAKpAljviswXtCi78gYeIYJ2/6RY0MpI9
 U3TwYZr2BZea+9ttm8m3+J+aTo56ESYKElOALEnz6QAOzzgajUxHeoyMITPX1O6Uakg6sW5E0
 XJET9qeNizuGr/1/govO1fT8oT0UpSiE4klKfF8bwZNtQsId4LDYrCvAZwbnmUk0oe4VP6Tyt
 nghwsP4g2Jc+l1FOgiM2yhpm55tpdzNuqPCtKh3euuXjxn04rwNXjLkD3XPxOR7Zy2EMZLTUo
 49Isq4fIeXL6Xav0f76FVT7MMjAqflx27VTZwQyrkSVsAB7HKp20dPIVkVXnFIUsouDm+tzA9
 oXeWEjV+yfxQ1H40p4LiB93IWB4znop9B7eF8Z09I6xGkbia9U3lx+tVw15XcbcSfFgLAffkh
 lcl84HD9gsSnvrgxDPF+IQB8up1ribENm6ILhOwtmt7HUOxUDkIaVINC6meALzzmyBUJwcbIl
 SxkIOIDYUKTgTX61dabNRuUWeq99mS08cG/mc1uyL6fIqjFFcUuJbfp/G5Z14NPAHt9m3GXnA
 YsRYnUm2Gaz3TZ0mwDeEUVetI6KfvGMIGD+tzkGXUI+jbYPSR9djSh/vaHXDFcoIheTlif9yP
 Y8sottFQe3tRmN8d2YOkUBTHX/oTo2afg/+ikhVwfNOKAnD12QaopfmnhMa8t8Rt8qQIZqxIi
 LCpN8h8tKyufDaux345gbt8o/D0gQMsceyDllOxXTay7gkBl2Re+nPyPOaHWbsekeOMO8FOMA
 zS7nLTE5YCIx3TkcIQxKUuqncw1NiMO8F7FXu05yBoc6k45dQrcPocxb+I3gqeyRE6ZNwlmoq
 pV1KCqx8ArxTI8NjDyKaT9Qum2xuNTGAex5bjW4V80S8dl/TKk3zH5z0pQxa+42/MGcVa/FS/
 mqoyH76z13bsUaKGfZn+9lIQSgwEux0UtmZJDpJg/2Crc/a/TAZ5h7Vgmjhi1BkZwBiold1M7
 F4zLR523JYLy7FK0ep7ZJV8Has7emXGkCpOtU6QyV1M61oAtmDZvFrRfRNfllb1elfGtgMvXN
 YyD1ejHhGsEF0vwRQPqRatO/yIng2zwkGCP/7eagygkON8VGKrNlC+kjMtd8=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 12 Nov 2019 19:30:28 +0100

This script contained three transformation rules for the semantic patch la=
nguage
where a condition check should be removed before QSORT() calls.
Combine these rules by using a SmPL disjunction.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 contrib/coccinelle/qsort.cocci | 14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/contrib/coccinelle/qsort.cocci b/contrib/coccinelle/qsort.coc=
ci
index 22b93a9966..b2130a5e51 100644
=2D-- a/contrib/coccinelle/qsort.cocci
+++ b/contrib/coccinelle/qsort.cocci
@@ -21,17 +21,5 @@ expression nmemb, compar;
 @@
 expression base, nmemb, compar;
 @@
=2D- if (nmemb)
-    QSORT(base, nmemb, compar);
-
-@@
-expression base, nmemb, compar;
-@@
=2D- if (nmemb > 0)
-    QSORT(base, nmemb, compar);
-
-@@
-expression base, nmemb, compar;
-@@
=2D- if (nmemb > 1)
+- if ( \( nmemb \| nmemb > \( 0 \| 1 \) \) )
     QSORT(base, nmemb, compar);
=2D-
2.24.0

