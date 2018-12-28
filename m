Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A58B81F405
	for <e@80x24.org>; Fri, 28 Dec 2018 23:36:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727689AbeL1XgN (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Dec 2018 18:36:13 -0500
Received: from sonic303-25.consmr.mail.ne1.yahoo.com ([66.163.188.151]:33302
        "EHLO sonic303-25.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726113AbeL1XgN (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 28 Dec 2018 18:36:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rogers.com; s=s2048; t=1546040171; bh=mlgyL+T8S9xvxhCTTA/WarflDD3NUXQLoTA5RCcCn/c=; h=From:To:Cc:Subject:Date:From:Subject; b=TcVBf6+UdgPObBZMlSevHI0p5EOdwHHuBNMCcXh3JP7rPMjmQZybZ8WYxIy1B6Ebl3ZFGuNLbRbvYefcoFRRPWARvEtznqwyz71xsh3kGzJQYIiVTRmq8S/kLYP+a1DEKizQBdXFDYXJ7tKgJAHk5egAr/n6KvuZ/1LLD2AEcb9UX4Xpldsy69hVe1eDOXsgq8bwAVTZJypQxbG9tDaDYy45YKvlaihSe+JbmUxjSRIjQRYz+AtWnVIWQmGYXI9R4JYA7qcS84bo4F39f7DbvqXY5n9JQjKn1EW3PM2tvsQj7zLAxwcHcKhrz2EcN1oJT80a7X0QcRQzAIWx/e9zGQ==
X-YMail-OSG: eCsV_7oVM1mhQnn.VfPLR8QmVhRswTjZ3ZgaRCOPfixIJENo9gggSDNf7cqJiRx
 jhEJmt4nPgSOcsB4C3hAhSelJoxK0q7hhGW6stOHBIgYA3CebzwG1unGNJSi5XdHVVTfTVATjYmF
 Wm11su0FEAs0VaD9sXRNeRcywSOttimu1TFcOCFWk4zZdi2E9u97u28xzINHx2MyldCQ7q6UXgAu
 GqyxUDzh9fQu_BQOccAJKLI_osBcoVxXw.D3ScQPN722bczVVDTcWmOHSO_Km0m88Ov86TsCIqtZ
 S7P04jT6T2f0k63Ojg94vJCyqzWVuzqZHlw0d9mhgbL12HqqHPuw66a7ruX5YAGW.LncsJAzV0oJ
 8A77pueP2ebSNNwdu7sdyhTQ6y8eJxEkRP992CMlaLqqoct5li7gKwGPDoocRqnLnAkwPpDxUQkq
 MhnEl96V3cKFpJh86O2GkH6SJIfpKjKZqzJmjfMje3etzKbp6VmAOVBN3ruT56izCUVUYyYOFjFH
 1dz94QyCiUHIfKvlObOezFPlyJJESeM4VYUp5IJkDCw.aPRpXkFwtffssKbCGgwOFDcPJKzRlkHc
 8XBw3lxsgh.jms7vQgglW2NiFf4wD0QDbcNbrz_I1IaMyXrr5ACz5wROUXWyGHRuUp98qro64Jdz
 prQtrWWPRzb9STSzcobchTv_xLVxHD6E_FzBCKUWpXO2GkP1uNDy_coZNtT0GLOreTzUAWH3tUkk
 ZrbJgEOzAuxuwLyPPeXm832mmmLsWA9ZBUPPU3KfYRu2y9Hii0c4n2CmaA6ObY4QswDSJwJBpShB
 qBprriZtmKy7lrFgiLswVldlDd8_Ml3jxuXx_1_eY9nheHcnT0T5lF.qYXoKY1lCgOnKP8nFeRU.
 Zpa4tznV3B2dzmw9XC_cWjqJHuhmZMOGUj.CKdlZsGS27e9xDjOcdidCK_Ssu9fyvkohXGnGDVAP
 WoreGpDIz__VnMlyjgWoibPhwHWOxg_iJ3w57gZ8bfZRp7VgjhYH3Ova6TszGv3pAogeA51KVYWk
 4NR1ylxlz_6cXLjKc5ypGIjtfGDmne3GDwVAyUkGeH7wovGDf_rlAFiXPHwwzkQk9o79HW_SMfhB
 9tX4yraAvr.RLEo_tYh6zzUJm3Ms-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic303.consmr.mail.ne1.yahoo.com with HTTP; Fri, 28 Dec 2018 23:36:11 +0000
Received: from CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com (EHLO localhost.localdomain) ([99.229.179.249])
          by smtp430.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID e9d96662e29925b62b5d9cd3faf51bed;
          Fri, 28 Dec 2018 23:36:10 +0000 (UTC)
From:   randall.s.becker@rogers.com
To:     git@vger.kernel.org
Cc:     "Randall S. Becker" <rsbecker@nexbridge.com>
Subject: [PATCH v4 1/4] transport-helper: use xread instead of read
Date:   Fri, 28 Dec 2018 18:35:56 -0500
Message-Id: <20181228233556.5704-1-randall.s.becker@rogers.com>
X-Mailer: git-send-email 2.12.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Randall S. Becker" <rsbecker@nexbridge.com>

This fix was needed on HPE NonStop NSE and NSX where SSIZE_MAX is less than
BUFFERSIZE resulting in EINVAL. The call to read in transport-helper.c
was the only place outside of wrapper.c where it is used instead of xread.

Signed-off-by: Randall S. Becker <rsbecker@nexbridge.com>
---
 transport-helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/transport-helper.c b/transport-helper.c
index bf225c698f..a290695a12 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -1225,7 +1225,7 @@ static int udt_do_read(struct unidirectional_transfer *t)
 		return 0;	/* No space for more. */
 
 	transfer_debug("%s is readable", t->src_name);
-	bytes = read(t->src, t->buf + t->bufuse, BUFFERSIZE - t->bufuse);
+	bytes = xread(t->src, t->buf + t->bufuse, BUFFERSIZE - t->bufuse);
- 	if (bytes < 0 && errno != EWOULDBLOCK && errno != EAGAIN &&
- 		errno != EINTR) {
+ 	if (bytes < 0 && errno != EINTR) {
 		error_errno(_("read(%s) failed"), t->src_name);
-- 
2.17.0.10.gb132f7033

