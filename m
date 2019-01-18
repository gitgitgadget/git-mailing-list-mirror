Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 44FF31F453
	for <e@80x24.org>; Fri, 18 Jan 2019 07:47:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727433AbfARHrM (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Jan 2019 02:47:12 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:33040 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727396AbfARHrK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Jan 2019 02:47:10 -0500
Received: by mail-ed1-f67.google.com with SMTP id p6so10450197eds.0
        for <git@vger.kernel.org>; Thu, 17 Jan 2019 23:47:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Eiglx/ZyLaUkVeXKBevUQCRjAV8+UqPW2VxjNNLfegc=;
        b=E+7PwsvHXgSXbd8G2Gdv4ODq0BKEHfxzZ0qHjS5ucp2Vf33ObXwlpf5r6Uh1OXwlHq
         NNkDT7/8p0ToXv4Uo8zolxoz6RXARDxbB72btg+QC1syD9nUqrjhe7K6L/TUJ2iUkb24
         tzmJuYGEmRFLjqeF7PzlYsFEq7kUH2OHbhlK/FJ5ucpN4cGf9IRZW+5fek1fiXNl/32S
         2ARortkcExLCeTsQeV5kvqnLG0D36ZEdvCWL5R4QjmPL+PW4iehK5Dy58LuHEbBECf//
         IGtuncHZy8jwHzb+5IF4PaWq5GI5JP7o0h73YEvtyY8p1SaiBFY5518nIOdL9ItoHhcs
         e2OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Eiglx/ZyLaUkVeXKBevUQCRjAV8+UqPW2VxjNNLfegc=;
        b=JJfjLIzT/XAX8oly6YK7owDPQvovti5MzHPzADynxH0nZMoXJZfIV4m3ME4V2qRk8B
         Pk6QjOc5SAQn7uuQoGmX5NfdBf7DK+inoUjSqnP01u1DFNbq1TVwSLhjtSKaSbpizfHu
         FF+769Q/HtJ5rrxFknhDkyMUlfcagvaHJnGYj7D5hUlI3YPPY98aKSBZpZ03HRQ09dlZ
         H2eJEjXyyEucnug/3mDGfraf18QSGgMyKindBTpe/eLInF5zXDNxNO/LEE66bOVzJmRa
         jHCA8lPIDxUXSrp/7zyJ3tRN9DhJU4JbVWCSC/kTbkaUtqaVfVaY1B5thA+ZNHYMtOwc
         vlRg==
X-Gm-Message-State: AJcUukcfEUMm60MLjDbuFMR3813VVZOoWBLQCZCcfYzu7WsMOvnnbMgt
        e5Qp9DZ55cWBceWefYL1HThzLL93
X-Google-Smtp-Source: ALg8bN5R4Cpq/FB6vYcTOHPOE0EFQ8fB2X2Pows7bH1d1/5uqWxSnLfpZkf0/e0ro1ejyBGIWboinw==
X-Received: by 2002:a50:acc3:: with SMTP id x61mr14650359edc.76.1547797628652;
        Thu, 17 Jan 2019 23:47:08 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k32sm7014167edb.42.2019.01.17.23.47.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Jan 2019 23:47:07 -0800 (PST)
Date:   Thu, 17 Jan 2019 23:47:07 -0800 (PST)
X-Google-Original-Date: Fri, 18 Jan 2019 07:47:00 GMT
Message-Id: <6ede6d92511d372eb30a78d59912135faad069aa.1547797620.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.103.v2.git.gitgitgadget@gmail.com>
References: <pull.103.git.gitgitgadget@gmail.com>
        <pull.103.v2.git.gitgitgadget@gmail.com>
From:   "Slavica Djukic via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 7/7] add--interactive.perl: use add--helper --show-help for
 help_cmd
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Slavica Djukic <slawica92@hotmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Slavica Djukic <slawica92@hotmail.com>

Change help_cmd sub in git-add--interactive.perl to use
show-help command from builtin add--helper.

Signed-off-by: Slavica Djukic <slawica92@hotmail.com>
---
 git-add--interactive.perl | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index a6536f9cf3..32ee729a58 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -1717,16 +1717,7 @@ sub quit_cmd {
 }
 
 sub help_cmd {
-# TRANSLATORS: please do not translate the command names
-# 'status', 'update', 'revert', etc.
-	print colored $help_color, __ <<'EOF' ;
-status        - show paths with changes
-update        - add working tree state to the staged set of changes
-revert        - revert staged set of changes back to the HEAD version
-patch         - pick hunks and update selectively
-diff          - view diff between HEAD and index
-add untracked - add contents of untracked files to the staged set of changes
-EOF
+	system(qw(git add--helper --show-help));
 }
 
 sub process_args {
-- 
gitgitgadget
