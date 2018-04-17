Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C65B51F404
	for <e@80x24.org>; Tue, 17 Apr 2018 19:15:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752667AbeDQTPw (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Apr 2018 15:15:52 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:39628 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752634AbeDQTPv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Apr 2018 15:15:51 -0400
Received: by mail-wr0-f194.google.com with SMTP id q6so26376004wrd.6
        for <git@vger.kernel.org>; Tue, 17 Apr 2018 12:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mg6b2hr/AHfjcb0fkcZ01N8ar0xmPFqtTL73wYZVuk8=;
        b=PfQWIz861m+cT2qfrXytJUd944EEeGkpx5Tb0fuICmR3bll0QeO/7+NPdCUbt60kh5
         lmkbQtRwd4b+Y2t3olxcG8xzYfO/a9AwvuTskPk88uyDGaGBXvX0mwL5+5Rk8nJou/qZ
         HmCileu//h8c8uAl66ozyp5k2WNB2g1AYX4o96qnDyipnfiC+RWptJNYIJes7RQUKzS+
         4eJP/s7/fHMH3Xv9O36QQW0Vg1Kzw+MEp72obP2hZAmZPhTI8hQ26lUV/qoADsu/jG1I
         gYZfnh+K5j/Iav/O6ZadbOSEZRdKzLN2T9Xkx2GpFD4nUBVQOJBaJvB0CyPl6dtRwe+x
         H5oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mg6b2hr/AHfjcb0fkcZ01N8ar0xmPFqtTL73wYZVuk8=;
        b=ho2CLaSXY/fmkHl2DZEVV4I4XffTBo3MZOkOzp3czgx2gfbeNllH4G15YrVq5aKjEx
         0W1QLyYQsauF+8RK10duusGqGijXtU+0Q1p029IvWE67urlbi4B4NPmWaUnmHK0+1bg9
         LsJwxsJgAfq7rYbTJxlEYHuG8wYY3THGociNU3tsjq/h6/uzstKwtul+wspbwIUDIWa8
         OvnodYdiDMuqEeyIJ0yOa3ybgyd8IhR9JktJaOFd+nxIMj11J+lVzl1u3EX9HHrdIFob
         9KdL4VkJN1ZpsnclU7K/IZEcaB31Ve9tWwpOMXY0QD3HinQpNbRenCOZ7RpZxm/obzg/
         K8mQ==
X-Gm-Message-State: ALQs6tB3BOuVPAuVqJuo1GbMPBWjfc3kW5njdHBRKYt0SF+WWbPNhl51
        s5F2gzBOD1F5vEmv61Ezb9DqXQxe
X-Google-Smtp-Source: AIpwx49wjjSLD6+XZxhHGqdU4yYa+wvVVekK6lNgNGS1Qd9SRQ6o0uU93C4pOpOl3umFiKTXFrds7Q==
X-Received: by 10.28.14.70 with SMTP id 67mr1960014wmo.17.1523992550166;
        Tue, 17 Apr 2018 12:15:50 -0700 (PDT)
Received: from localhost.localdomain ([2a02:aa16:5782:c100:c938:fbb7:46f8:2405])
        by smtp.gmail.com with ESMTPSA id m62sm2745398wmc.41.2018.04.17.12.15.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 17 Apr 2018 12:15:48 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>
Subject: [PATCH 1/4] doc: convert \--option to --option
Date:   Tue, 17 Apr 2018 21:15:26 +0200
Message-Id: <e17f2ec4e78266a789c9c48c6afefdf53e15b7d5.1523991648.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.17.0.252.gfe0a9eaf31
In-Reply-To: <cover.1523991648.git.martin.agren@gmail.com>
References: <CAN0heSru4-VoCTxZ6OHU_jdTs0__xvRmd45Dd0H3L8apMKkW6w@mail.gmail.com> <cover.1523991648.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rather than using a backslash in \--foo, with or without ''-quoting,
write `--foo` for better rendering. As explained in commit 1c262bb7b
(doc: convert \--option to --option, 2015-05-13), the backslash is not
needed for the versions of AsciiDoc that we support, but is rendered
literally by Asciidoctor.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 Documentation/git-format-patch.txt | 2 +-
 Documentation/git-push.txt         | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
index 6cbe462a77..b41e1329a7 100644
--- a/Documentation/git-format-patch.txt
+++ b/Documentation/git-format-patch.txt
@@ -47,7 +47,7 @@ There are two ways to specify which commits to operate on.
 
 The first rule takes precedence in the case of a single <commit>.  To
 apply the second rule, i.e., format everything since the beginning of
-history up until <commit>, use the '\--root' option: `git format-patch
+history up until <commit>, use the `--root` option: `git format-patch
 --root <commit>`.  If you want to format only <commit> itself, you
 can do this with `git format-patch -1 <commit>`.
 
diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
index 5b08302fc2..34410f9fca 100644
--- a/Documentation/git-push.txt
+++ b/Documentation/git-push.txt
@@ -300,7 +300,7 @@ origin +master` to force a push to the `master` branch). See the
 	These options are passed to linkgit:git-send-pack[1]. A thin transfer
 	significantly reduces the amount of sent data when the sender and
 	receiver share many of the same objects in common. The default is
-	\--thin.
+	`--thin`.
 
 -q::
 --quiet::
-- 
2.17.0.252.gfe0a9eaf31

