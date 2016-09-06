Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7E90F1F6BF
	for <e@80x24.org>; Tue,  6 Sep 2016 16:04:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934218AbcIFQEC (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Sep 2016 12:04:02 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:32796 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932874AbcIFQEB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Sep 2016 12:04:01 -0400
Received: by mail-pf0-f193.google.com with SMTP id 128so264279pfb.0
        for <git@vger.kernel.org>; Tue, 06 Sep 2016 09:04:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Z4TYxq1IDKsMJXRcalUTmnL3+YMNa5GFOygZaHxrrxs=;
        b=dZxTwvBbnSF62WTCbiUh/u4O3ZRLHy15BfQV/PQu1G8PP6Ss6D0Rql9YIIfqgUOUwd
         ogaIUf35OO8DLXk5POcVsE9aiSg/o6OFa4p9o62E5G3dXTTYLlpZUAyCTlU87zhkMYvo
         crOMtpmHX1i8FU3V3m5stXEOMWUhCRg1uVFWAGwMSECr9cKrJLD0QqqEjOmh/m5/KLvI
         Nh2xAgxVd2IiemZfQNV7kdCHtx+QSoT/Sd04MTaHeSEFaQtqKtdvejddTAvvFjzF7CcF
         MPmJGm5wYedeXgc8PZNzMHoYvMSfwymenuyKKgSsmKSSJMGa2aq4fOchhW2efbTZqRQd
         ePBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Z4TYxq1IDKsMJXRcalUTmnL3+YMNa5GFOygZaHxrrxs=;
        b=VwKHOgKxHcDS+00AVUubcunAeWJXyW9UpXQbAmkDqyAblX8wTSvsXx/2HkgM1pOY2U
         exDSrX62uTKSUcpcjVdo2gJCJC7/4cTOD+NjhoeHcXv0Oh8JAPlja0Xk7nXNrTJrFdV7
         A8OLJfymGPJ8wMFDqg+vMu2TMQ85fjNRg3awkxHm5y5OVArxQySZE3/jb9sd/hf0Qrae
         P+MBOd1FlCy3dzGDgIXaOvY645GO9o7lAcDPV5j8/C01Pk50NQysnC5v6YaDnDIDM+P5
         vfW0yLLa/vIoleD8HNUoCnsHPbY7srQRJtLwA+zg9NLfC5Q+N8e4rF4cO7FOJgAztENM
         8kEA==
X-Gm-Message-State: AE9vXwPyGjRpxUfAiTDM4XSMwmmKaWHTG3yFaNWQcj0hy8hsLSdkb7mXrgRW63TazRSPMg==
X-Received: by 10.98.31.219 with SMTP id l88mr73985912pfj.155.1473177840994;
        Tue, 06 Sep 2016 09:04:00 -0700 (PDT)
Received: from localhost.localdomain (i60-35-214-133.s41.a017.ap.plala.or.jp. [60.35.214.133])
        by smtp.gmail.com with ESMTPSA id tj5sm42207792pab.37.2016.09.06.09.03.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 06 Sep 2016 09:03:55 -0700 (PDT)
From:   Satoshi Yasushima <s.yasushima@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Jakub=20Nar=C4=99bski?= <jnareb@gmail.com>,
        Pat Thoyts <patthoyts@users.sourceforge.net>,
        Satoshi Yasushima <s.yasushima@gmail.com>
Subject: [PATCH v2 1/6] git-gui: consistently use the same word for "remote" in Japanese
Date:   Wed,  7 Sep 2016 01:02:16 +0900
Message-Id: <1473177741-9576-1-git-send-email-s.yasushima@gmail.com>
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

