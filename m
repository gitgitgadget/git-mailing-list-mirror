Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B46C61F453
	for <e@80x24.org>; Wed, 23 Jan 2019 14:40:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726088AbfAWOka (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Jan 2019 09:40:30 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:40411 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726183AbfAWOk3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Jan 2019 09:40:29 -0500
Received: by mail-ed1-f68.google.com with SMTP id g22so1874541edr.7
        for <git@vger.kernel.org>; Wed, 23 Jan 2019 06:40:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=tz7VD9jZtEnv8yooHJRr2Q/rjZIeYRglb+VYrbixkYA=;
        b=BiVf4F3KEKetkdGJhp8Wk3rzjjOBtEDkGyQjct2p7jyHjCnj30iceIGbhYKQrCMXn8
         AR9nXI4Vvf/lS8yXtkACZa5dIlRKrpqqnu5P5xFfwbspBb0ZZxB/L1niwVeo+kK9t0F9
         VNwBRBVY7eN5YDmS5EYat823lghmNPGum20du2ZExOYA5NoHPiFXKpnqMtmm2QSAmAgu
         nMZtK/xvlVS+gpQVJPEQGQLSqEWKcK1puNDpPo0EBZnwvVjPi1qDkdx8GX4VTQt5HF1z
         j/80L4mpNC/loCNUsyTuydEVgI6waizGjvY9XLSRyMW6Lw4jZmPSQbqa/DyvSAf5RKtS
         xzcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=tz7VD9jZtEnv8yooHJRr2Q/rjZIeYRglb+VYrbixkYA=;
        b=cUO6RRhHXP9lozxW6WvuvLDHfDG0o/j40QKy5rNefZzBWFx16SvH+yYAoEddbZwG0Q
         t878SqmrAHokdKpj9G8pk3KIbWDNdrqIpnkLSbnYSjd+Y8yxdihsuwz1RB7+BDNWBTLi
         m7DAqp1igWhIgSq2tECKMZCCr/6cZPS+d64BOmNQITpEsH2DRAYqOCa8VWOi1d9hheMz
         cU8I/88KdDKRjDKYV3CAA0Wf/JTPy/aN4gdrQEHOL8oIc0+iLNJVrNAxORzh97weJQV1
         lwpYOcBz8aFmhWUGaN0IXB/rHf0doQemL4C0fYBf5gdIai49HKYD5Qv5GrLQrcFDpuRG
         Prcw==
X-Gm-Message-State: AJcUukfTkb1bJ6oidTzsniZO6E2VjU/VwbLCzmG1Vkgzzu4KfMJDHygs
        AIwE+Okpdxc1CfmsGbikwdEeZvlB
X-Google-Smtp-Source: ALg8bN7P9UIfJDZ0/h3tb1UFm5M0HXCwTLIUSbFQnwZ/dFVbjwBY8duP14bBX/ZCP/bQo8lRoKxlww==
X-Received: by 2002:a50:ac81:: with SMTP id x1mr3017050edc.71.1548254427820;
        Wed, 23 Jan 2019 06:40:27 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b14sm9915338edt.6.2019.01.23.06.40.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Jan 2019 06:40:27 -0800 (PST)
Date:   Wed, 23 Jan 2019 06:40:27 -0800 (PST)
X-Google-Original-Date: Wed, 23 Jan 2019 14:40:07 GMT
Message-Id: <59c1194ae2da0c4986f595ab9600c9dc518ef1b1.1548254412.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.31.v4.git.gitgitgadget@gmail.com>
References: <pull.31.v3.git.gitgitgadget@gmail.com>
        <pull.31.v4.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v4 16/21] mingw: try to work around issues with the test
 cleanup
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

It seems that every once in a while in the Git for Windows SDK, there
are some transient file locking issues preventing the test clean up to
delete the trash directory. Let's be gentle and try again five seconds
later, and only error out if it still fails the second time.

This change helps Windows, and does not hurt any other platform
(normally, it is highly unlikely that said deletion fails, and if it
does, normally it will fail again even 5 seconds later).

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/test-lib.sh | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index f31a1c8f79..9c0ca5effb 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -1104,7 +1104,11 @@ test_done () {
 			error "Tests passed but trash directory already removed before test cleanup; aborting"
 
 			cd "$TRASH_DIRECTORY/.." &&
-			rm -fr "$TRASH_DIRECTORY" ||
+			rm -fr "$TRASH_DIRECTORY" || {
+				# try again in a bit
+				sleep 5;
+				rm -fr "$TRASH_DIRECTORY"
+			} ||
 			error "Tests passed but test cleanup failed; aborting"
 		fi
 		test_at_end_hook_
-- 
gitgitgadget

