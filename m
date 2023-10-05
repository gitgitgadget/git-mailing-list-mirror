Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2AF0E772B8
	for <git@archiver.kernel.org>; Thu,  5 Oct 2023 16:06:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237719AbjJEQFb (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Oct 2023 12:05:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237633AbjJEQEJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Oct 2023 12:04:09 -0400
Received: from mail.smrk.net (mail.smrk.net [IPv6:2001:19f0:6c01:2788:5400:4ff:fe27:adaa])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25B2E9ECC
        for <git@vger.kernel.org>; Thu,  5 Oct 2023 02:02:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=smrk.net; s=20221002;
        t=1696496533;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5ao9Tj9QTDP3VIKdxI8BbdCv5My85FP/70CqR7uxe9k=;
        b=eM7R1qmI+qkzuJ1LcPu68+iyifHRdkdQDEdtY5f8zOlsQmk3Xk7EjOE/XSMk19/B2a/+AT
        j7DN3TsLY2wtXNac93ANblb02Mle3dYDg4Wor8EXJEb0iBxRLWlp1DNNNmCKBkx6fsx5lx
        r4JwXP/ob2yl+gU+Liilf3jcyxs+w2m8APcCQA9gFh3jQYMBMS3fBkHbGqR3+smxwb94KF
        mTi70GAFKBtt1VPtAb7qOscNr2/Qv+CoUQG8QsDS8yy18sMU+X8JcktktPkRWNxx4Efy4D
        g7h/RZnH2j0qW4lgqSm93KnWlXylyCHVaayhDb6VgYUYqzpxgKgzV1XrBh1CIg==
Received: from localhost (<unknown> [192.168.5.2])
        by smrk (OpenSMTPD) with ESMTPSA id 4408572f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Thu, 5 Oct 2023 11:02:13 +0200 (CEST)
From:   =?UTF-8?q?=C5=A0t=C4=9Bp=C3=A1n=20N=C4=9Bmec?= <stepnem@smrk.net>
To:     git@vger.kernel.org
Subject: [PATCH v2 4/5] doc/gitk: s/sticked/stuck/
Date:   Thu,  5 Oct 2023 11:00:54 +0200
Message-ID: <20231005090055.3097783-4-stepnem@smrk.net>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231005090055.3097783-1-stepnem@smrk.net>
References: <20231003082107.3002173-1-stepnem@smrk.net>
 <20231005090055.3097783-1-stepnem@smrk.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The terminology was changed in b0d12fc9b23a (Use the word 'stuck'
instead of 'sticked').

Signed-off-by: Štěpán Němec <stepnem@smrk.net>
---
 Documentation/gitk.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/gitk.txt b/Documentation/gitk.txt
index d50e9ed10e04..c2213bb77b38 100644
--- a/Documentation/gitk.txt
+++ b/Documentation/gitk.txt
@@ -26,7 +26,7 @@ changes each commit introduces are shown.  Finally, it supports some
 gitk-specific options.
 
 gitk generally only understands options with arguments in the
-'sticked' form (see linkgit:gitcli[7]) due to limitations in the
+'stuck' form (see linkgit:gitcli[7]) due to limitations in the
 command-line parser.
 
 rev-list options and arguments
-- 
2.42.0

