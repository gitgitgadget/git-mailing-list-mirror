Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3D85F1F42B
	for <e@80x24.org>; Tue, 18 Sep 2018 05:48:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727252AbeIRLSx (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Sep 2018 07:18:53 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33878 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726254AbeIRLSw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Sep 2018 07:18:52 -0400
Received: by mail-wr1-f65.google.com with SMTP id g33-v6so628266wrd.1
        for <git@vger.kernel.org>; Mon, 17 Sep 2018 22:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Hv66u5n0D3CJmpMSQqfL6y9HwdrvwQsxuywQBl18EcA=;
        b=RiB+HVcgEURCaapXg5y3aR0dZ46gA7zed3rC8y30QF1xLHtUZixwpQBoLOHM62/Ziy
         NEOGfAbl0OyQzp4MGasunkNiQOal5y48RT2PrHHIcc/GXdoXhK1ZufxI4myksw/2n5VR
         Z/ffoomAHhx4At/cpWhMvCn/yGCg1XJ6zU3B0S6rvmsbKul6GLxlc54hUXWInLUk7g8k
         e4GSVMzS0fkEgtzNjHefCFoMhOVnbZLmPScSORoU9GwkLMrGmFoFPbS83cQx9DQdacXj
         zcadHAqMzUGOIUM0nLRfV0+n/O1BACmgBjEzCWYgJsBXRV33zs4Pj1nND+DbBtfRO5JD
         yUog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Hv66u5n0D3CJmpMSQqfL6y9HwdrvwQsxuywQBl18EcA=;
        b=ZHxejXCPcQe87VZVjFMPT6EtfO+ueHm18Ew/ctlhxJSTWu/bxbe8NxHbsUNgMD9hRl
         iDSiOkdBI++AtIIB6xdN1JkHmhzYfZ65tr9Myo7vfFQVy6xcGG94/rTF5UD50vKOlcoJ
         d4YmJrrBLftT2+vs/nbOh/iO4N10HXJh91s/jDI5Pl5B0553jFMWPsINKZTDL8PFslFW
         OZ1sS4mGSmQtRvPj9kQd5dAlly+0L3l8R/LHbySk5WxHATCgScw3ZACCrrs9KrM8K4NV
         9b0fL4JxI+7ernN1VFB49MtBJnC3MSmO9vzc/M7afdt55yIp+6JHVgTDLLQw1WQ1PB6+
         fIOA==
X-Gm-Message-State: APzg51CpsCB7wXVBJc87N3nndXeHSLXfacxGGemzZcZxDnZPfSFiu0zP
        EFh629MMGjkTNE3VMlUeQm9jMsOD4xU=
X-Google-Smtp-Source: ANB0VdbWSzYorRvNy8D5VdQCCSGKcH9+NRS32zsGNs/uQsyDBzaDJYdDgRRCtv9V3bIpU5iCQJUXbg==
X-Received: by 2002:a05:6000:104a:: with SMTP id c10mr20216681wrx.271.1537249673209;
        Mon, 17 Sep 2018 22:47:53 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id 132-v6sm881398wmd.13.2018.09.17.22.47.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Sep 2018 22:47:52 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 1/3] push doc: add spacing between two words
Date:   Tue, 18 Sep 2018 05:47:38 +0000
Message-Id: <20180918054740.24180-2-avarab@gmail.com>
X-Mailer: git-send-email 2.19.0.rc2.392.g5ba43deb5a
In-Reply-To: <20180918054740.24180-1-avarab@gmail.com>
References: <20180918054740.24180-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a formatting error introduced in my recently landed
fe802bd21e ("push doc: correct lies about how push refspecs work",
2018-08-31).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/git-push.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
index f345bd30fc..a5fc54aeab 100644
--- a/Documentation/git-push.txt
+++ b/Documentation/git-push.txt
@@ -110,7 +110,7 @@ can be overridden by adding an the optional leading `+` to a refspec
 is that no amount of forcing will make the `refs/heads/*` namespace
 accept a non-commit object. Hooks and configuration can also override
 or amend these rules, see e.g. `receive.denyNonFastForwards` in
-linkgit:git-config[1] and`pre-receive` and `update` in
+linkgit:git-config[1] and `pre-receive` and `update` in
 linkgit:githooks[5].
 +
 Pushing an empty <src> allows you to delete the <dst> ref from the
-- 
2.19.0.rc2.392.g5ba43deb5a

