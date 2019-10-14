Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DF02E1F4C0
	for <e@80x24.org>; Mon, 14 Oct 2019 01:31:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729659AbfJNBbn (ORCPT <rfc822;e@80x24.org>);
        Sun, 13 Oct 2019 21:31:43 -0400
Received: from mail-wr1-f44.google.com ([209.85.221.44]:46487 "EHLO
        mail-wr1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729359AbfJNBbn (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 Oct 2019 21:31:43 -0400
Received: by mail-wr1-f44.google.com with SMTP id o18so17621992wrv.13
        for <git@vger.kernel.org>; Sun, 13 Oct 2019 18:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=DwLUJ4MGpFfhsw0SfXGx04J6PxqISS5OC9Wletorryo=;
        b=fc2uv0FVK2uLBlcFkl5EHVLP2Y44atRWNBbcnAVKxY7WewVVh2QewgqRL3hCs46pOx
         vWhMmi77MUaHMnwT8VKjOjU7JDaTkdz2DMpUXRbx+mIcKqpZ7m0vP7uvSfxib+l7E+68
         NdcuzcfGpHsoBpwMES+rE/WDLLbGgGMG4TXzmOa2tRfJ5n2CADjm432qD3yDqY0ABid5
         /riOglibXa+PLhZCQNV6CXKSYlgPnLOw/Eq5Tqbb98M+xaLwttI1HvofdyuvRar7rIXC
         Gb/kWJXJgmAJQuwREAvkEWayLV+UjLIMh24q1C/GqF+EXCgbeGJ09Q1naVG2DGJDDju6
         HiTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=DwLUJ4MGpFfhsw0SfXGx04J6PxqISS5OC9Wletorryo=;
        b=NaA84yjb15iVNi0IoGKnnN/ZvwZHZOJE+gNujNIrDGmRepqIuUgJs7C/RGLiaGeJRt
         iVmv5HojiQqRGTCn6JZXJY5htAUporb6bFqwLcSbLQmGzqRIV/skftod+2bUQ6FTF9OE
         UkuwtYoTKYvi9thk1NRNEcBUZDSERKggX92QlKE6EnCrdic6yQ/tnnvxkL0JtHrQkQNN
         cqA5m+7KoAdd+5PW4cu2AdavVjJYtVM+Ce4dcA1i81UHD0RrxalptaLK3K79JRgdYtTD
         Yk1f3urfTp7zKYciz0+bSEtH2TiOY4Rg1eGZtfOJatXCtNkjGze5wPgEo2QXJfodIzXN
         1S/Q==
X-Gm-Message-State: APjAAAXJV6rzL5CUl+er5Gm1mMMcKHoSFRhAXTmMX3fCmTJ8zLpI3JNq
        WOtHKYDYdxJhJMerUkJUAaY5QCTe
X-Google-Smtp-Source: APXvYqxJkkSHQ9npLnwFFXQkC7wkCuiNCDLBpEgy1EDEPVqTYZBZJrdqvsIbWv78mAIBO44NfjVLbA==
X-Received: by 2002:adf:b219:: with SMTP id u25mr22641523wra.327.1571016700630;
        Sun, 13 Oct 2019 18:31:40 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z142sm26133956wmc.24.2019.10.13.18.31.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 13 Oct 2019 18:31:40 -0700 (PDT)
Message-Id: <3dc8687d9f93a08cdb9e7de8d159df6aa0b05c02.1571016698.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.396.git.1571016698.gitgitgadget@gmail.com>
References: <pull.396.git.1571016698.gitgitgadget@gmail.com>
From:   "kdnakt via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 14 Oct 2019 01:31:38 +0000
Subject: [PATCH 1/1] Improve Japanese translation
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, kdnakt <a.kid.1985@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: kdnakt <a.kid.1985@gmail.com>

Signed-off-by: kdnakt <a.kid.1985@gmail.com>
---
 git-gui/po/ja.po | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/git-gui/po/ja.po b/git-gui/po/ja.po
index 208651c1af..2f61153ab9 100644
--- a/git-gui/po/ja.po
+++ b/git-gui/po/ja.po
@@ -4,14 +4,15 @@
 #
 # しらいし ななこ <nanako3@bluebottle.com>, 2007.
 # Satoshi Yasushima <s.yasushima@gmail.com>, 2016.
+# KIDANI Akito <a.kid.1985@gmail.com>, 2019.
 #
 msgid ""
 msgstr ""
 "Project-Id-Version: git-gui\n"
 "Report-Msgid-Bugs-To: \n"
 "POT-Creation-Date: 2016-05-27 17:52+0900\n"
-"PO-Revision-Date: 2016-06-22 12:50+0900\n"
-"Last-Translator: Satoshi Yasushima <s.yasushima@gmail.com>\n"
+"PO-Revision-Date: 2019-10-13 23:20+0900\n"
+"Last-Translator: KIDANI Akito <a.kid.1985@gmail.com>\n"
 "Language-Team: Japanese\n"
 "Language: ja\n"
 "MIME-Version: 1.0\n"
@@ -661,7 +662,7 @@ msgstr ""
 #: lib/merge.tcl:108
 #, tcl-format
 msgid "%s of %s"
-msgstr "%s の %s ブランチ"
+msgstr "%2$s の %1$s ブランチ"
 
 #: lib/merge.tcl:122
 #, tcl-format
@@ -956,7 +957,7 @@ msgstr "エラー: コマンドが失敗しました"
 #: lib/checkout_op.tcl:85
 #, tcl-format
 msgid "Fetching %s from %s"
-msgstr "%s から %s をフェッチしています"
+msgstr "%2$s から %1$s をフェッチしています"
 
 #: lib/checkout_op.tcl:133
 #, tcl-format
-- 
gitgitgadget
