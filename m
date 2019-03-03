Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D68BF20248
	for <e@80x24.org>; Sun,  3 Mar 2019 17:11:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726473AbfCCRLz (ORCPT <rfc822;e@80x24.org>);
        Sun, 3 Mar 2019 12:11:55 -0500
Received: from mail-ed1-f41.google.com ([209.85.208.41]:42422 "EHLO
        mail-ed1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726442AbfCCRLz (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Mar 2019 12:11:55 -0500
Received: by mail-ed1-f41.google.com with SMTP id j89so2303704edb.9
        for <git@vger.kernel.org>; Sun, 03 Mar 2019 09:11:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=VhMuAOmT4Y8clpe8vVOcle2S0EZOj49AJg42GB+xp4s=;
        b=eBxgrxeNkLsPbMTW6VSv82uGUaU5raMwRt1quQ/PufAhL4iRRy+K6MGYmgX3ZQ12l/
         4zblmqAxNmzJsbt6lBEiUcUtHFW9hbKegDRU/ASHQ/dz8IWhSvQ5ZiR3dq/wPm9UCBMb
         z6kXoDgwWfvogSnETxA3Tarc4DgX9A9N4l2JW6hITH7IWbQCzyn/544vN0K0yj8bSTTc
         GQcqONgytsiVSJGZmnPE4JEIH/2YV8E2PAy+UTPQ+oTmDVq/qeDKJKH7XzG62FrtmVll
         lsJSB+EJSQfvFhwRghLHBoTQ8QDScpzFGAJl0W4sprS+k9hL+K3/VpiPXQ3P5esCuagP
         v68A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=VhMuAOmT4Y8clpe8vVOcle2S0EZOj49AJg42GB+xp4s=;
        b=SftjZ3NsxAVZd/32W9KEcb/C0wnCAOPP87SGKfnHCEUPRmpEhdRGszfnWVzG3t+Qyv
         4pPguawDl72zUtHH61D9x+U0yyuvbuIgttd10AixNoHB3nN839oY7tS/echy+9rA37js
         xYIKJhi31DhCQGy0vNiCTC8q+n+fcpbFQqwsvgzUaeedZzXVNzqwzf8FhQxba7Lct6cG
         8XHobmJUQKa8Vcpkc1LJjQO3g6AvyV99ZE/Fwc0xbKYaz2ZskI1XUmKSlwkAwyxv7t7N
         jcRTuB4NqYsi3xZgYvafXCE0wtH0y8hiF1h+aq+c6sOctFCQEHDE+ImqlVQcvZz3PmFx
         t1CA==
X-Gm-Message-State: APjAAAVm7iKgjoe7VEoWKpKAEfYRFSJvFPZS0zBUcKClD4zJ8/zb8Pi/
        41PBbg+YVr2ZTTk1DTca/ziJS+L8
X-Google-Smtp-Source: APXvYqwMvaAaQCXk5FPg6TVVz01Pqym6rdcnwePFAx7VG71Sqk2xsWFlP6lnE6tdw+U39StsJlfCMQ==
X-Received: by 2002:a05:6402:171a:: with SMTP id y26mr12533403edu.72.1551633113753;
        Sun, 03 Mar 2019 09:11:53 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b29sm1366151eda.48.2019.03.03.09.11.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 03 Mar 2019 09:11:53 -0800 (PST)
Date:   Sun, 03 Mar 2019 09:11:53 -0800 (PST)
X-Google-Original-Date: Sun, 03 Mar 2019 17:11:49 GMT
Message-Id: <59c3266ed523be6f92e7cb991436be3dac96a81f.1551633112.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.153.v2.git.gitgitgadget@gmail.com>
References: <pull.153.git.gitgitgadget@gmail.com>
        <pull.153.v2.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 1/4] built-in rebase: no need to check out `onto` twice
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Nazri Ramliy <ayiehere@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

In the case that the rebase boils down to a fast-forward, the built-in
rebase reset the working tree twice: once to start the rebase at `onto`,
then realizing that the original (pre-rebase) HEAD was an ancestor and
we basically already fast-forwarded to the post-rebase HEAD,
`reset_head()` was called to update the original ref and to point HEAD
back to it.

That second `reset_head()` call does not need to touch the working tree,
though, as it does not change the actual tip commit (and therefore the
working tree should stay unchanged anyway): only the ref needs to be
updated (because the rebase detached the HEAD, and we want to go back to
the branch on which the rebase was started).

But that second `reset_head()` was called without the flag to leave the
working tree alone (the reason: when that call was introduced, that flag
was not yet even thought of). Let's avoid that unnecessary work by
passing that flag.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/rebase.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 08ec4d52c7..813ec284ca 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -1740,8 +1740,8 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		strbuf_addf(&msg, "rebase finished: %s onto %s",
 			options.head_name ? options.head_name : "detached HEAD",
 			oid_to_hex(&options.onto->object.oid));
-		reset_head(NULL, "Fast-forwarded", options.head_name, 0,
-			   "HEAD", msg.buf);
+		reset_head(NULL, "Fast-forwarded", options.head_name,
+			   RESET_HEAD_REFS_ONLY, "HEAD", msg.buf);
 		strbuf_release(&msg);
 		ret = !!finish_rebase(&options);
 		goto cleanup;
-- 
gitgitgadget

