Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5BAF21F453
	for <e@80x24.org>; Mon, 22 Oct 2018 22:15:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727450AbeJWGfa (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Oct 2018 02:35:30 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:39820 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727135AbeJWGfa (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Oct 2018 02:35:30 -0400
Received: by mail-pl1-f196.google.com with SMTP id e67-v6so10721286plb.6
        for <git@vger.kernel.org>; Mon, 22 Oct 2018 15:15:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=F8XhM/qwjm9N2ClYy8uab8ktn7FUxbwriLXVdZDdCwQ=;
        b=MSYRWFnzMyGS9Hf1yd4wblE+vt0nAItYcdGb2rDPzhS1ADpuwVPt8rxSOlOOO3ogHw
         SdJ+ntn3uNEnRRBguVQRFGVDsbp+2UgLFvgytMGPqhtUtV9Ycm0IGDTcM/NuYLU57BxU
         QYH2YoPd3Mjgm/iHopbXo6aHmjaWej/DUnRxFYiGf7Tlbd/SBLWc/GURb8VpsFHWhaeL
         5KdzHXKo5Js0xhe5BR9Iu+ibS0qUFR45f35pf6LyHmNu7OrFg0O4AXr6P/03CjDJ2taf
         JkNlD87ckwW/vOWR+JFWEZ3XHtWYh3o3z+9QmQvCPuGpSi77N/L9IgKKBjsaefWCm4Tk
         tN0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=F8XhM/qwjm9N2ClYy8uab8ktn7FUxbwriLXVdZDdCwQ=;
        b=dXyZYJGJqVoXMFjliJMlF8gporh9cKlP3w8OUfvA+RuKjDdD3hKIsAaGyShJIrpIP6
         hJYQGyvOrPEeqEO+0PFUZXie8lLxnLK/iiDlB4KZ28SCj8CVMh/BXIEWEd0bNkBfRREH
         Pc/rqurzeVE0yvmUDsPEVCf2B72Hz7B9K9ajd91yTQkDO7vDnKwaEKvNIuRNPfLFVVej
         1jTcpWe4lGmOxgmt4xDBgVG/QS7FhqbNyfp1qtzgb+I3/Gh8J6yD5/xP9P7TeQUwPGAk
         Nhp9CQ9lO5roP8uSfm97bLzg1VCYdefT44e4+5db9L84Zoyr8y4aZdLkiMU9oRQOHMhC
         MJjA==
X-Gm-Message-State: ABuFfoj9zE2klR+j/S/LzaNl0nk8SHBjVGMGQDSQrdD319mmfFWPC+BE
        BhrcjSiiB2QkcdkgwpzK+AkdOelm
X-Google-Smtp-Source: ACcGV62Tcj9NyDx5vKVkzyh5xbBQNOyIObthCFbMR2KlUzWnQpEavkmBlCbK7VsO8Jp3YROJhJWe4g==
X-Received: by 2002:a17:902:6b0a:: with SMTP id o10-v6mr13863235plk.208.1540246506075;
        Mon, 22 Oct 2018 15:15:06 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.137.127])
        by smtp.gmail.com with ESMTPSA id y23-v6sm38858531pgk.91.2018.10.22.15.15.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Oct 2018 15:15:05 -0700 (PDT)
Date:   Mon, 22 Oct 2018 15:15:05 -0700 (PDT)
X-Google-Original-Date: Mon, 22 Oct 2018 22:14:58 GMT
Message-Id: <07140a71dd9ed3f709970f0ce5eb6aa014417b25.1540246499.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.52.v2.git.gitgitgadget@gmail.com>
References: <pull.52.git.gitgitgadget@gmail.com>
        <pull.52.v2.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 3/3] rebase (autostash): use an explicit OID to apply the
 stash
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     SZEDER Gabor <szeder.dev@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

When `git stash apply <argument>` sees an argument that consists only of
digits, it tries to be smart and interpret it as `stash@{<number>}`.

Unfortunately, an all-digit hash (which is unlikely but still possible)
is therefore misinterpreted as `stash@{<n>}` reflog.

To prevent that from happening, let's append `^0` after the stash hash,
to make sure that it is interpreted as an OID rather than as a number.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/rebase.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 418624837..30d58118c 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -253,6 +253,8 @@ static int apply_autostash(struct rebase_options *opts)
 
 	if (read_one(path, &autostash))
 		return error(_("Could not read '%s'"), path);
+	/* Ensure that the hash is not mistake for a number */
+	strbuf_addstr(&autostash, "^0");
 	argv_array_pushl(&stash_apply.args,
 			 "stash", "apply", autostash.buf, NULL);
 	stash_apply.git_cmd = 1;
-- 
gitgitgadget
