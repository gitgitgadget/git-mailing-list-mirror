Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 13D751F461
	for <e@80x24.org>; Tue, 20 Aug 2019 07:19:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729406AbfHTHTR (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Aug 2019 03:19:17 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:43765 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729322AbfHTHTR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Aug 2019 03:19:17 -0400
Received: by mail-io1-f66.google.com with SMTP id 18so10043096ioe.10
        for <git@vger.kernel.org>; Tue, 20 Aug 2019 00:19:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RLA+auV5w3B4S445lrANQbbCFiyXgx8XVCPcuC5rVkY=;
        b=oRygOs+k2gdzlBaSXFP/zLWCjgt+r7Mo+eOYowqdGdlmuz97xKL4WOk3SWwuFXYZam
         exmokrnYC11p4UzQx3aSZ0aR7LIlLoI0GTlTtaEzeX8Y7ItLvTyzoKPy0kWMtA1oMMHh
         45gDFX9krOKtc0eRwdbVH6Ny2aw9pNfuIDn/96GQ444dLHDIYgK5Xv76edLPiYTAXsTF
         tmFgOdNHJ3kHKnGb+Z0H4e+bwM3/+dE4bbhMVd0MOYoDjdSHRzMs5SlzEiXSuFLCnnO8
         yoUbIK5K3hC4ii28SJ6hxgca6DrVs0iwCp5b7he/V129rpzIkG0bcTANXgEXkljayUvc
         Kerw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RLA+auV5w3B4S445lrANQbbCFiyXgx8XVCPcuC5rVkY=;
        b=lUbWZ5Y160ejBgKjJygQ7je7P/mgM+bZAqHQxE+c41GE1BdvOSH83OUGhVIfJ92tik
         mvUKL5mXBOjAb/5rqs7Wq2e7Y1yg4V4djxct76zmEIf/XMam8V1B7YLm7xHhfZhN7hof
         9ZpYD3P0EuWHf04Ilfp0HPW0tyiQvc8sHqXtcNEei6Uitlnes8O9UYKLX8fIMX2BLJ8N
         0Pfw+MUjhdw8XK+J5qD6PSKnLjmWbRp+w8ZzhaVGJVaCofAwEPe1YLcPfLk1RVp69Ov4
         NH3+fqeO0tixT++paTTd6i2/9tgjNkiXAkRUBEoA0zf3Efln6zq9pTnYYFXyTsHZ+ck+
         qHJA==
X-Gm-Message-State: APjAAAUjgfhaVB+ZoIggasVcWYKr6l2GYDKWzb5rya2J/J6RtNmTy0wg
        ex/HZvTPyzhFg0UVmnwTEhvQu7fu
X-Google-Smtp-Source: APXvYqzz30Cl+Dbo0UO55a9I7wd/dqDlpt4LMcPpfoal2FVOtsohvzjhVMlxDRosc+f+K/ATOviEYA==
X-Received: by 2002:a02:cd82:: with SMTP id l2mr2118981jap.97.1566285555845;
        Tue, 20 Aug 2019 00:19:15 -0700 (PDT)
Received: from archbookpro.localdomain (CPE18593399858a-CM185933998587.cpe.net.cable.rogers.com. [174.112.89.95])
        by smtp.gmail.com with ESMTPSA id o2sm17632637iob.64.2019.08.20.00.19.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2019 00:19:15 -0700 (PDT)
Date:   Tue, 20 Aug 2019 03:19:13 -0400
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v3 12/13] config/format.txt: specify default value of
 format.coverLetter
Message-ID: <a08273ebccb3cc0b6cbe8a4391ff12f011bfa0b8.1566285151.git.liu.denton@gmail.com>
References: <cover.1566258525.git.liu.denton@gmail.com>
 <cover.1566285151.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1566285151.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 Documentation/config/format.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/config/format.txt b/Documentation/config/format.txt
index 414a5a8a9d..cb629fa769 100644
--- a/Documentation/config/format.txt
+++ b/Documentation/config/format.txt
@@ -77,6 +77,7 @@ format.coverLetter::
 	A boolean that controls whether to generate a cover-letter when
 	format-patch is invoked, but in addition can be set to "auto", to
 	generate a cover-letter only when there's more than one patch.
+	Default is false.
 
 format.outputDirectory::
 	Set a custom directory to store the resulting files instead of the
-- 
2.23.0.248.g3a9dd8fb08

