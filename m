Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F29191F597
	for <e@80x24.org>; Fri,  3 Aug 2018 22:24:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732087AbeHDAWU (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Aug 2018 20:22:20 -0400
Received: from mail-io0-f202.google.com ([209.85.223.202]:39898 "EHLO
        mail-io0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731946AbeHDAWU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Aug 2018 20:22:20 -0400
Received: by mail-io0-f202.google.com with SMTP id x5-v6so5094513ioa.6
        for <git@vger.kernel.org>; Fri, 03 Aug 2018 15:24:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=Vn8r6wT3eBr/cWkxh3bf+vp0ZWlrwCflvnaXPgMpRUE=;
        b=Czk43f84rjbc3L3dU5UbZU00pV1a+NiH8ws2VT5l+ZXa1T+YxZxJMDkKYKwXqm4e8M
         ynUstudJFddokgfp5WDDivLNW9GLdrWsDFEe056uY1/QS2fQw6vcW8RORnuT1DeriF1E
         Di0KSlC1jqPQpNnWrNNJ+HVPKmkpRTwnMMp9GxCv8Wjj4nAORio/E10UQpwOvjnhOv+J
         17jZQBNhDDLI1gi0dYrJaSFz1LiwQ09n/SfIwLqXSqEZReZvOGSaL68ubmYd+XBv9FvV
         liKPEDN5ovB2IMRZl0jUendsJIqQlQAcNZmFJsNio4Ngsl4OASKmOY0We1xZvkGRKgLl
         jpnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=Vn8r6wT3eBr/cWkxh3bf+vp0ZWlrwCflvnaXPgMpRUE=;
        b=l7Yc1Peg4VRx/NxTGiavK1Wmw2hXWZ1vE1ISlY0qzzHpemakiGW+CJ4LFXUzUejxEx
         uHSibu422LNENahoXtlKKCsE9r7usHpq5mVGYgptNAC4HoLl46kZbYGmm24+1H6KuD3H
         lDF+Sg4T7ydp9f+aVI4sQZUyOji38bPsuvJyfXxPRFRhXTzDIr7vYABSYxsMKFI3/GSF
         wmOuTosSxNRDsH+cV54jyeuvQCICaeUcIp5+7tErqcRmVXHlBsTekJjb9Q6+lhEFvtE5
         IsbouISp4ViOEGEmtoFHpOKOPDfYfWVaxwFZf8vRX2WBTQ15mzHf/Enf6jpMT5aekbtr
         OogQ==
X-Gm-Message-State: AOUpUlGrjrrKSlCO30YR3hdiqwNqqpUJHI8X5lnVqIJW5Ksh7n5/Hi9l
        szcxhFgEqgdb2RyDcU1Iz0tE9kEe0G/nw8/slCIMD0raz3pmWhMmpHXZkDjHEXR3AMEc6/oB5Gh
        0oQ4vFBtxFGDeTbwKlvspht39iefbNcXLE8EczoSna6TEUHnY+0looCztH8OL
X-Google-Smtp-Source: AA+uWPwyECDouHvqcX8o7wZlwWtSBkOt+DwvRBPaUs20TOcITExrcNID6lqf4gxVEFEoa2rMzpTimR1RvQzA
MIME-Version: 1.0
X-Received: by 2002:a24:a85:: with SMTP id 127-v6mr409563itw.9.1533335046421;
 Fri, 03 Aug 2018 15:24:06 -0700 (PDT)
Date:   Fri,  3 Aug 2018 15:23:17 -0700
In-Reply-To: <20180803222322.261813-1-sbeller@google.com>
Message-Id: <20180803222322.261813-3-sbeller@google.com>
References: <20180803222322.261813-1-sbeller@google.com>
X-Mailer: git-send-email 2.18.0.132.g195c49a2227
Subject: [PATCH 2/7] git-submodule.sh: rename unused variables
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The 'mode' variable is not used in cmd_update for its original purpose,
rename it to 'dummy' as it only serves the purpose to abort quickly
documenting this knowledge.

The variable 'stage' is also not used any more in cmd_update, so remove it.

This went unnoticed as first each function used the commonly used
submodule listing, which was converted in 74703a1e4df (submodule: rewrite
`module_list` shell function in C, 2015-09-02). When cmd_update was
using its own function starting in 48308681b07 (git submodule update:
have a dedicated helper for cloning, 2016-02-29), its removal was missed.

A later patch in this series also touches the communication between
the submodule helper and git-submodule.sh, but let's have this as
a preparatory patch, as it eases the next patch, which stores the
raw data instead of the line printed for this communication.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/submodule--helper.c | 5 ++---
 git-submodule.sh            | 4 ++--
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index a3c4564c6c8..da700c88963 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1573,9 +1573,8 @@ static int prepare_to_clone_next_submodule(const struct cache_entry *ce,
 	needs_cloning = !file_exists(sb.buf);
 
 	strbuf_reset(&sb);
-	strbuf_addf(&sb, "%06o %s %d %d\t%s\n", ce->ce_mode,
-			oid_to_hex(&ce->oid), ce_stage(ce),
-			needs_cloning, ce->name);
+	strbuf_addf(&sb, "dummy %s %d\t%s\n",
+		    oid_to_hex(&ce->oid), needs_cloning, ce->name);
 	string_list_append(&suc->projectlines, sb.buf);
 
 	if (!needs_cloning)
diff --git a/git-submodule.sh b/git-submodule.sh
index 5a58812645d..8caaf274e25 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -531,9 +531,9 @@ cmd_update()
 		"$@" || echo "#unmatched" $?
 	} | {
 	err=
-	while read -r mode sha1 stage just_cloned sm_path
+	while read -r quickabort sha1 just_cloned sm_path
 	do
-		die_if_unmatched "$mode" "$sha1"
+		die_if_unmatched "$quickabort" "$sha1"
 
 		name=$(git submodule--helper name "$sm_path") || exit
 		if ! test -z "$update"
-- 
2.18.0.132.g195c49a2227

