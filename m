Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B6BB7207D2
	for <e@80x24.org>; Sun, 25 Jun 2017 08:01:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751326AbdFYIBP (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Jun 2017 04:01:15 -0400
Received: from mout.web.de ([212.227.17.12]:56870 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751236AbdFYIBO (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Jun 2017 04:01:14 -0400
Received: from [192.168.178.36] ([79.237.60.227]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LxOHm-1dr8ED0FRq-016wIx; Sun, 25
 Jun 2017 10:01:07 +0200
Subject: Re: [PATCH v4 4/6] coccinelle: add a rule to make "expression" code
 use FREE_AND_NULL()
To:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org
References: <20170615231549.20085-1-avarab@gmail.com>
 <xmqqa858zzb3.fsf@gitster.mtv.corp.google.com>
 <20170615231549.20085-5-avarab@gmail.com>
 <xmqq7f0byayu.fsf@gitster.mtv.corp.google.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <2122b01f-7627-cd1b-c7df-751c076f90ff@web.de>
Date:   Sun, 25 Jun 2017 10:01:04 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <xmqq7f0byayu.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:SivcadeZHs3rYOWGvJLdAhtibqMPujFHwgw0bo2+NsbxMkRyprC
 dbQ8G8zB/btj9YrwiyXRK4N/0Afkq5FfaiibHfWSpWqEFPwGCVekkCavNd6FWxZGLbe+hI9
 GFeKaY+2Dr3DBRQh5FgYAdzHI1R5HPD5YV0r1IbMaZhFjRNGKolaIqjoJEjD1K2HgEQkzJ7
 ULnZGvk2etFdo5MmFN/3Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:p5XGwzpadsg=:midn7LtPUXN6JTFiFOQHO/
 yrvaXLqVUMbaXH3aiE/8EBUs2yLqxBpXR1Oy256Rlt/0qi0VviphB15FBmD74ue2bbbm1N19I
 R7weDwZJ201AN5k/T+R4HoFYVb1tqKfvrASwSj8avPS7g4YH4Q+4vvyczgxwn/8Qb0s51VDlQ
 XuJW0Fe6xalzCbAJ/UiVB3221tshOCNXapd4UcWwVtgfWLhYhysOUhZ1oQuQDr2ZrLkT5vPn2
 Ord2GFWpwQYlwV5OCM9UFj9A+HCwC9UAPzYZQmPP7CzcPX7TLW7NhPwOmriWLhextXpRo7MaO
 ke9MH/dHIZjHRpXOtsPx8ijdQEdc0n1TeCz/S6QtYSmTL+11PtsBUdLe7VKLp5WhtssFaIVZR
 X9JmRskkt8sa5hV2cAl2vFsheUFVS6AvJYL6wgnGMhZ/uQ6b5snwdHlJwd95wjbP0PujLrFnd
 WSxk/Li17Hxd1oYTsSW5Knzq5yUWxn+wUdmWCOfJx2W3HpiUKRmPA/7YubadEiIVWv/MLovCF
 +xKy+4CVpGhuHQ+MloheN+WwQB6+jXP7QdysZw4pFtvgR5DsbOpHB5vL6k5ve9va8GYHL1nXQ
 8W19eQ1pD93DQ239Kdk8Dq+5Bb0/JZ0EsgMtyQ3LZwxYTAv7E72ksLZ3Cnmjkdtb+GYo3tmWF
 bqZ3SJLnMdDeuiPAO2oCq6tj12QMyVGxf0iTUoVxzZEJGuqz9jkjV/B7icRrNGf3Ng9smlz+I
 yH9mcllUNj7jV4uTLSn3VhtP7O9ORWGXVT5N0OzI50bw98Bmaj38P43jwlifcQdO1Oxr3HH80
 Hlhvz2U
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 16.06.2017 um 21:43 schrieb Junio C Hamano:
> Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:
> 
>> A follow-up to the existing "type" rule added in an earlier
>> change. This catches some occurrences that are missed by the previous
>> rule.
>>
>> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
>> ---
> 
> Hmph, I wonder if the "type" thing is really needed.  Over there,
> "ptr" is an expression and we can find "free(ptr); ptr = NULL" with
> the rule in this patch already, no?

Indeed.  How about this on top of master?

-- >8 --
Subject: [PATCH] coccinelle: polish FREE_AND_NULL rules

There are two rules for using FREE_AND_NULL in free.cocci, one for
pointer types and one for expressions.  Both cause coccinelle to remove
empty lines and even newline characters between replacements for some
reason; consecutive "free(x);/x=NULL;" sequences end up as multiple
FREE_AND_NULL calls on the same time.

Remove the type rule, as the expression rule already covers it, and
rearrange the lines of the latter to place the addition of FREE_AND_NULL
between the removals, which causes coccinelle to leave surrounding
whitespace untouched.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 contrib/coccinelle/free.cocci | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/contrib/coccinelle/free.cocci b/contrib/coccinelle/free.cocci
index f2d97e755b..4490069df9 100644
--- a/contrib/coccinelle/free.cocci
+++ b/contrib/coccinelle/free.cocci
@@ -11,16 +11,8 @@ expression E;
   free(E);
 
 @@
-type T;
-T *ptr;
-@@
-- free(ptr);
-- ptr = NULL;
-+ FREE_AND_NULL(ptr);
-
-@@
 expression E;
 @@
 - free(E);
-- E = NULL;
 + FREE_AND_NULL(E);
+- E = NULL;
-- 
2.13.2

