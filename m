Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0C81E20282
	for <e@80x24.org>; Sat, 17 Jun 2017 22:32:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753843AbdFQWcG (ORCPT <rfc822;e@80x24.org>);
        Sat, 17 Jun 2017 18:32:06 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:32937 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753225AbdFQWcD (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Jun 2017 18:32:03 -0400
Received: by mail-it0-f66.google.com with SMTP id g184so5938581ita.0
        for <git@vger.kernel.org>; Sat, 17 Jun 2017 15:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zaImJgsNWBV3S3x7ZOUIu9zRmmNIANy1c/bD8XSYZAk=;
        b=UP/EABFaFZ2/aXiQ1R24SsIGALIyDZU/S+LnAbGmcD9XA9Q5gLGOY++yIDm7ylNLre
         b61HjCwvN8k7K1kIpvJVQBbDHisJezzKxP7ZxC4RSV9buvF9lAAyCyqs4VIK2LlN7+kn
         YryxCagymCTyScT3ACNLLVogzTS7IvOkbbgfVq0nuoG7vfxMpDi+ACStjyG1xb94bwGH
         sxgeH2EdT9y3/J9jyS/DP7AoO0B8qhQiBLpA0V3oBeo1YVoAKyT63BJBhXbxNANKqFRr
         JSYAyoNCM05vJ6G2ht0p/y1ie02Kq7L+o1Jxa5SsUf3j7KIzqi2lrkjlDJgBwW8UU2ib
         4vLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zaImJgsNWBV3S3x7ZOUIu9zRmmNIANy1c/bD8XSYZAk=;
        b=UWe3GdmJE87SZ+6+CU4GmBvHb16XHfquCvqqGhkGUiEBttusxovz6bIv/kHAxyvcFO
         KvV5QoE+ni3XlnlWDUWQsRmxxEfswkFvTyprSIkXSyCzFUe4W0b44C4qfospROfw2wyG
         Fhs2tmcWBGW8AKrT6ESWFsojEy+Wbu3X6M5jeu682kAQl0rHnReYMenVl1YjVF/0F4nm
         Adf8e3V0Vj+kVwh4am25n6FpM+YsdAkCN+3h05QuI6+CqjvjfGM/9ZRIEiv9rKbmk/Sx
         vYPC6DIPqHu8Gr2bwbLfPtEQVWYMCkyWaSMDXDCp1pxYvv9dnVmsLayOKheuMB8WXdhc
         Oo6w==
X-Gm-Message-State: AKS2vOzm4S2jlnzVyiaDWtrtlEUChNbZkEquKNiJToe9ngkeNkqp72QN
        VR9tMrK+pOY1ZJR60WU=
X-Received: by 10.36.25.193 with SMTP id b184mr16545338itb.75.1497738722651;
        Sat, 17 Jun 2017 15:32:02 -0700 (PDT)
Received: from localhost.localdomain (24-212-246-46.cable.teksavvy.com. [24.212.246.46])
        by smtp.gmail.com with ESMTPSA id 33sm929589iog.26.2017.06.17.15.32.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 17 Jun 2017 15:32:02 -0700 (PDT)
From:   Liam Beguin <liambeguin@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, houstonfortney@gmail.com, kostix+git@007spb.ru,
        peff@peff.net, sxlijin@gmail.com,
        Liam Beguin <liambeguin@gmail.com>
Subject: [PATCH v2 3/3] glossary: define 'stash entry'
Date:   Sat, 17 Jun 2017 18:30:52 -0400
Message-Id: <20170617223052.6580-4-liambeguin@gmail.com>
X-Mailer: git-send-email 2.9.4
In-Reply-To: <20170617223052.6580-1-liambeguin@gmail.com>
References: <20170616043050.29192-1-liambeguin@gmail.com>
 <20170617223052.6580-1-liambeguin@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Liam Beguin <liambeguin@gmail.com>
---
 Documentation/glossary-content.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/glossary-content.txt b/Documentation/glossary-content.txt
index 6e991c246915..b71b943b12ed 100644
--- a/Documentation/glossary-content.txt
+++ b/Documentation/glossary-content.txt
@@ -570,6 +570,10 @@ The most notable example is `HEAD`.
 	is created by giving the `--depth` option to linkgit:git-clone[1], and
 	its history can be later deepened with linkgit:git-fetch[1].
 
+[[def_stash]]stash entry::
+	An <<def_object,object>> used to temporarily store the contents of a
+	<<def_dirty,dirty>> working directory and the index for future reuse.
+
 [[def_submodule]]submodule::
 	A <<def_repository,repository>> that holds the history of a
 	separate project inside another repository (the latter of
-- 
2.9.4

