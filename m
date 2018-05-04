Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CC3BC200B9
	for <e@80x24.org>; Fri,  4 May 2018 15:35:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751464AbeEDPfK (ORCPT <rfc822;e@80x24.org>);
        Fri, 4 May 2018 11:35:10 -0400
Received: from mout.gmx.net ([212.227.15.18]:52847 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751447AbeEDPfF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 May 2018 11:35:05 -0400
Received: from virtualbox.mshome.net ([37.201.195.116]) by mail.gmx.com
 (mrgmx003 [212.227.17.190]) with ESMTPSA (Nemesis) id
 0M3j17-1eOAZW0F6H-00rJ2T; Fri, 04 May 2018 17:34:59 +0200
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Thomas Rast <tr@thomasrast.ch>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Stefan Beller <sbeller@google.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 13/18] color: provide inverted colors, too
Date:   Fri,  4 May 2018 17:34:58 +0200
Message-Id: <1ebbe359547689d32aa27564929d733a26bb8054.1525448066.git.johannes.schindelin@gmx.de>
X-Mailer: git-send-email 2.17.0.409.g71698f11835
In-Reply-To: <cover.1525448066.git.johannes.schindelin@gmx.de>
References: <cover.1525361419.git.johannes.schindelin@gmx.de> <cover.1525448066.git.johannes.schindelin@gmx.de>
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:6+0Vu4L3ERYvX6yxbnW9kT9iJQ+guMWAWTtzi6Rx6EJ0ZtlneOk
 EB+tq9+SKILl0WhIC9Ry9W4X4Ol6xIt38ljRrjUYG/FXGCSAjDuOHQ792o/T05eTG+Dduw/
 PF5OIjoFREdS6LTlQqgvPGvCOTROlnw3fGSulOyb9Gp3E3oB0Kpq3HW58JmhgU5/Xglp7JA
 e2tSPOJ0k25rJ3HsgVhAA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:9aIxqTYS1ow=:p5cSm24yFRl7fVOimkkLhk
 uzKsUN9ArQDcifo8u6mvi3cjScV8n3LzIuE1HAalviifJ+WrbFxeEmwDfefNosHOD10O/v0qx
 seZC7lXIQmHxVKlJtKjMQUy0DqYq4Lwc43ru+XwGfsq6SkEpkHxm0brPxj0b2ZcW4a0f5IbD2
 3frOVwXhs80GDZ4GrWFqgZqbLUg8dcg7wAC0cF+In7ZuU8ZojP1mEtL40eHJsXYnYKinoHjmZ
 3Tq9Cvkge4EpSP++XKAiab6cJg4Ew1ooZZy/Y+SlADwThBFff6v91F3PaACjavOpMYu0UAsNN
 Dnq2Ir26UgHMk3c+mz4sbmNw308bV3n8KBfdm4S6MkMNRzTf/KO/G8exixfoZvIZmq7a2mT/v
 /3nuvodgNELRChKukR6ASG9FpFZnc9oickb9klAmJ6Uk9BCbhJmSZe/yiOfDjDTZqQLMOeJy8
 J0cJh6949ZSeh4bsII2xP7NqGtBTsGRNgqgXcnzoQJLcNMQ4bp9b5ax+cOZNN3SG6EewmFkmc
 M+sQcziEZw5e8c9KSY6K6iPUroNTT2469KGDiLZ98wPzFHEAdtlyCvt7EWb5WZ3YPtv8N8cRz
 EKvBWXTbRKZ3F21tXKV33sHYHoTdRZKuZU9cKCpggWbuR5iTt+cyYKUa0Gfks3bHOYa/rdJve
 xOklabHNfpy1Z9KzvLmlWm7W3Vm4sZjsEKDsVt8D1MpQe2MCEbyxucWXZej6E4qtO5+Qm0US7
 2bwsn4QJrGKEK9xpQmGMB/5BTdnNscidObkmSaqLr90xLjP6XNfY1Fv4FcG05VBRB/V09vdF+
 Sj6Z8Q3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

For every regular color, there exists the inverted equivalent where
background and foreground colors are exchanged.

We will use this in the next commit to allow inverting *just* the +/-
signs in a diff.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 color.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/color.h b/color.h
index cd0bcedd084..f0984b09583 100644
--- a/color.h
+++ b/color.h
@@ -36,6 +36,12 @@ struct strbuf;
 #define GIT_COLOR_BOLD_BLUE	"\033[1;34m"
 #define GIT_COLOR_BOLD_MAGENTA	"\033[1;35m"
 #define GIT_COLOR_BOLD_CYAN	"\033[1;36m"
+#define GIT_COLOR_INV_RED	"\033[7;31m"
+#define GIT_COLOR_INV_GREEN	"\033[7;32m"
+#define GIT_COLOR_INV_YELLOW	"\033[7;33m"
+#define GIT_COLOR_INV_BLUE	"\033[7;34m"
+#define GIT_COLOR_INV_MAGENTA	"\033[7;35m"
+#define GIT_COLOR_INV_CYAN	"\033[7;36m"
 #define GIT_COLOR_BG_RED	"\033[41m"
 #define GIT_COLOR_BG_GREEN	"\033[42m"
 #define GIT_COLOR_BG_YELLOW	"\033[43m"
-- 
2.17.0.409.g71698f11835


