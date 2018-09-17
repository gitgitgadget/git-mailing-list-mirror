Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7949A1F404
	for <e@80x24.org>; Mon, 17 Sep 2018 21:36:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728607AbeIRDFT (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Sep 2018 23:05:19 -0400
Received: from mail-pl1-f202.google.com ([209.85.214.202]:56900 "EHLO
        mail-pl1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728564AbeIRDFT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Sep 2018 23:05:19 -0400
Received: by mail-pl1-f202.google.com with SMTP id a10-v6so8208081pls.23
        for <git@vger.kernel.org>; Mon, 17 Sep 2018 14:36:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=UY9P6GTLun6sLU3lqilisBa+iFBbQb4RZUF6QIpwrXk=;
        b=VakmKE+cqAlQQNN9wlc1Y0P+bOV5pxJzTH6btE+8AbNg218CEdH2PmJCO9IdiGph1V
         JrCZNvw/XPIghPR9ZaBbO1a9TVyYIIhs+Mn95A79BckWJM58laoLlb8TLm/BKXO52/tk
         UwJqfNikj42hUjr/8QbZpkyXC/2/qtJfbKtwNpDYfIrgIXjqgykQ0zMSEQWyxHUAOH1V
         XigSl8RSVzfQA+AcYmSidRc+Bi1bDYiOuSozmr4en2VWMeMHwkJRyS/+vh8UCf5QQe2m
         9ieqLjQv2kRfP4SSSeN6Y49s8wVyOXWkWPbmIjnD5VwT8pTF39hmzGyQQP3VqWtm/Vuo
         sQUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=UY9P6GTLun6sLU3lqilisBa+iFBbQb4RZUF6QIpwrXk=;
        b=UB8LtJBtH7SH5D14RrlnWe15V9ZF97FsLIAW6rh7iPrKUopRW/CHLZR1uprsO8Qysl
         nxHjThZsueM6ZAAGkmhmZ7onlFP+4+SxMwOG9YjeTTWjjJMbY3DGUdUWRvj87mkYgfCa
         tInYPM1/+4J5lvcDsHGUnDrm3xyNy38vS0a2mUZTItccarMH/vbfnBPw1vLlJUgNwqIK
         dbJjBOpF8kAaWQZH0fOCgRBMe81Wq35jx2OWn0dNGzTQVUq1FXD5bG41EYj/9TgxEdsT
         nwRcukepaWVK5MDSGrMGgjJ9leDlZMqzLjsKpl2GpLZFU0oqkcppvL2grh6HY8XbRE1C
         cxNw==
X-Gm-Message-State: APzg51A6nh4qtAK3u7OUDojXelyDEG2mildEbjAut6BUbDs15JU7kKGA
        0BiFBCrWsYbyEMS9RU+RJVY2nXgUO5wy
X-Google-Smtp-Source: ANB0Vdal+PWpGL0h9cavv1EsPwoqTsdb3yOoO+bwm5ClKSsM/u6i75rbyM4JSR+SR+4Ptac2rbYWbPO0aIGN
X-Received: by 2002:a63:7945:: with SMTP id u66-v6mr1186132pgc.9.1537220169791;
 Mon, 17 Sep 2018 14:36:09 -0700 (PDT)
Date:   Mon, 17 Sep 2018 14:35:53 -0700
In-Reply-To: <20180917213559.126404-1-sbeller@google.com>
Message-Id: <20180917213559.126404-4-sbeller@google.com>
Mime-Version: 1.0
References: <20180911234951.14129-1-sbeller@google.com> <20180917213559.126404-1-sbeller@google.com>
X-Mailer: git-send-email 2.19.0.444.g18242da7ef-goog
Subject: [PATCH 3/9] submodule.c: fix indentation
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The submodule subsystem is really bad at staying within 80 characters.
Fix it while we are here.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 submodule.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/submodule.c b/submodule.c
index a2b266fbfae..d29dfa3d1f5 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1244,7 +1244,8 @@ static int get_next_submodule(struct child_process *cp,
 		if (!submodule) {
 			const char *name = default_name_or_path(ce->name);
 			if (name) {
-				default_submodule.path = default_submodule.name = name;
+				default_submodule.path = name;
+				default_submodule.name = name;
 				submodule = &default_submodule;
 			}
 		}
@@ -1254,8 +1255,10 @@ static int get_next_submodule(struct child_process *cp,
 		default:
 		case RECURSE_SUBMODULES_DEFAULT:
 		case RECURSE_SUBMODULES_ON_DEMAND:
-			if (!submodule || !unsorted_string_list_lookup(&changed_submodule_names,
-							 submodule->name))
+			if (!submodule ||
+			    !unsorted_string_list_lookup(
+					&changed_submodule_names,
+					submodule->name))
 				continue;
 			default_argv = "on-demand";
 			break;
-- 
2.19.0.397.gdd90340f6a-goog

