Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1F1AD1F6BF
	for <e@80x24.org>; Sat,  3 Sep 2016 14:44:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752998AbcICOos (ORCPT <rfc822;e@80x24.org>);
        Sat, 3 Sep 2016 10:44:48 -0400
Received: from mail-pa0-f65.google.com ([209.85.220.65]:33031 "EHLO
        mail-pa0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752621AbcICOor (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Sep 2016 10:44:47 -0400
Received: by mail-pa0-f65.google.com with SMTP id vy10so6843316pac.0
        for <git@vger.kernel.org>; Sat, 03 Sep 2016 07:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Z4TYxq1IDKsMJXRcalUTmnL3+YMNa5GFOygZaHxrrxs=;
        b=js3BWB8pUi5umQqymLy7m8OLI00o1d1l4vnSzmDeBZ61RNHR/GVqtqq7dytRqQNNXz
         YbY1vnw5NVnlFAIC2LJdvpbyer+ZdKHjRtqCM1k9Tl6IwaEkT+nKv/a5twbU87TimPrZ
         ufoGHPy5FL+z1uwy2z1XaDOVrr9v/W9Tv2RaTGBXQaNrYbbTnZvtvNdR/dCHFbabRiu7
         9ljA32MiYfD1tumG5dqbXORvw3BMOYT1kvyvc0voeizRcGiY67kgteMau7Ib7IOK2x/Y
         qjvQxc04XMqc0xkL+zV4AdQOIkhOJzjR7jifBKMXSDghT4shNdtEURm7mSqd6AOsaaug
         Kk9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Z4TYxq1IDKsMJXRcalUTmnL3+YMNa5GFOygZaHxrrxs=;
        b=iAdq7UaFz+n/k0Q8RyoLFpmMPqgX6NLWcZBiBKRwWc99UxD55oLIlQnecb/4Eyl4bl
         oOkER4SKaUILakVRGIpTGvknxTsq2yx4KkdTMTdZp97qRNvzzYT+r5CP1F4qGXPBjAI+
         fTM3IpRUc5SMsKnf/+RqSUcyxYhvMEzNmE4NTY0Hl8M/IFVsamG5piTVUnDHvFqbKTaQ
         JRhX8M/78vI4kPhhVnudTLUsMGvKAJuOpG6cmz0dvOl46pNeCOW9N/B96CEaQmbVEuLe
         BD5RIHgbOhGG9toomMkcSZUEAjMNrQdI/cj0FMKe4uv63+nyNPC83mrvWycQTv0W1/C2
         +Fng==
X-Gm-Message-State: AE9vXwNqSZav2BCt1IyQmYmACJTQ+JnnB5H+WSR1UZZC2kowqQT2wPPvL/xOwyNl0Gs/JA==
X-Received: by 10.66.165.67 with SMTP id yw3mr46675094pab.8.1472913886395;
        Sat, 03 Sep 2016 07:44:46 -0700 (PDT)
Received: from localhost.localdomain (i60-35-214-133.s41.a017.ap.plala.or.jp. [60.35.214.133])
        by smtp.gmail.com with ESMTPSA id p74sm6755840pfk.68.2016.09.03.07.44.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 03 Sep 2016 07:44:45 -0700 (PDT)
From:   Satoshi Yasushima <s.yasushima@gmail.com>
To:     git@vger.kernel.org
Cc:     Pat Thoyts <patthoyts@users.sourceforge.net>,
        Satothi Yasushima <s.yasushima@gmail.com>
Subject: [PATCH 1/6] git-gui: The term unified for remote in Japanese
Date:   Sat,  3 Sep 2016 23:43:37 +0900
Message-Id: <1472913822-9088-1-git-send-email-s.yasushima@gmail.com>
X-Mailer: git-send-email 2.8.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Satoshi Yasushima <s.yasushima@gmail.com>
---
 po/ja.po | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/po/ja.po b/po/ja.po
index 9aff249..8a2c16f 100644
--- a/po/ja.po
+++ b/po/ja.po
@@ -765,7 +765,8 @@ msgstr "トラッキング・ブランチを選択して下さい。"
 #: lib/branch_create.tcl:140
 #, tcl-format
 msgid "Tracking branch %s is not a branch in the remote repository."
-msgstr "トラッキング・ブランチ %s は遠隔リポジトリのブランチではありません。"
+msgstr ""
+"トラッキング・ブランチ %s はリモートリポジトリのブランチではありません。"
 
 #: lib/branch_create.tcl:153 lib/branch_rename.tcl:86
 msgid "Please supply a branch name."
@@ -2192,7 +2193,7 @@ msgstr "%2$s にある %1$s をセットアップします"
 
 #: lib/remote_branch_delete.tcl:29 lib/remote_branch_delete.tcl:34
 msgid "Delete Branch Remotely"
-msgstr "遠隔でブランチ削除"
+msgstr "リモートブランチ削除"
 
 #: lib/remote_branch_delete.tcl:47
 msgid "From Repository"
@@ -2504,7 +2505,7 @@ msgstr "%s から新しい変更をフェッチしています"
 #: lib/transport.tcl:18
 #, tcl-format
 msgid "remote prune %s"
-msgstr "遠隔刈込 %s"
+msgstr "リモート刈込 %s"
 
 #: lib/transport.tcl:19
 #, tcl-format
-- 
2.8.2.windows.1

