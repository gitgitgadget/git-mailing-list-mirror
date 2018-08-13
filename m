Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 63D041F404
	for <e@80x24.org>; Mon, 13 Aug 2018 11:33:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729285AbeHMOPN (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Aug 2018 10:15:13 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:42511 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728661AbeHMOPM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Aug 2018 10:15:12 -0400
Received: by mail-pg1-f194.google.com with SMTP id y4-v6so7374688pgp.9
        for <git@vger.kernel.org>; Mon, 13 Aug 2018 04:33:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=IrP/ZppE9OZ1XOhoVmFPS9m5BSwvYKE/ZDTYRWCGdj4=;
        b=RTLxAVz+qOOADqsOuvwpc1TO9ZsY7SIGH/LUObUNGS2b48WazGnqNwenha1bMmxafc
         wegAGGIIQJhPaPJvXEWW4KojohtkGlS/RJ+0bhWNtCU3ntwuU7tKCv/n0zlbcrrxJxU1
         knQnUT8/mCP2vXe9To3Szzr0dBnU4p+W1/nII55lGkm1EdF+IbhEtyfve7YkeSZ5g6eg
         ez8ffbQpdixvFjTWu4FoBll3UpTo0Y4hh+dSaYkPgIaAiXYSlsvZVdPDygohaqhUFBp9
         2MFtT1qIiXqmw+TlJxJYpAmbFo5ku+PapoSsx9zlVTT19q9KQ+XGU0KZ/mIJTWkfx2lQ
         A/Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=IrP/ZppE9OZ1XOhoVmFPS9m5BSwvYKE/ZDTYRWCGdj4=;
        b=qC1PM/2QLNVbyHLz3zWFHdyU6fT6M40mMxAj7Nmtj2yPjnsOdGylWpToljVFc8il5B
         KPfXUNrbBnTtMhqcYKomPKOz7nJkzsvE+qaL/KybELeV0x3yjeQF2gbJWEJMxjET4L5b
         K4EK9RoNWTT8OQiFweikj89hdGYM6Taq18++qNyI0+N1lw5S8b2jWetZk7W0WR6xg1UH
         HGEIrsEKIcq72gFnx7Wa+CgS1DV8EYH1nQGHcJwA+yuBSIbbfvJ/STOVLxy30Y9OdNk5
         BqLvVouQGSUmDRF1Pzdi0Y+BWn+GJvm1ElHR6YfaIZ/rCs0rmIK2PzMkkX/XYkEwj/c1
         Ahqg==
X-Gm-Message-State: AOUpUlGPiUp8hdB6vlyUcgSVq2U3JHco8p1FLv74lQPiblhZCMdDd9xu
        xfttUVhi/XdGRAw2+Tt2PWF+lNgp
X-Google-Smtp-Source: AA+uWPwkxVcwys2ulnQivJVi2ag3NtxWuNPDoK5TK4V9jNpUi4/3xwR30OZGY5z32CIbsAo4241kaA==
X-Received: by 2002:a63:a70f:: with SMTP id d15-v6mr16694462pgf.168.1534160000276;
        Mon, 13 Aug 2018 04:33:20 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.137.127])
        by smtp.gmail.com with ESMTPSA id g28-v6sm34837276pfe.41.2018.08.13.04.33.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Aug 2018 04:33:19 -0700 (PDT)
Date:   Mon, 13 Aug 2018 04:33:19 -0700 (PDT)
X-Google-Original-Date: Mon, 13 Aug 2018 11:32:48 GMT
Message-Id: <969a196f48be31e72803d673981a1fa8ad1e3f4b.1534159977.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1.v6.git.gitgitgadget@gmail.com>
References: <pull.1.v5.git.gitgitgadget@gmail.com>
        <pull.1.v6.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v6 13/21] color: add the meta color GIT_COLOR_REVERSE
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

This "color" simply reverts background and foreground. It will be used
in the upcoming "dual color" mode of `git range-diff`, where we will
reverse colors for the -/+ markers and the fragment headers of the
"outer" diff.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 color.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/color.h b/color.h
index 5b744e1bc..33e786342 100644
--- a/color.h
+++ b/color.h
@@ -44,6 +44,7 @@ struct strbuf;
 #define GIT_COLOR_BG_CYAN	"\033[46m"
 #define GIT_COLOR_FAINT		"\033[2m"
 #define GIT_COLOR_FAINT_ITALIC	"\033[2;3m"
+#define GIT_COLOR_REVERSE	"\033[7m"
 
 /* A special value meaning "no color selected" */
 #define GIT_COLOR_NIL "NIL"
-- 
gitgitgadget

