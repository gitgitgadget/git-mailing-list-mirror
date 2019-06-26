Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 08D941F461
	for <e@80x24.org>; Wed, 26 Jun 2019 20:03:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726354AbfFZUDL (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Jun 2019 16:03:11 -0400
Received: from mail-pf1-f182.google.com ([209.85.210.182]:36567 "EHLO
        mail-pf1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726320AbfFZUDL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Jun 2019 16:03:11 -0400
Received: by mail-pf1-f182.google.com with SMTP id r7so56852pfl.3
        for <git@vger.kernel.org>; Wed, 26 Jun 2019 13:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QL1syxXbbReINdf0CGvSMoE7GdXDY+qUalTM3bdbn4c=;
        b=AbU+u1sApi6ak2NGbtZnFHbBEnVk2RVvozyLpsK9h3W93mdAabrqBm7dVkr2GfTJUP
         IbZPra5UL1c8o23EPSOcRvEFlIX9dv7JOclZADwo+SasTb4TPKlWBLiv1ccqMqBcnre4
         zVqBnoOj+BrvFBZsc7D3SjOiUHTk3af0x51iTW5lw6cfQreyAL3oQI98nvKHf2hfA0fz
         ji36JPXNc+nByGe8vczEeKB8CnQNAK68gI/bbNE8b7O3L5Yp5U6szOnbKY9vokQAb6Ze
         vyLO3DpGMPzq+YoXVoSIwk57hhycsnk9WfTVyJS5uQ30fBKEf5lt0nNR9wwafU1ufaGR
         TaYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QL1syxXbbReINdf0CGvSMoE7GdXDY+qUalTM3bdbn4c=;
        b=lPGMrTnzkSQPkBOGqT1+XGN+9BxNdbXu8B0qrQztkjGS89BMrYM+xpMBNTG2yvkYwj
         3nU3fcnWiC/rHIulp0xtpt2lZRJbjsHmsPvGxc2R+6xC9n3MjU+yt6SQTpSYr4KaQxql
         4k8nBCUjv2tTyOmpJxcIilJJUwfWlVOLykTIRvLcIATreBsatp1qbVrUEJsfOoFazonH
         XK7NMuEcqOHWvsKWN1KhTC7vfh7w/ARloF5Eo1GY6Xcg7JR70uAHndlNGEnlUgFG52pT
         +vSpJehXwjg7QZtt1EcZGsUlym9w/H85b+MFeOMVO5PmDoHSqjqnvRgHSgPaOL1IAkKQ
         PBJA==
X-Gm-Message-State: APjAAAWHTCahYhYXbrrbfG+fiNTdyCIj8kt56eFgA7tpMoai/IvvmoIn
        H1WKMUT9VGqxv+cWms2diE4w26vC
X-Google-Smtp-Source: APXvYqxsUFAPusd5kM3ORueCwtxVRgVX6P1oITVpVAfAPvm9rZSfI3vjoTLqstL0zX8UI6T6q+eP2A==
X-Received: by 2002:a63:fb4b:: with SMTP id w11mr4606200pgj.415.1561579390000;
        Wed, 26 Jun 2019 13:03:10 -0700 (PDT)
Received: from localhost.localdomain ([205.209.24.227])
        by smtp.gmail.com with ESMTPSA id o32sm2818545pje.9.2019.06.26.13.03.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 26 Jun 2019 13:03:09 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     jeffhost@microsoft.com, szeder.dev@gmail.com
Subject: [PATCH] trace2: correct typo in technical documentation
Date:   Wed, 26 Jun 2019 13:03:03 -0700
Message-Id: <20190626200303.9834-1-carenas@gmail.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

an apparent typo for the environment variable was included with 81567caf87
("trace2: update docs to describe system/global config settings",
2019-04-15), and was missed when renamed variables by e4b75d6a1d
("trace2: rename environment variables to GIT_TRACE2*", 2019-05-19)

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 Documentation/technical/api-trace2.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/technical/api-trace2.txt b/Documentation/technical/api-trace2.txt
index 23c3cc7a37..f7ffe7d599 100644
--- a/Documentation/technical/api-trace2.txt
+++ b/Documentation/technical/api-trace2.txt
@@ -35,7 +35,7 @@ Format details are given in a later section.
 === The Normal Format Target
 
 The normal format target is a tradition printf format and similar
-to GIT_TRACE format.  This format is enabled with the `GIT_TR`
+to GIT_TRACE format.  This format is enabled with the `GIT_TRACE2`
 environment variable or the `trace2.normalTarget` system or global
 config setting.
 
-- 
2.22.0

