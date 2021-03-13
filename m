Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAA0FC433E0
	for <git@archiver.kernel.org>; Sat, 13 Mar 2021 16:18:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7780664F0F
	for <git@archiver.kernel.org>; Sat, 13 Mar 2021 16:18:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234059AbhCMQSA (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 13 Mar 2021 11:18:00 -0500
Received: from mout.web.de ([212.227.15.14]:44597 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234000AbhCMQRf (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 Mar 2021 11:17:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1615652250;
        bh=20KP0g/1+hEss9RPhO792+eZD8VTznRXMZY6z6+JZzo=;
        h=X-UI-Sender-Class:To:Cc:From:Subject:Date;
        b=AWV8Qf6zCiV9GR5qtKTEVG6pH4glYOrh3OznhWuowHx01yQQL00xRIDQRzR21QAC2
         ZPyUZ0JmOr8qZ8SryPEyXlN39qHzLFM/VdL4SVfBwMCggfp+dNTLGpGk7j2yz3W6UZ
         mW/cELGwqo0IFyGtlGOztDdEm0ypinb1D3x0Y2NE=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from Mini-von-Rene.fritz.box ([79.203.24.70]) by smtp.web.de
 (mrweb003 [213.165.67.108]) with ESMTPSA (Nemesis) id
 0MV4hR-1lDbWh2jin-00YTe8; Sat, 13 Mar 2021 17:17:30 +0100
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe=2e?= <l.s.r@web.de>
Subject: [PATCH] block-sha1: drop trailing semicolon from macro definition
Message-ID: <f8122736-e729-5d35-e1e1-78a213816d4a@web.de>
Date:   Sat, 13 Mar 2021 17:17:30 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16; rv:78.0)
 Gecko/20100101 Thunderbird/78.8.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:fFxB0408iwwxqPurJBXrvfMNgGMDoGHAoqRakHCF0s6qdIfwwGE
 MLqiIUOMIHFpPdZTUrahqd80V0uxDBs2Ulq1BCwAnM9BbEZ4gHALeLg2ThN2PaoiUvrpNg9
 AlU5+DOcOmlJv05DwJNRVcyfCdRIBF8WPkdT55ocKWaQfj66Zc1JSHSB4jfDwB6mxmdBz8E
 c9v6w4RfR0ltHpVmUVB8Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:AbM3+1WMJb8=:1yWbyVptWwQvY6ZPFVkV7R
 Q5MmaEzDPKNIrRBQV5t/PkQoHnzeQhHhZcbzgWbp1m990/hs7pLd2hI4RLP6m9qRaHj87kjOI
 iK1A/zQW7g4Rv/S5r1tKwXCYiIOnMIqg/LROxdjhYQzql2k2aYyrJLBliz3WW5EG8nh2gX2UM
 1dSNZugJdIz7Y4GjCG8WMC2X6K6dvpGBDNkMG5PuxzmpU4b5QlTVZk2BAc3SOHLvWVBF69fCD
 lDcchmnuofyYHWP67id5lbfpxMiEujlQ4EDcYs7VCS18E0uywZ2QozuqnI4MedGj+4ituNcsM
 Ets+Wl5kFWt/nW2omj2dwDE8CZdlTsQtTYwSag2osYmU1Cfrt69oSMJSu2sSfl2NZRyWnTwYP
 zG5RMrqKlXmErenYfrnKFSVc7Vqv/KP+BgugOpu3UcyInDAoQOmi0lflEkpRA0j2tVQMBayZY
 0jHb/OPHDG29FMpy69WU+EbLJs6K00lvA+QrquTKolHekTY25IcNFYgzhL2Vcvbc56mjKY3O9
 pVsNNlznN33Vyq7AxeuPb0M8aJLV+turuB+RWaTnJFgtbCivekDyjwQjcshVnsH8IgwMG7K2b
 hJJBgt3DWsexesGa/jc95ueHWyYAuJhCi7xS24ZgFpUEmqwzaFLRSHpegB+rErRQrmQJ4HPpF
 H/CNde7MC6+ZDf+XNj+GcnSzJhO5hg5YhtK1XP6REscfqmJz3FeFfRDHee4LwdPTEPGNhY5bV
 aMDjWZvHPG6wmyaKbpqjrASVL4RACE3BlM+6IfA6jiYnzw1ak0sRTYFg3SXmp0aXvj+RGT/4g
 CWSP4pzDocJ4kfQXCteKEgO5x6DPzgEv/Ci3JY2/wZTr5AKVYC8QbIIdhnV/t61ikWAaDuTBy
 /Kza8f0g1sfYaDFYVGPg==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

23119ffb4e (block-sha1: put expanded macro parameters in parentheses,
2012-07-22) added a trailing semicolon to the definition of SHA_MIX
without explanation.  It doesn't matter with the current code, but make
sure to avoid potential surprises by removing it again.

This allows the macro to be used almost like a function: Users can
combine it with operators of their choice, but still must not pass an
expression with side-effects as a parameter, as it would be evaluated
multiple times.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 block-sha1/sha1.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block-sha1/sha1.c b/block-sha1/sha1.c
index 8681031402..1bb6e7c069 100644
=2D-- a/block-sha1/sha1.c
+++ b/block-sha1/sha1.c
@@ -70,7 +70,7 @@
  * the input data, the next mix it from the 512-bit array.
  */
 #define SHA_SRC(t) get_be32((unsigned char *) block + (t)*4)
-#define SHA_MIX(t) SHA_ROL(W((t)+13) ^ W((t)+8) ^ W((t)+2) ^ W(t), 1);
+#define SHA_MIX(t) SHA_ROL(W((t)+13) ^ W((t)+8) ^ W((t)+2) ^ W(t), 1)

 #define SHA_ROUND(t, input, fn, constant, A, B, C, D, E) do { \
 	unsigned int TEMP =3D input(t); setW(t, TEMP); \
=2D-
2.30.2
