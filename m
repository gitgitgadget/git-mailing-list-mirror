Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1558920248
	for <e@80x24.org>; Thu, 14 Mar 2019 15:33:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726952AbfCNPdL (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Mar 2019 11:33:11 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:37976 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726691AbfCNPdL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Mar 2019 11:33:11 -0400
Received: by mail-ed1-f67.google.com with SMTP id e10so1099613edy.5
        for <git@vger.kernel.org>; Thu, 14 Mar 2019 08:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=IfWMkShrQ41KDDbzpbDKXZwOBGskdmyj8PRyBF7JQKU=;
        b=nF4bmMTaBh8OE7b3aGcWr71E0PpoQZWcZS2Tcr1QKU8H9IPJyw8ojNwac3lsywam/a
         QOSzOD8HeHry81+2vBobujPV4JuvDY8hZmxooLp5n1u95qU2xTySlEAzeWWXlXHfRV+W
         CSi3HsOhNpTvTK+/ZrJZGglmc+ElrMPc6hIBj7QQsmAQq126G5zgWPUdyDsBlSuuDPB8
         f9rWy7UaYahGr/+QHZSWwWh9eaRpe99MOd1adLaZn3/w436zKan7rcxTZlwNE2LIzo42
         GxU1528LpET6JSKCUz0KDhW4+mgCtEuu7cgwMgz1bZQpIZGpTKjd2MesWS210B8Pvr7Z
         Xr5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=IfWMkShrQ41KDDbzpbDKXZwOBGskdmyj8PRyBF7JQKU=;
        b=XKaiX5Yp7c/JUygqvpfp+6lHJgNGEp0yEhKAdC5e3f1YgF3D/JKAVzvgAThhgpd8Dl
         XiDiHfGJrIW5nAsSV3D8sLT/w9429eN6O8QHJRv8DGK49cTMPJgf96EjexAa7xtq5Ebt
         vBDKrqUwAk5xx7H/kHDTjoD+aH/eNLGNq3BctfmEI6QL6yO3pR1QR5m41JSkrAwOsTN5
         0SAskk21Y+JbxEpjsCHY7ZR9VsjFSrK4lpPP3PBSzx9onqrBXYpBn3t6ktZV1WJg6vm1
         Enci5Zk8Rgq9XwRc9E+uUmSwfVADfZqS4z+YOhG1Bi4yQRLGpGnKDCoYVCaJP19y8MvE
         WA0g==
X-Gm-Message-State: APjAAAWFnB0x3z6sqoEBgOHFlMtzLPnoyrGIhF/o2Ybx/ReHgXiAIxA2
        WxhxWKZJMUPtBMlAYwsvhsBKQCNF
X-Google-Smtp-Source: APXvYqyw8SPDVWk+TFaX3gR5goQ2yjtjOy5DjMFWxsBjToC6D6ffRquclCLic9TVD1OCv6Tk6g1oww==
X-Received: by 2002:a50:a484:: with SMTP id w4mr11815917edb.193.1552577589747;
        Thu, 14 Mar 2019 08:33:09 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n3sm176785edc.7.2019.03.14.08.33.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Mar 2019 08:33:09 -0700 (PDT)
Date:   Thu, 14 Mar 2019 08:33:09 -0700 (PDT)
X-Google-Original-Date: Thu, 14 Mar 2019 15:33:05 GMT
Message-Id: <b55e14cd63be82deb4f216074b8d4311364787c7.1552577586.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.161.v2.git.gitgitgadget@gmail.com>
References: <pull.161.git.gitgitgadget@gmail.com>
        <pull.161.v2.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 3/4] sequencer: move stale comment into correct location
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sequencer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sequencer.c b/sequencer.c
index f91062718d..79a046d748 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -3641,7 +3641,6 @@ static int pick_commits(struct repository *r,
 			res = do_exec(r, item->arg);
 			*end_of_arg = saved;
 
-			/* Reread the todo file if it has changed. */
 			if (res) {
 				if (opts->reschedule_failed_exec)
 					reschedule = 1;
@@ -3649,6 +3648,7 @@ static int pick_commits(struct repository *r,
 				res = error_errno(_("could not stat '%s'"),
 						  get_todo_path(opts));
 			else if (match_stat_data(&todo_list->stat, &st)) {
+				/* Reread the todo file if it has changed. */
 				todo_list_release(todo_list);
 				if (read_populate_todo(r, todo_list, opts))
 					res = -1; /* message was printed */
-- 
gitgitgadget

