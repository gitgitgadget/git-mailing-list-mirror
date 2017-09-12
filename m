Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A844C209BA
	for <e@80x24.org>; Tue, 12 Sep 2017 10:55:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751326AbdILKzn (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Sep 2017 06:55:43 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:36421 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751289AbdILKzm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Sep 2017 06:55:42 -0400
Received: by mail-pg0-f65.google.com with SMTP id d8so5982882pgt.3
        for <git@vger.kernel.org>; Tue, 12 Sep 2017 03:55:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id;
        bh=v+kxt2Ch9BBQLBMqhtBRkK7NnHb4lN0LEhgHqMErGOI=;
        b=NS8q04uQIb+sUfOvDP/6HDhWlyaANvtk5pGrbW49p21bZyOwis2NSpUn76oBX8W4l8
         oN2qRbJV4gC8oYrshaO6PtDkXe+hS2+XuuSTwKI93R7J5mW+5EoIM2zTzhzhRAeJXu7d
         N/uKxo3V4fB5Zp93Vgr7BPQaxOZaedfQgTskzonnde2hZgjNEL8Pcc3Ad79Zn/KUEjlg
         9jt8inoa8mgmXKrHGq/rONmNcI5kx+x0bQw5CaQ0B87IijXRx9I/3Tjk6O1t/NnsPdm6
         E1D1uzBMTfqMDi5BJOrsMv5rgnqlwq4GLaL3uyUGjbErOpU3zsvfKqilWhpSINSKBx83
         M06Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=v+kxt2Ch9BBQLBMqhtBRkK7NnHb4lN0LEhgHqMErGOI=;
        b=NcjkGLwRjEkRSXNF0d3mow/f43zUHw9Ata22hL2XsNrPAJvSme8exINTu+gq8L9cgD
         cw9sFLisKKAJI0V+nzj7VOstOxIPnMnzQourOQZWIbtC1l7jQDYPGhdx/rENq3BlwtLq
         tCW/omUxUUiEaoHu8QarRhqdKRzthJiF9BySxrH7xpn3vRBJ7aAwMK6Ahr8w8AeJaRx6
         I18EvBH2bngz813nxoGrRFU5V7bDwJl/0fp+BE9aGeyI5z43BvUFyJpIv3ieC3WX4MoH
         GLX1hFR3D9fXB0uePaMgoX4ymRO2/A8ncWTWd12z/J8zP9kO/3EVcIThGvhkzeKPC2ko
         GQcQ==
X-Gm-Message-State: AHPjjUi6rAOeFJefDlSyH8POhXEth2EDrl9xGZ5p6bbonL60w6fo4r2Q
        JCBAGbFiNDuSnbCUYjmCcA==
X-Google-Smtp-Source: ADKCNb6o9AojSFA1Fu4rVHZ/lqp8yYw79plyWvUQYNq0ikUHEmEIG5Llfe2QHMKnZW4PNCBkNVsIvA==
X-Received: by 10.84.129.193 with SMTP id b59mr17215216plb.108.1505213741746;
        Tue, 12 Sep 2017 03:55:41 -0700 (PDT)
Received: from localhost.localdomain ([117.209.154.179])
        by smtp.gmail.com with ESMTPSA id z24sm22467370pfk.3.2017.09.12.03.55.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Sep 2017 03:55:41 -0700 (PDT)
From:   Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
To:     git@vger.kernel.org, gitster@pobox.com
Subject: [PATCH] commit-template: change a message to be more intuitive
Date:   Tue, 12 Sep 2017 16:25:36 +0530
Message-Id: <20170912105536.6094-1-kaarticsivaraam91196@gmail.com>
X-Mailer: git-send-email 2.14.1.1006.g90ad9a07c
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It's not possible to 'touch' the cut-line that is shown when the
user requests a patch in his commit template.

So, make the sentence more intuitive.

Signed-off-by: Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
---
 Just a small tweak. May or may not be worth the patch.

 wt-status.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/wt-status.c b/wt-status.c
index 77c27c511..1f54b1df2 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -934,7 +934,7 @@ size_t wt_status_locate_end(const char *s, size_t len)
 
 void wt_status_add_cut_line(FILE *fp)
 {
-	const char *explanation = _("Do not touch the line above.\nEverything below will be removed.");
+	const char *explanation = _("Do not edit the line above.\nEverything below will be removed.");
 	struct strbuf buf = STRBUF_INIT;
 
 	fprintf(fp, "%c %s", comment_line_char, cut_line);
-- 
2.14.1.1006.g90ad9a07c

