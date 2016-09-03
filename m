Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 940511F6BF
	for <e@80x24.org>; Sat,  3 Sep 2016 14:45:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753487AbcICOp2 (ORCPT <rfc822;e@80x24.org>);
        Sat, 3 Sep 2016 10:45:28 -0400
Received: from mail-pf0-f175.google.com ([209.85.192.175]:33073 "EHLO
        mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753146AbcICOp1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Sep 2016 10:45:27 -0400
Received: by mail-pf0-f175.google.com with SMTP id g202so28257416pfb.0
        for <git@vger.kernel.org>; Sat, 03 Sep 2016 07:44:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PA90qJSn3RRJqZ3NcgbeSMfJk2T1nmcF9xgM4XFhV9M=;
        b=ZvjFNVLnLoVMvDmH5URIFOczvKLEOmmnXUkYJYAgNXh/cUjvzDyivZsXPBX2l7BVFW
         1eS1vt1P1C0rrQwZLh4do3TJN4r4fLScNpeXVpz0f2xWalIajy6UpuO9W88Y1ztpsQ6D
         AyBDO+PDsVI1EXFCmN/iADsYRgobS3Z4jWbgpXlLu8y6q9RAXK1hABpA/aJE21jcu4ho
         Crp+oJyp3k8G/+V8wP4km7VjlMXgNumyz0aoX86mVWZJ71mrF4SCtbN/Sz6dnThDiY+F
         sRk9+XtdJe+nI8ZFf/to/mm2qx5q6YQorM4vNHeiLXB0l16QpLdWdnUQxDzcG+BAOu9b
         wV0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PA90qJSn3RRJqZ3NcgbeSMfJk2T1nmcF9xgM4XFhV9M=;
        b=gETl1qE6Fb5RxOpSXbQpRHIz6weWVZMqmr8GZFvQCYV4QTv/Q6ifi8MGDzxqdiM5dY
         r63qP5oEdrThqlpzdBUMati5/rUUcFh6piV9HKw9WXf6zrrWp3YylZiED2PVj0mFA9Eh
         Cw1m4jlJ3KVS/HYO7qi2DQATquonFUkdbDmQKQt0zP92eYaCrdXeIzcNUlxoo9m2HbEy
         /w6LTezN23tKmL+37FOtjYa1aLEWUenrxJAAeROaZPkz7plyaU/3mDe1MoJKfIKKq/Ob
         Fvn89dZmEv4Oj9U7PeSfsEa2pKIzTRWSpHxI6+KIM0G1ecvs9kNXf0C/3BhQDb5VNbiL
         kK6Q==
X-Gm-Message-State: AE9vXwOvAWBaJ9lvwFJJslx4nurZRJ/aDy8DYC2XQoMK6YwLT1DRFbr1LIn9H4XsV2OiMQ==
X-Received: by 10.98.79.27 with SMTP id d27mr46231578pfb.127.1472913894513;
        Sat, 03 Sep 2016 07:44:54 -0700 (PDT)
Received: from localhost.localdomain (i60-35-214-133.s41.a017.ap.plala.or.jp. [60.35.214.133])
        by smtp.gmail.com with ESMTPSA id p74sm6755840pfk.68.2016.09.03.07.44.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 03 Sep 2016 07:44:53 -0700 (PDT)
From:   Satoshi Yasushima <s.yasushima@gmail.com>
To:     git@vger.kernel.org
Cc:     Pat Thoyts <patthoyts@users.sourceforge.net>,
        Satothi Yasushima <s.yasushima@gmail.com>
Subject: [PATCH 4/6] git-gui: Add Japanese language code
Date:   Sat,  3 Sep 2016 23:43:40 +0900
Message-Id: <1472913822-9088-4-git-send-email-s.yasushima@gmail.com>
X-Mailer: git-send-email 2.8.2.windows.1
In-Reply-To: <1472913822-9088-1-git-send-email-s.yasushima@gmail.com>
References: <1472913822-9088-1-git-send-email-s.yasushima@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Satoshi Yasushima <s.yasushima@gmail.com>
---
 po/ja.po | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/po/ja.po b/po/ja.po
index b140e8b..23974cc 100644
--- a/po/ja.po
+++ b/po/ja.po
@@ -11,7 +11,7 @@ msgstr ""
 "PO-Revision-Date: 2010-02-02 19:03+0900\n"
 "Last-Translator: しらいし ななこ <nanako3@lavabit.com>\n"
 "Language-Team: Japanese\n"
-"Language: \n"
+"Language: ja\n"
 "MIME-Version: 1.0\n"
 "Content-Type: text/plain; charset=UTF-8\n"
 "Content-Transfer-Encoding: 8bit\n"
-- 
2.8.2.windows.1

