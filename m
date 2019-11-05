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
	by dcvr.yhbt.net (Postfix) with ESMTP id C8C6B1F454
	for <e@80x24.org>; Tue,  5 Nov 2019 23:58:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730241AbfKEX60 (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Nov 2019 18:58:26 -0500
Received: from mail-wm1-f45.google.com ([209.85.128.45]:35906 "EHLO
        mail-wm1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729701AbfKEX60 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Nov 2019 18:58:26 -0500
Received: by mail-wm1-f45.google.com with SMTP id c22so1358207wmd.1
        for <git@vger.kernel.org>; Tue, 05 Nov 2019 15:58:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=xA2OZ9fwFRItuT+1oLzaCL6Jnaz6vDhDQdaAc/aW/bE=;
        b=EFGNvXoKSlcpnJg5pzDZJYzLJ6c/JOyo2CR5zw07mDffcAf8xwrP7+K0WYty8/CYY3
         yKYxy8YOgqjzWiNGlhLvZW+eSCvzXWWNrYjMpK3my7vVr55rTSFtG6IWn1+jJrRS/5qh
         qpF7az/9xjPQuazwtGdzVDh+F49xIs1qdRlVpyX1IeM1RgA5PxAoeec+83STKvTBTMBF
         TPHs7/6cgOMzFpxqHC5plgHSTRY6Ji4WvyXnRn95q2eHcgWYyfhPS8fCTGLzz6LDQvzi
         6kNS7a4rBIqZzmyOG8L9APGALxXkkwPryzIihaCWTEL5Y+Z3AAt/0/hwOC+IEIhdkzah
         dRaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=xA2OZ9fwFRItuT+1oLzaCL6Jnaz6vDhDQdaAc/aW/bE=;
        b=KkV5arxKalR7xHa8K9ii3pg1pGAZfLZ+jri6kSBC16ZWL93TRTLuQvV5fnofGTow5q
         oggNUrgGmQmqy93yWdfNzDFpbqG30hX5pFKZH3Uh4Yh2JJsb9fUgrlwu79S0B+W7WGS3
         gBhUe/D9fSaR7lC8azSGV/mPQ6kaYwdOOJvbdv8IYzjQBVgz/7bTxJuMd4LAGFqnJMSI
         EqUStCuSvH5uDs7fWmhR5BY0/5xvMKpWa5MqAh0vY4id0vccYFat/Vuw68Q5jvmHEk44
         EWRlxZvD/tDATp318UbWZPWHKuSnGHjIn9S0dcfPJp8Xjz2eXeWmb6t7jZGmdFBsd3d2
         5PKg==
X-Gm-Message-State: APjAAAXCtoUH2l9AKs24CgP+dL1SIiFUupmJ2RwFUrN39jxRounvTnBA
        WbkQYtURoVi1NwXaSYZznVY8j+6Z
X-Google-Smtp-Source: APXvYqwL75vbndqiK+Qwdk5mCXOA0sCgeilJSRgwUFoqjaDJHjn3D5876DbR/+FEAWQYq3GR2W3WiA==
X-Received: by 2002:a7b:c858:: with SMTP id c24mr1363050wml.174.1572998304385;
        Tue, 05 Nov 2019 15:58:24 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s17sm832548wmh.41.2019.11.05.15.58.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Nov 2019 15:58:23 -0800 (PST)
Message-Id: <pull.455.git.1572998303.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 05 Nov 2019 23:58:22 +0000
Subject: [PATCH 0/1] t6024: modernize style
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

A simple patch to modernize t6024; this was a change I made a few months ago
that I apparently forgot; found while cleaning out old branches.

Elijah Newren (1):
  t6024: modernize style

 t/t6024-recursive-merge.sh | 121 +++++++++++++++++++------------------
 1 file changed, 62 insertions(+), 59 deletions(-)


base-commit: da72936f544fec5a335e66432610e4cef4430991
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-455%2Fnewren%2Ft6024-test-modernization-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-455/newren/t6024-test-modernization-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/455
-- 
gitgitgadget
