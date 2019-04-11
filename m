Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C658420248
	for <e@80x24.org>; Thu, 11 Apr 2019 18:32:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726649AbfDKScD (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Apr 2019 14:32:03 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:41183 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726595AbfDKScD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Apr 2019 14:32:03 -0400
Received: by mail-ed1-f67.google.com with SMTP id g6so2130741edc.8
        for <git@vger.kernel.org>; Thu, 11 Apr 2019 11:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:from:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=CUafGOt+MP0UURkxdnuM8srXio4L/epakl9rTZ9HpeA=;
        b=U1jEYlGoL7fzk0arGHecaQf51K9dpLlrS8XLODrLD6ZBT0O+1tV5/SlQojV3yL4MUG
         p25WnCSuWnZeEu5Rf328CFCT1MMeRfDFU8ylJKEX2VcUqH+kP7qkIznx02Rzs2dM3BN7
         O56GkAJHUaHiubxVGAo0xBWVY7RG9EANpPj08oh3hdE9tty2BVdMbrJ1wC1Yk1qnZ60j
         M6d8Nx4pEBqjUzbIfo2HssTwbK41LL1bkhSIxszKrivXYuBOOxzIl2y/XdE/wRefVQtw
         FSGE0K1LPrlD2CvfXNgRQRZod/ruMNbnJ3/1POG96+MtPebgYPO3Vc7BWlhGPG9WK3hV
         fnuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=CUafGOt+MP0UURkxdnuM8srXio4L/epakl9rTZ9HpeA=;
        b=YhLEuW7Ec2TqnlMkZc1OyQjxwhKcT/YZvcXLuqneqLFCAxBLt4rveimFVTfyoXEij/
         N16LDhJXyQuVKVnR5UCEqRSD9Ry/OQg+AOgp57AP96N1559YxV6Oe2Wj95jOkV40YChB
         ddYdz6jyAkdjYdBlgxRBEHn/Egj45b9Gjzd0hJkDRWfwk3tSNLN82Ju1SddVYQ+9kmo+
         pvC+IEV/mqO9bgwNEN+ShNiYu5IbmAWSMmbzv2QKVIXa+EFbSGFtfLOq7YOzG5YF85Nq
         3b5oWMmwZu1U4IifL54jf+bYKM471Ha/7I0VLqrlV/GyZzDalvo7UQOXN91MVUJNv3FF
         9cFA==
X-Gm-Message-State: APjAAAUyCQKm9Ah9yYOZUJV9FmlmXbzMvwqPAlGeKGqUO8jQWKmVFl+3
        KDMypR771ouNsSnSsMRMPlE0xY9p
X-Google-Smtp-Source: APXvYqwJpsw/5eIepnFr3XPTX35SkvEZEaDf9I43BRy1OjCxBnzB/RrHK8JYpVbohG1HB/zy/MM5KA==
X-Received: by 2002:a50:e718:: with SMTP id a24mr18117508edn.63.1555007521305;
        Thu, 11 Apr 2019 11:32:01 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q18sm2763116ejp.56.2019.04.11.11.32.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Apr 2019 11:32:00 -0700 (PDT)
Date:   Thu, 11 Apr 2019 11:32:00 -0700 (PDT)
X-Google-Original-Date: Thu, 11 Apr 2019 18:31:59 GMT
Message-Id: <pull.177.git.gitgitgadget@gmail.com>
From:   "Emily Shaffer via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 0/1] documentation: add lab for first contribution
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

RFC. I am still working on adding a section on handling refs and objects.

A tutorial for beginners explaining how to commit to git/git from clone to
push. This tutorial attempts to explain the GitGitGadget workflow; with the
review I'm hoping to understand whether it's worth the effort to detail how
to use git send-email as well. The linked implementation is present in my
personal fork and I'd be happy for any comments people wish to give against
that implementation, too, although it obviously isn't destined for git/git.
I wrote this guide in order to learn the process myself, so I welcome all
feedback.

Additionally, if there are skills around working with the codebase that
should really be included in the "Implementation" section I'd be happy to
add them.

Emily Shaffer (1):
  documentation: add lab for first contribution

 Documentation/MyFirstContribution | 674 ++++++++++++++++++++++++++++++
 1 file changed, 674 insertions(+)
 create mode 100644 Documentation/MyFirstContribution


base-commit: e35b8cb8e212e3557efc565157ceb5cbaaf0d87f
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-177%2Fnasamuffin%2Fmyfirstcontrib-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-177/nasamuffin/myfirstcontrib-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/177
-- 
gitgitgadget
