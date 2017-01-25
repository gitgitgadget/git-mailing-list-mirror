Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E2B541F6DC
	for <e@80x24.org>; Wed, 25 Jan 2017 12:51:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751641AbdAYMvd (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Jan 2017 07:51:33 -0500
Received: from mail-pf0-f194.google.com ([209.85.192.194]:33961 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751628AbdAYMvc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Jan 2017 07:51:32 -0500
Received: by mail-pf0-f194.google.com with SMTP id y143so14375610pfb.1
        for <git@vger.kernel.org>; Wed, 25 Jan 2017 04:51:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bI5n2KNB3VMJqXkw4oAatGF1+t6caAVK1BK5R+Gp9SA=;
        b=KYp8nD1bMEw0Dii9cr0LL0wZvm9BOVDdFIAtg3E/OijyvyM3D9KXVOmYvDpiQyDMYb
         r40reyQQ2eO3TDTJeyPH4HqnNw3s41Bzufri6FJfpG9seCo79EAmrNY1TOhX7LfTUbp1
         88Z1tpp6V0YHEMmFNo+qnxnR8MFBezf17OF3/tlUOe8wrbjsE3jA4/CxvziYx07StBQI
         huWAX66SxKcKLdM2QcmmBhyZOD44dgRbMG7j8w42t5fBoiQyTr98lUPlv9t7crQoGHaM
         Ovx3IKQPoLKBGcmJHTiaa1+b9RnCtiRAxz63w+lvjeSy3Grn7HVGexsoiMJtsk64K1Yx
         Um+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bI5n2KNB3VMJqXkw4oAatGF1+t6caAVK1BK5R+Gp9SA=;
        b=T6X0vwvwm0vPsslevpBeFtHXQzSmlsXJR2CPvrsJ4z6on/JYJbZdekP92HIGiiB96H
         ul20CBaCrzLZ5uRAN6HSIooLsAfkkguKdFewJr8WrN8tN+Ktbe29kfmQJJpntP8tC9D2
         AISoh9vKPR3lqnZaudlxparIvx8czA3wLf3+yZ6tdgaiuGzHAZvRhe2r+oTgpZa3BQnR
         f8fqye0oeI4WU15UYBfctANhgqn25LTyTjcQSH2PAvRtG0RldlqKqRqvB1f81KN7jVCa
         3dnomWqA4040TmhEGUq8udI3JvwEWOLt5cvO+wSOG9WWEMvHxxWPl6b+fEePIN/vRc9R
         GTrw==
X-Gm-Message-State: AIkVDXKK6nXU7iBSecjETbwnrT4gN7dCI4C9ur/xUWW0QNUGtL9p/hbeBqA5255sU+3zxw==
X-Received: by 10.84.217.202 with SMTP id d10mr3385880plj.53.1485348686513;
        Wed, 25 Jan 2017 04:51:26 -0800 (PST)
Received: from ash ([115.72.179.24])
        by smtp.gmail.com with ESMTPSA id r8sm1135556pfa.44.2017.01.25.04.51.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Jan 2017 04:51:25 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Wed, 25 Jan 2017 19:51:22 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, jacob.keller@gmail.com,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 1/5] rev-list-options.txt: delete an empty line
Date:   Wed, 25 Jan 2017 19:50:50 +0700
Message-Id: <20170125125054.7422-2-pclouds@gmail.com>
X-Mailer: git-send-email 2.11.0.157.gd943d85
In-Reply-To: <20170125125054.7422-1-pclouds@gmail.com>
References: <20170121140806.tjs6wad3x4srdv3q@sigill.intra.peff.net>
 <20170125125054.7422-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The convention has been option name is followed immediately by its
description without a line break.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 Documentation/rev-list-options.txt | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
index 5da7cf5a8d..1f948cfb13 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -161,7 +161,6 @@ parents) and `--max-parents=-1` (negative numbers denote no upper limit).
 	or '[', '/{asterisk}' at the end is implied.
 
 --exclude=<glob-pattern>::
-
 	Do not include refs matching '<glob-pattern>' that the next `--all`,
 	`--branches`, `--tags`, `--remotes`, or `--glob` would otherwise
 	consider. Repetitions of this option accumulate exclusion patterns
-- 
2.11.0.157.gd943d85

