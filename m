Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 52B8C1F87F
	for <e@80x24.org>; Wed, 14 Nov 2018 16:25:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728249AbeKOC30 (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Nov 2018 21:29:26 -0500
Received: from mail-pg1-f172.google.com ([209.85.215.172]:41966 "EHLO
        mail-pg1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725828AbeKOC30 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Nov 2018 21:29:26 -0500
Received: by mail-pg1-f172.google.com with SMTP id 70so7586024pgh.8
        for <git@vger.kernel.org>; Wed, 14 Nov 2018 08:25:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=nggO7JK97pg9E73Kv7UEj2nVwpZbHl0tr4dMhVR5kic=;
        b=dCaikSZ3U5o0wO/rWUlbf8zdpxYD5dVcewIRgS2mC1Px1VJk+3DNg+YFcU7uO9I/yS
         W9AigSGGX469SZcoTSZ3H0/YZVZnfUnmeLQCeR4Trgg/pUn/RHQWuDnYVaQhWhKeA4rq
         Ufxm5q1vU+buoupTje62BGIdnopc9k69LyiLAuINfY14FDzVrk5MRDp4q5VWLiPlxxHM
         K6HZJt12V51Q7ni/SvyFgC2AGwYxMwjGuAFBFEwrS2Ni9QoRX4atDS1rCEa7pcJPmnc/
         m/J1wxW1/ejx7BUCZuRmrszx282KSRHTwV4UsfiTOh4bAvJnhKKOWsxeUk8S4pmcx59Q
         +Oqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=nggO7JK97pg9E73Kv7UEj2nVwpZbHl0tr4dMhVR5kic=;
        b=YxDhMBQzhtGHXc2gppBqlSzq/Uzo96g/x9qxT3lTMPbpwg3DZBLZP0jwyQfnuA+ITL
         8mNY3UPZxEKLU3RougHWhT61GzqXrWf5R6wM7NPwolTucG0u+jUOFHP2w1TpI0boDNrp
         ELSGF2RN/kRLZgEXbfnKqcsZAxkpV1/OIER6Sn8CO/Ewl8ClIcq7dArHFT/Lp/EpK+AL
         SN2phGK3sPXAQu+GAe8bxEiWqr8qp/BIVkNJL3IttvOlW7Zet6EmZ1v5gDSXSrgu2Il6
         RRQL7Qe+IRwqIefFAKfvTpuXXDVF5j+PxgZzzJkz03ViLXIW6oc62ZWk6QnqvXyw5JLL
         YwPw==
X-Gm-Message-State: AGRZ1gI7ijcA6mS1srrxwbAoBP6LAi7/XSm8KtguD2QZ4R5h2xvsHNVE
        p0hDyRkhW4pG2AgxPGY28LvnSj9K
X-Google-Smtp-Source: AJdET5dEbutS8U3MnsjXRPOdiY5aZUph/VystJNQj35QWT9DP3RcF0vRsereZ2vTPfqhBhcBB1rPCg==
X-Received: by 2002:a65:5bc4:: with SMTP id o4mr2386249pgr.426.1542212732208;
        Wed, 14 Nov 2018 08:25:32 -0800 (PST)
Received: from [127.0.0.1] ([40.112.139.188])
        by smtp.gmail.com with ESMTPSA id 80-v6sm28413538pfv.154.2018.11.14.08.25.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Nov 2018 08:25:31 -0800 (PST)
Date:   Wed, 14 Nov 2018 08:25:31 -0800 (PST)
X-Google-Original-Date: Wed, 14 Nov 2018 16:25:25 GMT
Message-Id: <4c2ba5276636097a1c3bb2207c7537831e9079bc.1542212726.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.76.v2.git.gitgitgadget@gmail.com>
References: <pull.76.git.gitgitgadget@gmail.com>
        <pull.76.v2.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 2/2] rebase: validate -C<n> and --whitespace=<mode>
 parameters early
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

It is a good idea to error out early upon seeing, say, `-Cbad`, rather
than starting the rebase only to have the `--am` backend complain later.

Let's do this.

The only options accepting parameters which we pass through to `git am`
(which may, or may not, forward them to `git apply`) are `-C` and
`--whitespace`. The other options we pass through do not accept
parameters, so we do not have to validate them here.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/rebase.c          | 12 +++++++++++-
 t/t3406-rebase-message.sh |  7 +++++++
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 96ffa80b71..571cf899d5 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -1064,12 +1064,22 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	}
 
 	for (i = 0; i < options.git_am_opts.argc; i++) {
-		const char *option = options.git_am_opts.argv[i];
+		const char *option = options.git_am_opts.argv[i], *p;
 		if (!strcmp(option, "--committer-date-is-author-date") ||
 		    !strcmp(option, "--ignore-date") ||
 		    !strcmp(option, "--whitespace=fix") ||
 		    !strcmp(option, "--whitespace=strip"))
 			options.flags |= REBASE_FORCE;
+		else if (skip_prefix(option, "-C", &p)) {
+			while (*p)
+				if (!isdigit(*(p++)))
+					die(_("switch `C' expects a "
+					      "numerical value"));
+		} else if (skip_prefix(option, "--whitespace=", &p)) {
+			if (*p && strcmp(p, "warn") && strcmp(p, "nowarn") &&
+			    strcmp(p, "error") && strcmp(p, "error-all"))
+				die("Invalid whitespace option: '%s'", p);
+		}
 	}
 
 	if (!(options.flags & REBASE_NO_QUIET))
diff --git a/t/t3406-rebase-message.sh b/t/t3406-rebase-message.sh
index 0392e36d23..2c79eed4fe 100755
--- a/t/t3406-rebase-message.sh
+++ b/t/t3406-rebase-message.sh
@@ -84,4 +84,11 @@ test_expect_success 'rebase --onto outputs the invalid ref' '
 	test_i18ngrep "invalid-ref" err
 '
 
+test_expect_success 'error out early upon -C<n> or --whitespace=<bad>' '
+	test_must_fail git rebase -Cnot-a-number HEAD 2>err &&
+	test_i18ngrep "numerical value" err &&
+	test_must_fail git rebase --whitespace=bad HEAD 2>err &&
+	test_i18ngrep "Invalid whitespace option" err
+'
+
 test_done
-- 
gitgitgadget
