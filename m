Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CC6A41F4B5
	for <e@80x24.org>; Tue, 12 Nov 2019 18:36:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727068AbfKLSgu (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Nov 2019 13:36:50 -0500
Received: from mout.web.de ([212.227.17.11]:54359 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727041AbfKLSgt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Nov 2019 13:36:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1573583807;
        bh=Gato5DE8UFRQGKB4f4CRHZjZrVMxI8pNLP1qKnQWeTM=;
        h=X-UI-Sender-Class:To:Cc:From:Subject:Date;
        b=l3Gy/pNcsuHa9mGcrX+wpW+E/880Ap04QyG0zaaK6CL33Hv4FdCwnHVEAe7tWhIRv
         TBk0KkUKjabRTRYjpukfF4fjR/g8M1B7+yX0fEPqubvcw+0Y98CPY/pZWJP6ty2otS
         DxmUQh8/xWoQsGvqN7IZQzt3mGcm4mvYeKTqxmVw=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([78.49.102.255]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0M7bUB-1hinlI1j8x-00xKKI; Tue, 12
 Nov 2019 19:36:47 +0100
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
From:   Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] coccinelle: merge three rules from qsort.cocci
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <5124838e-a297-ff24-d0bd-c5d95e2f83f7@web.de>
Date:   Tue, 12 Nov 2019 19:36:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:27WmY7IQ5Ujt2zdiVeUGZ2WFsnZuZHeP0hMo9dAaTfMW0XpXUyr
 bM8AR/x30lMA82hXE5owenlsmLOGseOb+SX7N+/WcWfOph0TUH/aVhsKxljPT1lfaYEDtI/
 e9OHnbCOdodt0HxWRyyusLsXduywoq4VYX9t8aNFwmwB/P1s+5y/9ymrcC+3QF+hct9c5Vl
 RR5HzUnUW+PsAoxd9TkCw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:7oXe+QNALeg=:qy3MfmW9Ii9naBFZrCXah3
 Z4SsMmW9F9crfElNpD3HEGQym34IKW34420OyvRRLYR+Qbg/uX265DRr3RUxEhbS2ZAKZBklF
 uH7NawFmSxHZ7RCHjJg6sBt+hcWQ4xOssbt7AHTnm0NJ4+AOgGPnN+uXxWRl20EGL9rRgr0PC
 an6fRMLKAMane3V4eylNX2NqT4RINrk1LlwyG+WlXhnu+FWL/soiwX/fZv30diHAtvCOkVuxv
 uHBtcC85HRneLOBbRbisW0s0dVNAwxJajRlZ4oJ2SyNpn5uJJpgkjkWP+fVr2x0ZBAULpPua/
 Nna5S+OPEnWXcE5A07wqGuVm1CTyI4zF6hPin6wbtPLyApf7kvE/CzTS8Vkhz6th1q3pKY+Cl
 D37OvoxpL/pf1FGx0Esi9CvY5xmLNcSvN+/8u/trHjynWdUgGDARG4TvKHOza5SGPQuB3CGdy
 z7T6IEbfUtOXgIhgvdwlpjiAjU9oEh2M8rhOooOMrOqIe+RAe/SYMVejsWyQABsoxMSo2ZEzf
 PFbxtH03A2y0phd7+toc4YB21O4tItNpK9hOPfxZ4/7wvLUbpeLCUzrGD/Qy2FYfVovSa4p4k
 hwx1eODWtENL0+6sLN4kYvcqhrjc9TNOOFMC+bsCSG8lvmHAvZWhWZGYP1Vz8Qbj7C5S1dS5J
 PmomCLPsbvWHbrQsn0lDf0S3FsR2lnAu0tiwFoXROLiWcdsIF7PMioVhhgexbbGardh/9PabJ
 0dUZIUUPSagQzclePaw4g29Nvlz2Gqy17YjQpeUthS+I/y07InrWYtnNVCreevCK5tin6YeMN
 4x0vK/mnP8/KZEEnmtD4i+35EWKB+lWxaVcu1byz50Wo29r5jK3GkZmN5Ilb71kgOBvv+6Cf8
 CQvxN2SN0CIXNtAcD10HvJDimljrE+I/sloNynaQQmWGUVT2M7IQDxEpH86yeVxUFfW+vzN3Y
 iX9w9b4SxZPekqBGmOf3q3LGml2pbN52OIawrvlQ0RDCKTnc/iOCSaPaaIEkfHlglrTzNM4M/
 tlAiAoM9c9PzK0i+5ai1hT3/X7l72pBip2bA+c4kD3G8p+lreJIFDvOZt/wOq7HldTIc7fvHh
 Il4urw/5xLMemFuJgw910xycbmMvpQtFIsPSS3TjGFbhYR+J8pFzhdR5svkSyM9XQasykHlU/
 cFhM2a/ExfL7VCsfUU6S9mGLRX/4qgmeAkteuWnwK/3LmlesPon08TorMriqO4VjzYHH0eaUq
 RxgScz5aDXqs/nKXBw0pV6OScbqoaahM400hUtFXdWomAFniX0cz+3Gf90OU=
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

