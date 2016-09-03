Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6854F1F6BF
	for <e@80x24.org>; Sat,  3 Sep 2016 14:44:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753296AbcICOou (ORCPT <rfc822;e@80x24.org>);
        Sat, 3 Sep 2016 10:44:50 -0400
Received: from mail-pa0-f54.google.com ([209.85.220.54]:36498 "EHLO
        mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753146AbcICOot (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Sep 2016 10:44:49 -0400
Received: by mail-pa0-f54.google.com with SMTP id fu3so41130131pad.3
        for <git@vger.kernel.org>; Sat, 03 Sep 2016 07:44:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=518sPJzdnpVs7u7ehEkDni6fVFq2o5UoOwDdmBgGeWA=;
        b=wBEVFFbpVYj+HgvYI5HqI5UiX7AarKd6UNsdfmK261EN8B2/ERStzdv/w9vJ9ZnuGK
         0QQPp/r1SkoyCP2tactI8sDorfaiW/TdX9uY03sh2kmZooIb+Bz5YUVA1YP+8rGeCE6q
         837knRfjTeZ5LVifaXKDNhpELDiEVygvUyaxCl5vuH0R738BC3iy3+FCA6ExcChQp7TK
         +Vy1lOJvoDpVme/mfQT1pPjnusFZ48YSCr+Eg38/nBdQNNvuReBhbcNoZ8WVKgUMih8m
         AUpaTc1tq4mzDbRWrt6EiPbr0yLfgwKTrvnloHtXu51YkTvFGIfMLl1Tyv4cD8WcF1ux
         klVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=518sPJzdnpVs7u7ehEkDni6fVFq2o5UoOwDdmBgGeWA=;
        b=V9ExaD6iYPAccKOozGn5LgfUtxXtnHyVIk6tdfUJmoaANb+u0L2OpQo/8m705y492T
         +Q3FXkJbqyJBgwL3mrvnb2tknJjx3k16uFv2xM8mqwoDxWtmCZ2Iu8zTbTI/MZjFNdvn
         qz07zgLFgf/GrJn2/OaB7fVIF89RfxG6wesop821t/gtwmUxJFzVB2piyS9nfxB8xtBd
         WXdaa7SIcGSo42kOf1nBuY2Xbz7ZWmKqKtwLkwPW7PcAJ1d+KklMt2PTBFRCRKeH3Icy
         olMz7OWLT1ne9WPkihrtiraaCn9plc2xe6aaUdG6/UqO/A9/NwqkdefxIHad2/6Ag1Vw
         r+YQ==
X-Gm-Message-State: AE9vXwMSIuHOSsMjJNPvqx4Yms4SRoRYYClKEsfU8G5VcSXdL0cJvb3Bnvra8FHDPci9dw==
X-Received: by 10.66.193.163 with SMTP id hp3mr46706427pac.73.1472913889065;
        Sat, 03 Sep 2016 07:44:49 -0700 (PDT)
Received: from localhost.localdomain (i60-35-214-133.s41.a017.ap.plala.or.jp. [60.35.214.133])
        by smtp.gmail.com with ESMTPSA id p74sm6755840pfk.68.2016.09.03.07.44.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 03 Sep 2016 07:44:48 -0700 (PDT)
From:   Satoshi Yasushima <s.yasushima@gmail.com>
To:     git@vger.kernel.org
Cc:     Pat Thoyts <patthoyts@users.sourceforge.net>,
        Satothi Yasushima <s.yasushima@gmail.com>
Subject: [PATCH 2/6] git-gui: The term unified for blame in Japanese
Date:   Sat,  3 Sep 2016 23:43:38 +0900
Message-Id: <1472913822-9088-2-git-send-email-s.yasushima@gmail.com>
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
 po/ja.po | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/po/ja.po b/po/ja.po
index 8a2c16f..b692b5c 100644
--- a/po/ja.po
+++ b/po/ja.po
@@ -598,7 +598,7 @@ msgstr "文脈を見せる"
 
 #: lib/blame.tcl:291
 msgid "Blame Parent Commit"
-msgstr "親コミットを註釈"
+msgstr "親コミットを注釈"
 
 #: lib/blame.tcl:450
 #, tcl-format
@@ -2052,7 +2052,7 @@ msgstr "コピーを検知する最少文字数"
 
 #: lib/option.tcl:151
 msgid "Blame History Context Radius (days)"
-msgstr "註釈する履歴半径（日数）"
+msgstr "注釈する履歴半径（日数）"
 
 #: lib/option.tcl:152
 msgid "Number of Diff Context Lines"
-- 
2.8.2.windows.1

