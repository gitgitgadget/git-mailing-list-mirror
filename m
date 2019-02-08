Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0A6DC1F453
	for <e@80x24.org>; Fri,  8 Feb 2019 10:01:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726133AbfBHKBX (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Feb 2019 05:01:23 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:36090 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726524AbfBHKBW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Feb 2019 05:01:22 -0500
Received: by mail-ed1-f66.google.com with SMTP id o59so459807edb.3
        for <git@vger.kernel.org>; Fri, 08 Feb 2019 02:01:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:mime-version
         :content-transfer-encoding:fcc:content-transfer-encoding:to:cc;
        bh=hLbqRr91crcsg18XSaNAIeldaBYIB6SvHOPMpTafb3Y=;
        b=Lpgm0++uAkSI3JWnFxxjo5DmJUe8o3SGn+tFB1WHsmCbG4L2ybjKj7f9qkFowz8DB1
         UGyhOM9HPAPLIsB09bpCjH8FjiubFqP7O6/K5Diu7ZnokQIIK2JfdrL6RDuAZDqMn4Xh
         OssJ4GW03gTs7emXPG1GUzuVNRqYW03ubYmrcMv+jvBtrdgdZP4B5mbWSMeDsBoE/ecK
         D4Zlxoslxae/lyiwoh/lD5AA9C+KlNJPwc2q4c8dI9hgLpdp0ERZvBASWBGiy5lvEbrJ
         zqug1YcckD2Ne8Gf+8bikZmJ+Rs1ig6Ibf6SOQd0bqXXc5Ly5+nMEuhkwJklIVoOOZIh
         JuBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:mime-version:content-transfer-encoding:fcc
         :content-transfer-encoding:to:cc;
        bh=hLbqRr91crcsg18XSaNAIeldaBYIB6SvHOPMpTafb3Y=;
        b=uQIUGD3YMS/1XM/NtLjvTt2abUl318P9f7ap9E+S/qwbkW2tS+CeZvmPILDNbYQukr
         wwl8AKR9iP/+Xq5rniA1skeYgQYCXOCPDUrSF0llX4wK9aFosaG66qPKZt7UWb+IPDlX
         Ncu/3hihDLxzKMMEGVBgkZPQlDCriEhH8DybscSoK6/n0qlOkASv9tkVYTbh4qf9gjU1
         ENl8ZqLBr2vOmquj13E+QlUnU2BiyAD7zcJk4ajKZ9v4AYtJpLud2QE28y2HC4TX0lg9
         RMeJm4xGn7/B/bKS9lyHsZiL2Ls42AjqDaaU94INqxvwzfeowQ9/lgnmQTYIqzUC4KFE
         ayKA==
X-Gm-Message-State: AHQUAuarYeVdifW+c0vQnh5mtRGGN6FNVE+3l98xDdNH6OHT0KNlM3SY
        mXqp9fVSgEqkwfQoeApffab8QXoB
X-Google-Smtp-Source: AHgI3IZwVL0HOV5VuuJ23/qnDY6G2nOf2zwk4OsZdgZIc44ePJgWp9+1JcAaj1ZbdH2W12iBApBOxA==
X-Received: by 2002:a17:906:228f:: with SMTP id p15mr9318343eja.104.1549620080571;
        Fri, 08 Feb 2019 02:01:20 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k12sm385336eja.60.2019.02.08.02.01.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Feb 2019 02:01:20 -0800 (PST)
Date:   Fri, 08 Feb 2019 02:01:20 -0800 (PST)
X-Google-Original-Date: Fri, 08 Feb 2019 10:01:18 GMT
Message-Id: <4bfffa2b70b3d31681a7e32721985f143f23aad9.1549620078.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.122.git.gitgitgadget@gmail.com>
References: <pull.122.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 1/1] .mailmap: map Clemens Buchacher's mail addresses
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     git@vger.kernel.org
Cc:     Clemens Buchacher <drizzd@gmx.net>,
        SZEDER =?UTF-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

We have three email addresses for Clemens in our commit history, two of
them bouncing. Let's map the latter to the only one that still works.

Pointed out by Gábor Szeder.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 .mailmap | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/.mailmap b/.mailmap
index 247a3deb7e..82cd0569d5 100644
--- a/.mailmap
+++ b/.mailmap
@@ -40,6 +40,8 @@ Cord Seele <cowose@gmail.com> <cowose@googlemail.com>
 Christian Couder <chriscool@tuxfamily.org> <christian.couder@gmail.com>
 Christian Stimming <stimming@tuhh.de> <chs@ckiste.goetheallee>
 Christopher Díaz Riveros <chrisadr@gentoo.org> Christopher Diaz Riveros
+Clemens Buchacher <drizzd@gmx.net> <drizzd@aon.at>
+Clemens Buchacher <drizzd@gmx.net> <clemens.buchacher@intel.com>
 Csaba Henk <csaba@gluster.com> <csaba@lowlife.hu>
 Dan Johnson <computerdruid@gmail.com>
 Dana L. How <danahow@gmail.com> <how@deathvalley.cswitch.com>
-- 
gitgitgadget
