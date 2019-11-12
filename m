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
	by dcvr.yhbt.net (Postfix) with ESMTP id 21D5A1F4B5
	for <e@80x24.org>; Tue, 12 Nov 2019 20:41:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726994AbfKLUk7 (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Nov 2019 15:40:59 -0500
Received: from mout.web.de ([212.227.17.12]:46689 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726912AbfKLUk6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Nov 2019 15:40:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1573591255;
        bh=nfcCsQd/Ni6fEzRReD9NF5UesGjaPDq4oy+gf7RHCM8=;
        h=X-UI-Sender-Class:To:Cc:From:Subject:Date;
        b=m8wWRTXLIT6r7Hrir3ZYGD1SkeHJHfCmaqFX15V5i3Tu+lQei5Sv4IJeH3gX5oAY/
         Ss4KSrYgjeF+zhxzCb7EXYOmWFlSMHTxdLm6EY+93EoNvpjfstPBlr9vREehPB6wr+
         2ydujr633mEc+p8tAIDR7mKK4hwEgpZmypWFxFr0=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([78.49.102.255]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LfRvZ-1i6IiE1oCH-00p8JR; Tue, 12
 Nov 2019 21:40:55 +0100
To:     git@vger.kernel.org
Cc:     Stefan Beller <stefanbeller@gmail.com>
From:   Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] coccinelle: delete an unused variable in two rules from
 the_repository.pending.cocci
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <1b2b8e8f-9736-5551-65f9-ad5857bce73d@web.de>
Date:   Tue, 12 Nov 2019 21:40:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:34OybrJIu+3OV7DbVmCwZHDbo1sXu5bgoFn67RGLTM70XHZEDIr
 Se5fiOpMjaSncMiDYwbQMyHg5uv7FC5GrFAMCEeLDTAKKvL7I685c6bUU2mi+p5vyNgT9UQ
 MBeoFFK9tPYvCxxu68HFQidlu525u2LDFd550kiyGqvXZn6+RJ2m2QBWPyhgcjtlnK1P1t0
 LlinVTDPs59gNMZiu+swg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:4WhAMRaNrNs=:PlNr5mETmjWG/6h8uQMfP/
 lqVebAi4oFlzYTpw7vilwmF/D1xNIuudmSFZCm6Z2bpWY05svSNfANT77BwfNk72fZyAGYGEb
 ZdyHglT+BKfSd/rVij9RJ33GyLqKiz9addge4D0Y8K6YGEWzqmhEwWuf3l0CtN/W7VjEIPma5
 brv9k+mijbD8XysK17rIs7NGJuDaHVcTt3V4q2OvS5Yytxiahlpoe1IPr6rYFu4c15I+BRsU7
 uYqmjkMLS0KXHaHbqgNrbE1wYxTERTSvVwz6Pfuc0gM528cEG3mZ12MrYGYceKLSSRwtRJWQr
 ODFb6fhSDLcuCnmQKi+mviiCJpsBHYbUmbylpL41YPP4BQ3NQ8PBMF4zCQwoEYR+ACOnnLTiK
 Kdr6JZLXP0CKsbmQ94suVC19VvZNkh5CDSTzA6v5WDe5MreKtodptkM1vCzaBe7kEbyZX50zz
 4sj2DG/FrOA9rLJpEFpwtfIufoLamqb77DanyeLtg/oteKbQOVqzaXWelwWu+bAbuLEsH48Z0
 U04FKI+Pkgunl6KH2sGFCyUb9sMugXQEJ9vbyKJNXt3cv2zuKAGwX7ZR7MUiX9Z0h1smszjGd
 k/rgnwLwTydrS6PaBaBMPIN9aORq3FIZqf6Xjx+eDOIOQ3djuD8Amz2Vk6MnHDfJMVhRD2sI5
 HO7zuQmGaHMO4+Ectv7A/fyQ/sAkWO4ijnv773Mufj/mOx0t2ySLH0sKBMNEYzI6bkyn6mwhn
 y5T8uQY6dZFjPxA9Pcxi7otxkZW9jQ6rvNfoK0AXwBJHm/7Kc0seg0KFKn44qOewJ4c5G9edT
 FSLisQRf1udLbIRxYhYEiUUom33LlA4DrkcH1cdb7cAHWhptaazINXKeCTdrHb3bNYoFyat/8
 qJAiakIdpmM122CPFRtz5oDhg5boQaGOOJQILjtF3rWMGMDM+nwLnd0JsTSZHc1M9SJGCok0T
 /86OwUWGFmpWGBJ0mwPuJWTreSJy8tw1QmVOli+OLtIeDb/s4LINjSxnmsZb5OIBC7Ek3zNcQ
 eYrPcV3O10C2HFUrxLu7SqiohhWCxSWotHEF+rO3BkBBDjN6V0HKnRYAOBNXxxqk6AOAMVMg0
 3Ffr6GRyE1L4ywpSw9VZpL5ncBs/FdL/rKJ822budE2nZqbLc+1HaWspS7dXlPJ/4gOk0QXPE
 ATs1LaOmyAiwkmR+7r9mIZxLVsjYf0+3Bqb/bYSvig+nL3R4nXgRQfb+dq3kreqldGT9vhBu8
 hRE1HhG73Y28+E6G1dV26GzWI4kfV7rkyvQKvsVZUh16Cjy3AuOd4w6GfS7w=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 12 Nov 2019 21:35:36 +0100

This script contained two transformation rules for the semantic patch lang=
uage
where a metavariable was declared but not used then.
Thus remove this superfluous variable =E2=80=9CF=E2=80=9D.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 contrib/coccinelle/the_repository.pending.cocci | 2 --
 1 file changed, 2 deletions(-)

diff --git a/contrib/coccinelle/the_repository.pending.cocci b/contrib/coc=
cinelle/the_repository.pending.cocci
index 2ee702ecf7..ff6a6a575a 100644
=2D-- a/contrib/coccinelle/the_repository.pending.cocci
+++ b/contrib/coccinelle/the_repository.pending.cocci
@@ -20,7 +20,6 @@ expression E;

 @@
 expression E;
-expression F;
 @@
 - has_sha1_file_with_flags(
 + repo_has_sha1_file_with_flags(the_repository,
@@ -35,7 +34,6 @@ expression E;

 @@
 expression E;
-expression F;
 @@
 - has_object_file_with_flags(
 + repo_has_object_file_with_flags(the_repository,
=2D-
2.24.0

