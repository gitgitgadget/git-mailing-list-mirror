Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 337B11F453
	for <e@80x24.org>; Sat,  3 Nov 2018 14:32:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728605AbeKCXoF (ORCPT <rfc822;e@80x24.org>);
        Sat, 3 Nov 2018 19:44:05 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:42466 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726387AbeKCXoF (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Nov 2018 19:44:05 -0400
Received: by mail-lj1-f194.google.com with SMTP id f3-v6so4180950ljk.9
        for <git@vger.kernel.org>; Sat, 03 Nov 2018 07:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5Kq2Pr70fI6AgcB4NjiRqtfU2PcS3r7oMPNbqDlQnhQ=;
        b=teMrWM7c4/y814f9djwODySb+DoKU++GDHKMi4Zybt2wkInUm9f2JXwtMQDDpWsbW5
         CHpFU5CBt4eqs96QmT5jJpuTKuusMVk576w2i/kCmarjmiDadycDeDd1yV1KmJqgaBNn
         gP9YaOG9M+tBzEpvIynNRn4k/EZ6wkVKAbXTkR5BLkEpkq8zFgvH+JKksGLisNpZxNTt
         fbYrHPPKrHsO218SEppqOVrQmn80cODU75fVPn8g7s0Luyn14APzEAKDeDBoqly7Htwa
         thaicXWp0yiAvadiZpNqVLHqbv3aN5GzA5KjIVaTCJl1b0zXtcVvhYN7pNYZ+gne2HnU
         G6aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5Kq2Pr70fI6AgcB4NjiRqtfU2PcS3r7oMPNbqDlQnhQ=;
        b=E8SkpiV+1dxYxP95mczmXkTAAkdQjHH5pDC/tyhK4NlGwbotR47TDn9ir9YWr8nXLU
         fyNvqT72/G75FwOC6TjZ6oU1Rqqr1O6+CMp9a5m4gOmbDBQ81pUHbnN4wzRTUhtdV5u3
         s0N0VWAnFuDDRxfMNQpgmM5xdah3/aUp47Cl/edzJ7phhD8788eCNO5JSIcJz/m4QQ9r
         aUAgmSNrbfsfB3UxK9Zd0yV/Gv0m/JS5f4SXPNGVRaSvCW+FIWJsN/WnoWfh8uiSiuWQ
         Qyx/H9VSmZtFtxB/4NlI3vigdGutN5j0xKhErwT3Ps2e5mrw4MXW2WIOSm3gdgyCB3aK
         uJNA==
X-Gm-Message-State: AGRZ1gKTU6xuLY4bvharlx6yTHHMeUY2ueYJqQREbmMpcbPBjQY19icw
        biB94DVGqK3dbjoHk8i0OabcwU1L
X-Google-Smtp-Source: AJdET5cYs+m+APWNTrg0PHdzkKMPb2hGI985z+tClL+nF1q1WKXrhlzWogwrTLv+DQZMewL13ZkSEA==
X-Received: by 2002:a2e:9e53:: with SMTP id g19-v6mr11219935ljk.39.1541255553248;
        Sat, 03 Nov 2018 07:32:33 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id z8-v6sm4001576lfh.52.2018.11.03.07.32.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 03 Nov 2018 07:32:32 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH] sequencer.c: remove a stray semicolon
Date:   Sat,  3 Nov 2018 15:32:29 +0100
Message-Id: <20181103143229.8829-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.1.1005.gac84295441
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 On top of ag/rebase-i-in-c

 sequencer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sequencer.c b/sequencer.c
index 9e1ab3a2a7..92dca06462 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -4846,7 +4846,7 @@ int complete_action(struct replay_opts *opts, unsigned flags,
 
 	if (checkout_onto(opts, onto_name, oid_to_hex(&oid), orig_head))
 		return -1;
-;
+
 	if (require_clean_work_tree("rebase", "", 1, 1))
 		return -1;
 
-- 
2.19.1.1005.gac84295441

