Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 53F9D1F404
	for <e@80x24.org>; Tue, 18 Sep 2018 05:48:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727404AbeIRLSy (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Sep 2018 07:18:54 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35345 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726254AbeIRLSy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Sep 2018 07:18:54 -0400
Received: by mail-wr1-f67.google.com with SMTP id j26-v6so622756wre.2
        for <git@vger.kernel.org>; Mon, 17 Sep 2018 22:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=D45p/hPgcvprVWO3rqjXn3IazaYiSRGBu2ASwHbvLEQ=;
        b=si15/p0Qeq+e0DWAXomged0hPBEZbpRGVBGsV435kLAVrpjTMz3nfycrl7Gh+M4GNL
         DG5Zp5N0w5N/HrqzrnzB0MbmfZ5n6gTNS71kz+BbjgNC3CZNfuQ7agnzNzAS87UfvaA6
         7NSbqYcouWyGJjg5ighwhyn4+Pjw5vvVrZRqvtA0yv1lfLAZ7seCCtNDelCOc+JtDloA
         NuiKdZxF4OIhuPCAWlIqTIJu7brxzIir6CO6x17sWERt9TFf0bYOcm2XtkF640CqCoSt
         VndbSdLau/URmiCBUFNEEpg08Jd1QQVQFbqTAGI0YsXy5APMi+xZWg3myu9ApYS5aXUI
         vS2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=D45p/hPgcvprVWO3rqjXn3IazaYiSRGBu2ASwHbvLEQ=;
        b=RpGiFNMgUPV/KHV3Qbon+7DZaGm6oZ24lA5CPhn+WHP4jvGAjtC/j/B6mc8bfBgQ6w
         K/15Lqpztns5Giw48PHxU9JIgVOgBtOepmU17xnZCZPbFoPgR9udrmZ+AjFM5uDClzWN
         yZz+7y5hz9eLa5/cE7kS88WVZWYc7hI6nYbIm01OFC927lb99dYiiV/wfc0dsNejDgCg
         3bHEQIku5tPxGiGujw82ObSVDkGcPzjdxoRBFFHFAkO8ysYKoYRCbs7+2M2A2yyLNERD
         98E8n0LJbuOS654MHfED9ziRBF/VfC8+w/pAntqTYcW00R0xrRm9728j4YHJ3BCvFQwl
         B+CQ==
X-Gm-Message-State: APzg51BhZyIxylWBZcvPPoalS0mqqCRPn2BDmtg/yj8bzydEgxnfgi60
        1qbTwQ4/2Nx91RYP+lnOwrqjm8NRmNE=
X-Google-Smtp-Source: ANB0VdaojIS7UBfczNsU+0Kl1cDMYVDRMmfhjGDLQplBuAicVnGMEklfTKUpIVotqwjYedHU2E5R+Q==
X-Received: by 2002:adf:8b98:: with SMTP id o24-v6mr21496200wra.110.1537249674669;
        Mon, 17 Sep 2018 22:47:54 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id 132-v6sm881398wmd.13.2018.09.17.22.47.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Sep 2018 22:47:53 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 2/3] fetch doc: correct grammar in --force docs
Date:   Tue, 18 Sep 2018 05:47:39 +0000
Message-Id: <20180918054740.24180-3-avarab@gmail.com>
X-Mailer: git-send-email 2.19.0.rc2.392.g5ba43deb5a
In-Reply-To: <20180918054740.24180-1-avarab@gmail.com>
References: <20180918054740.24180-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Correct a grammar error (saying "the receiving" made no sense) in the
recently landed documentation added in my 0bc8d71b99 ("fetch: stop
clobbering existing tags without --force", 2018-08-31) by rephrasing
the sentence.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/pull-fetch-param.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/pull-fetch-param.txt b/Documentation/pull-fetch-param.txt
index 293c6b967d..2b1fbe03aa 100644
--- a/Documentation/pull-fetch-param.txt
+++ b/Documentation/pull-fetch-param.txt
@@ -45,7 +45,7 @@ rules particular to 'git fetch' are noted below.
 +
 Until Git version 2.20, and unlike when pushing with
 linkgit:git-push[1], any updates to `refs/tags/*` would be accepted
-without `+` in the refspec (or `--force`). The receiving promiscuously
+without `+` in the refspec (or `--force`). When fetching, we promiscuously
 considered all tag updates from a remote to be forced fetches.  Since
 Git version 2.20, fetching to update `refs/tags/*` work the same way
 as when pushing. I.e. any updates will be rejected without `+` in the
-- 
2.19.0.rc2.392.g5ba43deb5a

