Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8EA5A2021E
	for <e@80x24.org>; Sun, 20 Nov 2016 12:26:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752315AbcKTM0v (ORCPT <rfc822;e@80x24.org>);
        Sun, 20 Nov 2016 07:26:51 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:32856 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751243AbcKTM0v (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Nov 2016 07:26:51 -0500
Received: by mail-pg0-f66.google.com with SMTP id 3so25646196pgd.0
        for <git@vger.kernel.org>; Sun, 20 Nov 2016 04:26:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=C0+ukF941cEKtq/SbSDB7cY3iM34rj0hbsz7SC4IJSU=;
        b=ATXL8jvab0vdDk0DqNyM3B059ykV6KqQJA1qu4rTP9QC2uaaNDYPtIdQvUVXzs6WIT
         EstcfJGuGqoEx0bNmqAKtjBAYyyn3QjUYR0XNPOrcVF/hh2hipsMIuskmEO20/jgixUT
         WAICUXK0qv+OykFS+HF4ujZpbdjcp8dMokpBPdWD+/dveKoS9ENqNFcok99GcvArxDuk
         ya8VWdeOMwd6p/159KHUqC1FxaSr4TWbzuxoGpYxN2nRD/3mhQ90GL47VuJHphHVf/8z
         1qlYDFmShR+4dsY9/hf5k47LcFcG8OtYS6i4dM5eIwahhI9KjDdlBIqXt+ASH55ebgF+
         UhfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=C0+ukF941cEKtq/SbSDB7cY3iM34rj0hbsz7SC4IJSU=;
        b=Rb7pk/XzIhJ02jZtF1pKMUYHwg+5gwEtzezCnm/iqVIATLDDkTuabRlSwQuI7VfyB6
         EUz0PBR7SuTBnyi9ZjRjp5bEcl7yMdXbzGdJqwStXQ9q4bwAIeGxxpmdwS3gvmEl0J++
         WWKLfetien7QwnWhPQTn7Iu7q18SWyYSiIpO+7xKJP8yb0+IwIMsFQV21UdygzkUOCtF
         oISKyJUtaqMhe1rXrjqF5gSrZi6cDtWQlVgsVf1jwVafmBEEcFa1BhuMJ1ey12ijP1MV
         oQsxZ74ulsVlo6KuIhfPD5R+KXK1w7zhfr1+XQQtqKTRWLfOuJXPGfKGY20b3gBH1ETY
         x12Q==
X-Gm-Message-State: AKaTC02pQwAE10kG/QHRgrHp8mB9ZeuaSYb9blCGwTdNBOFd1jhU2+zgiS15r2i2VJRLtw==
X-Received: by 10.98.152.3 with SMTP id q3mr11131477pfd.144.1479644797546;
        Sun, 20 Nov 2016 04:26:37 -0800 (PST)
Received: from localhost.localdomain (ec2-52-196-48-101.ap-northeast-1.compute.amazonaws.com. [52.196.48.101])
        by smtp.googlemail.com with ESMTPSA id n8sm3803055pgd.29.2016.11.20.04.26.33
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Sun, 20 Nov 2016 04:26:36 -0800 (PST)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     Git List <git@vger.kernel.org>,
        Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH] i18n: Fixed unmatched single quote in error message
Date:   Sun, 20 Nov 2016 20:26:17 +0800
Message-Id: <721cdca4d000627fa163da15c515a50fd9529a62.1479644251.git.worldhello.net@gmail.com>
X-Mailer: git-send-email 2.11.0.rc0.11.g127c283
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fixed unmatched single quote introduced by commit:

 * f56fffef9a sequencer: teach write_message() to append an optional LF

Signed-off-by: Jiang Xin <worldhello.net@gmail.com>
---
 sequencer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sequencer.c b/sequencer.c
index 6f0ff9e413..30b10ba143 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -248,7 +248,7 @@ static int write_message(const void *buf, size_t len, const char *filename,
 	}
 	if (append_eol && write(msg_fd, "\n", 1) < 0) {
 		rollback_lock_file(&msg_file);
-		return error_errno(_("could not write eol to '%s"), filename);
+		return error_errno(_("could not write eol to '%s'"), filename);
 	}
 	if (commit_lock_file(&msg_file) < 0) {
 		rollback_lock_file(&msg_file);
-- 
2.11.0.rc0.11.g127c283

