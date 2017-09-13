Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 536E620286
	for <e@80x24.org>; Wed, 13 Sep 2017 13:05:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751803AbdIMNFl (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Sep 2017 09:05:41 -0400
Received: from a7-11.smtp-out.eu-west-1.amazonses.com ([54.240.7.11]:54318
        "EHLO a7-11.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751019AbdIMNFk (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 13 Sep 2017 09:05:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=shh3fegwg5fppqsuzphvschd53n6ihuv; d=amazonses.com; t=1505307939;
        h=From:To:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
        bh=3DZyF8dvYVi8h0clcoFeSF82bKTe+RfA7nbVxuhkYWE=;
        b=WwexBDUIpgMmysuMG0qdh4zYLrfUs4gEvNeRFmcaubiKtmS/jXxoELHjVMGtLDcw
        5+aw4XuRr3g4esrm1xTyi+UyhSMrFG190kxdBp/4/J4H93R2UQv6YZn7JA7OBARRf09
        +A4E85u3kVFQUZRze2aOFCKjrY+fGeNuQVA4Dgww=
From:   Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
To:     git@vger.kernel.org
Message-ID: <0102015e7b585037-5f88e775-2696-49ec-8dd9-5e1635a34607-000000@eu-west-1.amazonses.com>
In-Reply-To: <<e656d1b4-c95e-e51d-5f48-bb3450580fa4@gmail.com>>
References: <<e656d1b4-c95e-e51d-5f48-bb3450580fa4@gmail.com>>
Subject: [PATCH v2] commit-template: change a message to be more intuitive
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date:   Wed, 13 Sep 2017 13:05:38 +0000
X-SES-Outgoing: 2017.09.13-54.240.7.11
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It's not good to use the phrase 'do not touch' to convey the information
that the cut-line should not be modified or removed as it could possibly
be mis-interpreted by a person who doesn't know that the word 'touch' has
the meaning of 'tamper with'. Further, it could make translations a little
difficult as it might not have the intended meaning in a few languages when
translated as such.

So, use more intuitive terms in the sentence.

Signed-off-by: Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
---
 wt-status.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/wt-status.c b/wt-status.c
index 77c27c51134d2..be53579760ee7 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -934,7 +934,7 @@ size_t wt_status_locate_end(const char *s, size_t len)
 
 void wt_status_add_cut_line(FILE *fp)
 {
-	const char *explanation = _("Do not touch the line above.\nEverything below will be removed.");
+	const char *explanation = _("Do not modify or remove the line above.\nEverything below will be removed.");
 	struct strbuf buf = STRBUF_INIT;
 
 	fprintf(fp, "%c %s", comment_line_char, cut_line);

--
https://github.com/git/git/pull/401
