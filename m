Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CA23B1F404
	for <e@80x24.org>; Mon, 29 Jan 2018 22:39:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751603AbeA2Wis (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Jan 2018 17:38:48 -0500
Received: from mail-oi0-f73.google.com ([209.85.218.73]:56532 "EHLO
        mail-oi0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751690AbeA2Wir (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Jan 2018 17:38:47 -0500
Received: by mail-oi0-f73.google.com with SMTP id l66so5909009oih.23
        for <git@vger.kernel.org>; Mon, 29 Jan 2018 14:38:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=ufp5eCN/PDOlDHXfCjI7h/BqPG85nHMhny56c6pPZYw=;
        b=hku9AO85ey8qRJaHzmMtbcIvXxCW27/UsLaJKMtge2xI7S2+ET3uxKGUoLqQGCTA2o
         XLfWLhHmbqSfML9YA3qNxqJF9FAnl7ZvvmUqsrPQIgeXXyapfsLcsIlOGuLKeW8am9gh
         ai+pv/kdZdZL38eXvDSdoeIIq/kEZlSkEAKMdiWmU0DZd4Cbe3n7WmqmTOF2b6lU+2HU
         V7GqNzzjfuWkSRLb/GEuk6CeQsGPQjOV9Qk06t5VBldjW+Cl2VZzddKWJDOEiZAvXB0Y
         lQatOBeG6uQC4xKchpdwjKPoGaRq2v6305mkVUWtjV2n3qZ5aSb3Is6y/aF5coeYs42N
         oBvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=ufp5eCN/PDOlDHXfCjI7h/BqPG85nHMhny56c6pPZYw=;
        b=DsRAwQgxZpCsgaAj58ww5B1I2Uv58sbeiAqD9MoBVTObZuy7kOoJo9QAyCbN3YBgZ8
         n4EcU1G3SQY6KjCkK3jKMrH0VE5ruXwgAB226lvEJO2IF25g2Qr3rKWMnnPRoZMBER1B
         RoOSNE2HZUGx5HnNOmN12nBnJlSPUjFF898FymT0eLdJ1guCzOIIMSoboADQxO+aReAr
         YzZg16oDOggwPaYIjqSP9M1fcA03pJlvX0dcSct4yu6F5J0riAxisLFOA300chTZ4Yzx
         QhvT7FLy7OzvQIwiroi6OOm2Zw+XgA/1MiSwVAnruK+9XakdvoBe9BzRpr6xdrbTBC1c
         1k4g==
X-Gm-Message-State: AKwxytdHdUKiEkqBXdYgPS+kAut0bMS7ZuZ1NKahrIjVIUD+5VVlo+x7
        zsAqM8TGS2CR9GONXeUpxfD73SMrBvmr+mN+XVjpnWStYx4/A9wHHZLHymY8rBgzGRiz39fEfnZ
        w0vRiV575H7o9tFrR6iB1c16Y85i95TZGWPHvF/QADg3HjUBdmPjVMcM5nw==
X-Google-Smtp-Source: AH8x226C8O+HC43slFZ4pYEBhp7yl2+1Y3uVUwSbmj0KO6rUS+ujRKnt2AtX4HE+c9M4PmHqHdEqfNet99k=
MIME-Version: 1.0
X-Received: by 10.157.65.155 with SMTP id p27mr7039543ote.27.1517265526420;
 Mon, 29 Jan 2018 14:38:46 -0800 (PST)
Date:   Mon, 29 Jan 2018 14:37:19 -0800
In-Reply-To: <20180129223728.30569-1-bmwill@google.com>
Message-Id: <20180129223728.30569-29-bmwill@google.com>
References: <20180129223728.30569-1-bmwill@google.com>
X-Mailer: git-send-email 2.16.0.rc1.238.g530d649a79-goog
Subject: [PATCH 28/37] trailer: rename 'new' variables
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     j6t@kdbg.org, avarab@gmail.com,
        Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rename C++ keyword in order to bring the codebase closer to being able
to be compiled with a C++ compiler.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 trailer.c | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/trailer.c b/trailer.c
index 3ba157ed0..5a4a2ecf9 100644
--- a/trailer.c
+++ b/trailer.c
@@ -174,12 +174,12 @@ static void print_all(FILE *outfile, struct list_head *head,
 
 static struct trailer_item *trailer_from_arg(struct arg_item *arg_tok)
 {
-	struct trailer_item *new = xcalloc(sizeof(*new), 1);
-	new->token = arg_tok->token;
-	new->value = arg_tok->value;
+	struct trailer_item *new_item = xcalloc(sizeof(*new_item), 1);
+	new_item->token = arg_tok->token;
+	new_item->value = arg_tok->value;
 	arg_tok->token = arg_tok->value = NULL;
 	free_arg_item(arg_tok);
-	return new;
+	return new_item;
 }
 
 static void add_arg_to_input_list(struct trailer_item *on_tok,
@@ -666,30 +666,30 @@ static void parse_trailer(struct strbuf *tok, struct strbuf *val,
 static struct trailer_item *add_trailer_item(struct list_head *head, char *tok,
 					     char *val)
 {
-	struct trailer_item *new = xcalloc(sizeof(*new), 1);
-	new->token = tok;
-	new->value = val;
-	list_add_tail(&new->list, head);
-	return new;
+	struct trailer_item *new_item = xcalloc(sizeof(*new_item), 1);
+	new_item->token = tok;
+	new_item->value = val;
+	list_add_tail(&new_item->list, head);
+	return new_item;
 }
 
 static void add_arg_item(struct list_head *arg_head, char *tok, char *val,
 			 const struct conf_info *conf,
 			 const struct new_trailer_item *new_trailer_item)
 {
-	struct arg_item *new = xcalloc(sizeof(*new), 1);
-	new->token = tok;
-	new->value = val;
-	duplicate_conf(&new->conf, conf);
+	struct arg_item *new_item = xcalloc(sizeof(*new_item), 1);
+	new_item->token = tok;
+	new_item->value = val;
+	duplicate_conf(&new_item->conf, conf);
 	if (new_trailer_item) {
 		if (new_trailer_item->where != WHERE_DEFAULT)
-			new->conf.where = new_trailer_item->where;
+			new_item->conf.where = new_trailer_item->where;
 		if (new_trailer_item->if_exists != EXISTS_DEFAULT)
-			new->conf.if_exists = new_trailer_item->if_exists;
+			new_item->conf.if_exists = new_trailer_item->if_exists;
 		if (new_trailer_item->if_missing != MISSING_DEFAULT)
-			new->conf.if_missing = new_trailer_item->if_missing;
+			new_item->conf.if_missing = new_trailer_item->if_missing;
 	}
-	list_add_tail(&new->list, arg_head);
+	list_add_tail(&new_item->list, arg_head);
 }
 
 static void process_command_line_args(struct list_head *arg_head,
-- 
2.16.0.rc1.238.g530d649a79-goog

