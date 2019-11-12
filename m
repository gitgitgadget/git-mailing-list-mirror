Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 712611F4B5
	for <e@80x24.org>; Tue, 12 Nov 2019 14:15:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726970AbfKLOPI (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Nov 2019 09:15:08 -0500
Received: from mout.web.de ([212.227.17.11]:50169 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726645AbfKLOPI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Nov 2019 09:15:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1573568106;
        bh=NX821vtlFHAJWCpxcHggN04GvS52+URc3VPbZr6OtLc=;
        h=X-UI-Sender-Class:To:Cc:From:Subject:Date;
        b=iLIKZeOQij9kdcHwQReEqKgBlEPGtPxDlEJ+zQ9g4LnBGCK4a3tTaonCo+59xMkGp
         0V7bTpexok6pygYRbAzp1UmJgW8Y5qKHW02ZTB1HnYIkf+bQoP6w58+riNvR0Zj8/y
         2YwoSwczKpLcBsStjwnAXflQjnNB/g2qgnn/3jF8=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([78.49.102.255]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MXpZD-1iQy1V1qFD-00WpJb; Tue, 12
 Nov 2019 15:15:06 +0100
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
From:   Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] coccinelle: merge two rules from free.cocci
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <17c6e9d5-5a06-8150-fa82-e20e7b850fe4@web.de>
Date:   Tue, 12 Nov 2019 15:15:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:nlTkvQK2NCrzHtjlTTU+GrxuyOM/VLVmxAGO/NSVHANNnXoBUAI
 XRfoSJwjREvv+JbpOd17zJzdk96RquoRe5/GcCnbNPUW+7CdKVZ6sP50GjF5DFkhkHw/8yb
 lSuw8v7KoRJzSl36AFeX7ClZwhXyDarWWiSGUptfo3gTsU34nm5WFc6FJzXmAJ1EqDGMQ79
 7OYR/asoHAvSUg94MtCuw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:vpgJhiv6woU=:kXVI/x1bC2UZH5tACvIzjR
 4O2I9K/8wHq57dPvow2+4gSWCnV3qgKFOo2DDwj88h0xWolEoTSVF85o5BKIszakSSs6nBZHf
 dElH4SGQgJfR1QLZ1lD7ZfZk4jgevhZOAus1Lcj6ZtLTtzb8DUpDJqSnyv84zfxM4s3zT3xxH
 b+u0xfA50r0k7X/UYDg2fqAkgBjtuABimNZNrncAZgYKaanrD5tcLZo5DzWTtrMjz0fZTkYiw
 h33vd6YzC6aYzE9Lzr0i7q6x7sZB28yiDDfR3+PrCq2RIzmjqdP31FJ2YoVSc/2XhyGxElSOy
 DVkiTXXGh6MnlQdwIzY9bAW/euV+5+HTntTasnQYRXJt3F1dZvYo6OL52f1uYv5hd2H1/dYJZ
 cuB0PiDrILr9xVWkLv8gn6sqnKNJBE/4ZqY7g1kuy917l3mYp5+qJCEpwRnGwrCEfsxGXANfu
 /44EgLn2h/a7BNFvAPCPalfHYOePpNvlxT9Pr+s0r7f1z6Gov0lt3XsEMhd51Upq6QUYhaWVA
 sKTPL9O+AeU+S5RQ616xIQYY7432R3kxY0ij4M9EXEqzk0Ykk105Rz2egIw0rCS7ynvXUX8+5
 aVtDS+5wx/F6Cmnd195zSl+C6rsRdUwmHbg2VvHD6M4bvNxMy6+S4g1lO42rzQzrtsqr+wW3u
 BJXdIFs+GT2D+mj5umJDsaNgTzGtg56KcsZoO4Iawsyyfj5h7cd1y3rj2bBfzIZ5XfQ/8f/ul
 LPCPOSijANkcCMbBGJFf94gsP1MQZbiut+cZgMOJgPOSFAhHaCdaV+E4qSzfKjYxZcCz9XGT3
 45DUMGEPwK8gFxFJrZVN+E3IAI9UEBaduh622pp7gLyEZ/OuiTmrUNYjRg69uYsPMArNKaqJX
 ABIc4VohSenhjFCqDK+a2mF+0ybbQngFANwMw6E98GVGbR9OwXlrCd/Z6yhbJ1Fp15dX57BbD
 Hx2S6OwlK40qgw2ZMFC0425XPtf/0KpM+NIUNEfncRBPBbPmnTOGup4Cm696LAua9TmNVWk5e
 31m2zOfXKSCg3rjw/jrfv7B3ZsrGYFygABQ69jydcSedMAylVobxlrmb9IdYEq1CsEU7jyBsu
 T0NCnlrNRYemm0QUB7ZzAGpv+BfibhT8+RP6S1KMv7tre6H4FWi7U3Mz4zHXkW8lqgkDYHgJJ
 LT9u/ngiJaUvgMDYZYxiBt5kF3DljxQBLWwKtsg9Kl9MeepqLlB/BTPm0Lo0Yx+D4yOSi+4zt
 DNiJurEe18Q7aqyrpIQp9AV3/oz4UUJECbiuth1IWPGgXmOcUkwaTXUgjZfs=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 12 Nov 2019 15:00:29 +0100

This script contained two transformation rules for the semantic patch lang=
uage
where a condition check should be removed before free() calls.
It should not matter if a corresponding expression begins with a not opera=
tor
(or not). Thus combine these rules by using a SmPL disjunction.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 contrib/coccinelle/free.cocci | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/contrib/coccinelle/free.cocci b/contrib/coccinelle/free.cocci
index 4490069df9..63e442d3ef 100644
=2D-- a/contrib/coccinelle/free.cocci
+++ b/contrib/coccinelle/free.cocci
@@ -1,13 +1,7 @@
 @@
 expression E;
 @@
=2D- if (E)
-  free(E);
-
-@@
-expression E;
-@@
=2D- if (!E)
+- if ( \( E \| !E \) )
   free(E);

 @@
=2D-
2.24.0

