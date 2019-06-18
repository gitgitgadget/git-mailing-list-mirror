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
	by dcvr.yhbt.net (Postfix) with ESMTP id 59DE01F462
	for <e@80x24.org>; Tue, 18 Jun 2019 12:24:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729189AbfFRMYH (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Jun 2019 08:24:07 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:43640 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725913AbfFRMYD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Jun 2019 08:24:03 -0400
Received: by mail-ed1-f66.google.com with SMTP id e3so21384234edr.10
        for <git@vger.kernel.org>; Tue, 18 Jun 2019 05:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=r/O7mGiYSOfebeKLkybd1sbh6jRCwfbI+Q4YuChRtPw=;
        b=D46WKy26r5C18btJCeSxBc/h9l/uC2VlvwrOguvNrpJvO10iSmI6WlZrIiph0kMmcq
         q2j4OnOzycwCMshsOSF0RwpKts4dGcOKvn9JhYwVTg/6N8aC6sUvM6vEkuPhuyx8iiQw
         WSgzYhkVnIL97b/3jshhXYEnQyFbhzCK7NDuqoSwCzF9zWzHnJ36Te1OkiEX35uawAGp
         Cc+9lJ7OQhxrVN+JG/+a+lEswYpoaDvh2ts0aBqvj/y2rvKmwN/ONIkBSlokMeWgfJ8o
         qJ+5ZYySS8r/0laqr7JI4nBCMThe5RR9EStZ1S7hmW38PpZF6vYliHW+Hym4c0xG2PFq
         egqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=r/O7mGiYSOfebeKLkybd1sbh6jRCwfbI+Q4YuChRtPw=;
        b=ZQAtELSYaAVtvuuwdFHDVQ3tX63vv4Hxlx0zFJXOkVoxGRwPGFZ2TsInReg6RRw/t2
         22FaS3vH9EffHA/ten9lfEBPMqQ8JpC5OPKS62fFv6RXBagnezdrg8Vb96Zc9zmaPCZK
         aHa2Hnl1zoBrjOYsCj2+e52SZXaoj+qz2+yNdHGMx56GeVP1DbfiyIL0jrABEEirO1eN
         h8lf6YD8bxWHEuiVc5fykwkWPdqYKuRBRnHEW5EnB0mc2xuNuKFQ37RqtXyQ6Wsh4Bwp
         2poh/OxOn4hEojcDUaf00C0NR5GFRqbo4XYlb4sUYXRbMOkvI+j3Y6q8DXEa0bfHkALs
         +A5Q==
X-Gm-Message-State: APjAAAWeVk/4LzV/tdeeAWEavCiitbtOIELGBWaoQ6g/on3QPSex04UV
        p+JEWr6v137/ioFXqLmE3/MlcyLD
X-Google-Smtp-Source: APXvYqxLLtoIrCV7VjGWEy3rPq6DcX1wFTXbqjRLA5BF7hQgHSxYtZj56lFHMFhVh+C4qp2m3H2GLA==
X-Received: by 2002:a17:906:3d69:: with SMTP id r9mr57447350ejf.28.1560860641011;
        Tue, 18 Jun 2019 05:24:01 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t15sm2187054ejj.25.2019.06.18.05.24.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Jun 2019 05:24:00 -0700 (PDT)
Date:   Tue, 18 Jun 2019 05:24:00 -0700 (PDT)
X-Google-Original-Date: Tue, 18 Jun 2019 12:23:44 GMT
Message-Id: <037fbed117328dc89a0a7595c44f0c03acc78496.1560860634.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.149.git.gitgitgadget@gmail.com>
References: <pull.149.git.gitgitgadget@gmail.com>
From:   "Philip Oakley via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 07/17] msvc: include sigset_t definition
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Philip Oakley <philipoakley@iee.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Philip Oakley <philipoakley@iee.org>

On MSVC (VS2008) sigset_t is not defined.

Signed-off-by: Philip Oakley <philipoakley@iee.org>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 compat/msvc.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/compat/msvc.h b/compat/msvc.h
index 29a8ce8204..04b4750b87 100644
--- a/compat/msvc.h
+++ b/compat/msvc.h
@@ -18,6 +18,8 @@
 
 #undef ERROR
 
+typedef int sigset_t;
+
 #include "compat/mingw.h"
 
 #endif
-- 
gitgitgadget

