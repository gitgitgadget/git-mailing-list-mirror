Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5B3321F404
	for <e@80x24.org>; Tue,  4 Sep 2018 21:59:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727509AbeIEC06 (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Sep 2018 22:26:58 -0400
Received: from mail-pl1-f180.google.com ([209.85.214.180]:45746 "EHLO
        mail-pl1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727181AbeIEC06 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Sep 2018 22:26:58 -0400
Received: by mail-pl1-f180.google.com with SMTP id j8-v6so2248221pll.12
        for <git@vger.kernel.org>; Tue, 04 Sep 2018 14:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=2ixSU6PHucyAWfMN/9FaXxeHmhWoTLc4HVhvEmNW0zM=;
        b=an+8rqndHdTX1LDzZOStflpnd8tZfxpA2kWxpUjizslI3rWdXzuIOTXCTpKwuZ2ajF
         NxezzjG34xB5a17bN6iv5AXozlGPBUbhsIcEKXk93dNLaPnNQPYR8Ek5ChoQj01K5W2K
         oQ848xLZfjZP12F+JGpZ9gNWgzhkMoQyxkF1+qbVKAZolZf32FIKUAYONGvqVRK1+0+h
         JBN3TZ6iHrV2ruHp7IeiYK8LWlodKMjVCPUN4m+brEMAcWG5F2NrWWlXmsTRdlJgPmnD
         Oz6iBhMLr+C9uiqqSDFpHWSUcMZRSrgLH9M8lXrcn3bOt2SMjO+Z+XDiLEmsKocutaKa
         4uPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=2ixSU6PHucyAWfMN/9FaXxeHmhWoTLc4HVhvEmNW0zM=;
        b=K1yewwEK+Ko6wzUacxE00zaX06w0JoP73XUZCf1nTLoB6fEuw1JFL63nuDzBTeoO8c
         X7sqt+135QMrixOaFA0GkUrHkfiIlsgq3vL0q+EaTLVkV/F45gxyaSm7hPpoy7fk+Iuj
         vTabimY/nYw//Pwk7uWvHNVr1Qjp6ZQHjSk7O5MoOM5ke29hbRxoSLVBV38ENhECGK2X
         AkbCriiaWaEltuoeJ4XjheR6Cgx0WwCvM2jWesEHPcVHkG+VdjyhOf65Boys2UhMW/W1
         3/YKRm6Zqawi/mVl2Rssj/XniYTZemCi7UO4jd61FShI016DXkZ+NLjNnyipW0dgcXaI
         YPhw==
X-Gm-Message-State: APzg51BcuSRAdFehI2is6hBvBHekpDoQ3PnqQjxwL+N/4jHcyf9DAk8v
        yEWde7gNNIP0RaDdGdKYPXUo+p8a
X-Google-Smtp-Source: ANB0VdZqQFaGv9xztJmfizZfPSEOzaK+DPINF4TRUkT/UrYYmulpb5mRZQwR+fshgAZ+1yRu08Md5w==
X-Received: by 2002:a17:902:4d46:: with SMTP id o6-v6mr35261193plh.59.1536098394110;
        Tue, 04 Sep 2018 14:59:54 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.142.204])
        by smtp.gmail.com with ESMTPSA id h132-v6sm33994169pfc.100.2018.09.04.14.59.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Sep 2018 14:59:53 -0700 (PDT)
Date:   Tue, 04 Sep 2018 14:59:53 -0700 (PDT)
X-Google-Original-Date: Tue, 04 Sep 2018 21:59:31 GMT
Message-Id: <8f67a3969dc01669b5edd045e2ff92e45a08fb9d.1536098386.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.33.v2.git.gitgitgadget@gmail.com>
References: <20180808152140.14585-1-predatoramigo@gmail.com>
        <pull.33.v2.git.gitgitgadget@gmail.com>
From:   "Pratik Karki via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 04/18] builtin rebase: support
 --committer-date-is-author-date
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Pratik Karki <predatoramigo@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Pratik Karki <predatoramigo@gmail.com>

This option is simply handed down to `git am` by way of setting the
`git_am_opt` variable that is handled by the `git-rebase--am` backend.

Signed-off-by: Pratik Karki <predatoramigo@gmail.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/rebase.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 1729d2d9e2..eef16206c2 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -526,6 +526,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		ACTION_EDIT_TODO,
 		ACTION_SHOW_CURRENT_PATCH,
 	} action = NO_ACTION;
+	int committer_date_is_author_date = 0;
 	struct option builtin_rebase_options[] = {
 		OPT_STRING(0, "onto", &options.onto_name,
 			   N_("revision"),
@@ -543,6 +544,9 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 			PARSE_OPT_NOARG, NULL, REBASE_DIFFSTAT },
 		OPT_BOOL(0, "signoff", &options.signoff,
 			 N_("add a Signed-off-by: line to each commit")),
+		OPT_BOOL(0, "committer-date-is-author-date",
+			 &committer_date_is_author_date,
+			 N_("passed to 'git am'")),
 		OPT_BIT('f', "force-rebase", &options.flags,
 			N_("cherry-pick all commits, even if unchanged"),
 			REBASE_FORCE),
@@ -763,6 +767,12 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	if (!(options.flags & REBASE_NO_QUIET))
 		strbuf_addstr(&options.git_am_opt, " -q");
 
+	if (committer_date_is_author_date) {
+		strbuf_addstr(&options.git_am_opt,
+			      " --committer-date-is-author-date");
+		options.flags |= REBASE_FORCE;
+	}
+
 	switch (options.type) {
 	case REBASE_MERGE:
 	case REBASE_INTERACTIVE:
-- 
gitgitgadget

