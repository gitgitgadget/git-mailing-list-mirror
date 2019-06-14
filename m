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
	by dcvr.yhbt.net (Postfix) with ESMTP id 70D851F462
	for <e@80x24.org>; Fri, 14 Jun 2019 12:16:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727806AbfFNMQK (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Jun 2019 08:16:10 -0400
Received: from mail-ed1-f47.google.com ([209.85.208.47]:34085 "EHLO
        mail-ed1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727573AbfFNMQK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Jun 2019 08:16:10 -0400
Received: by mail-ed1-f47.google.com with SMTP id s49so3247329edb.1
        for <git@vger.kernel.org>; Fri, 14 Jun 2019 05:16:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:from:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=hl4/99xyJ/T/om7HnF1RIlCyStTa9Cf0kATH5qJyCnk=;
        b=DmzsXpxO3FUJyM9MTjR23Tz4zFNuh62FbGPPR7FhNApafUqOymIo6oE6V48rs2hgQC
         8ad53bIheOPHL849n9l3n1m5BkMVWrPJG9cQUpTmsh7DiNJf+lweZzGWFjtQtLBo2SG9
         uEDTxes+T9NOualVNxaFt/Gpzr5VC2F0CkhOkC6k5BRj5skPM5TKnPkHfjMYR//s27RU
         4lLYwfz043OGQtpDGPwjHaeBiaQJ81mRGcEYjmUHxbLJtCLFtaPqQhKs3vzAO9E47x7d
         hrtBrtErWz25zvctRMKULbByNNJBgvpsiozgc/H5NsHGGMtx9YBWlpgaJKkaySZZAl8E
         Ix3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=hl4/99xyJ/T/om7HnF1RIlCyStTa9Cf0kATH5qJyCnk=;
        b=ubRRUMujQykd7QB/Gp+5qTvKSN/GMjvHZ39sHxnhti62W5BXR/BQh7M5ts5X2/1TXy
         3oKS/5/03GiqEVO61fvak1XI+shnHdYZIR12PyT5Ky47WtEmpNtxmeXYoJm2+i25j1/2
         I3AuQfp3SalkFCaAcZdlWjRs3//IFUCgm0Aa8OF4ovLGW52B40ADer5yD5CavjL01lRK
         6AZl8kN8e8k42znY9Wqp/SvDqD7l5hi54L4JFZP6kLIk/tD9WaQYLwIXOhlM8AvJyYJ6
         YrimhO9mdQzk1uHsYDeEho246oE2HkAnEQk7ziMRNZUwiu5wLrONrtaIQLlh892h3n5R
         ofYg==
X-Gm-Message-State: APjAAAWopQUD1GYpRDPHxvEOvt1UF+XO6X0aWS2ixFxcwed1ht6j3FE6
        snxt4kqljPcNPHPb1GCnRRxCgL2TyuM=
X-Google-Smtp-Source: APXvYqzRIsj8yqzdGis3dEjE5TW2EHKSYdUmPVcJM89sLJ9kiXu/76tZ1+Mrp0u/X7zHMH/B1d26dg==
X-Received: by 2002:a50:e619:: with SMTP id y25mr17519870edm.247.1560514567909;
        Fri, 14 Jun 2019 05:16:07 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o31sm846912edb.66.2019.06.14.05.16.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Jun 2019 05:16:07 -0700 (PDT)
Date:   Fri, 14 Jun 2019 05:16:07 -0700 (PDT)
X-Google-Original-Date: Fri, 14 Jun 2019 12:16:05 GMT
Message-Id: <pull.267.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 0/1] t3404: fix a typo
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Just a typo I found while debugging something else.

Johannes Schindelin (1):
  t3404: fix a typo

 t/t3404-rebase-interactive.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)


base-commit: 0aae918dd929862d3ce0ea2960897787bb269a3b
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-267%2Fdscho%2Ffix-typo-confilct-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-267/dscho/fix-typo-confilct-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/267
-- 
gitgitgadget
