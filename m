Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 140261FA26
	for <e@80x24.org>; Wed, 19 Apr 2017 09:41:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1761833AbdDSJlx (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Apr 2017 05:41:53 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:36524 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1761144AbdDSJlv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Apr 2017 05:41:51 -0400
Received: by mail-pg0-f66.google.com with SMTP id 34so3277620pgx.3
        for <git@vger.kernel.org>; Wed, 19 Apr 2017 02:41:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=dnqfZFFN4aHaYZHUhfrKTHuj771YxqecGorey+Q5SQg=;
        b=uqMwrO1MtooWc+H2Jem8qhWXMSkW0T01N3SRVuR9d1ud74ZCrFhI2OkkpbT/k4s7So
         1PohmuJof/NnqxlH/lacuJibbscrfKUioa6VJ83WKltAjB5Fq0xTk828k+IFaNBqUHXu
         MZyXgt0QxzVCbVZVUwOHLhJe8PlJSyZNZ1LExeWNATTjJatJ3LhnxU+t9zlMjBM2Lk0H
         rN2ZKyrG1AEwscnngmcRi3z3KWFc0zddUil6dYrdoizV12MFWnhDA7eKugJ0wAW3f8wI
         lb7wjFhZ9KDJwESvJOM4ZjdLq/qqC7cR7XiMrnS2uOKQInvQN2BOYXKWDr0RQF4i4V8O
         +1CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=dnqfZFFN4aHaYZHUhfrKTHuj771YxqecGorey+Q5SQg=;
        b=XeLG35oH6lU8JE0DOKpjnkBKBkvYIY3b41FM3f2KXm+jQIII+IRwN0rtpoHMGsXP+R
         AnLSZWloqqfPOJJtHDa9jEYmPTi3X3nWatEEgVGx04XBOzoiqQ3arpcKr5zeIPYMzu8G
         ZiJSII01h1S5AYv87t8q9UkQy2rz9XydzdVvblx1bKnP6fg4oUnw4Zu+GVS+YrIySsjX
         RHUmJUApvmxLYoxnMPkOb4D4rbRm8DJ9monB+f4h67OT5+PDgmfkxp9HE0UrYL2WenzA
         CqVQCN6BlcqODRyv4rzIVWIUCEeOXqEY+eCq6fsWYD/kPxdU5Xu6QtjzA2bXzW11+u0g
         2U1A==
X-Gm-Message-State: AN3rC/439TwXUE40b1H8rQcWJ+QmJFZfYgJzruRc0PNhyjnKoyR9t+dc
        cU1SWTYVa+8k+/BP
X-Received: by 10.98.29.86 with SMTP id d83mr2243192pfd.68.1492594910877;
        Wed, 19 Apr 2017 02:41:50 -0700 (PDT)
Received: from ash ([115.73.171.114])
        by smtp.gmail.com with ESMTPSA id y29sm3435761pfj.90.2017.04.19.02.41.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Apr 2017 02:41:50 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Wed, 19 Apr 2017 16:41:45 +0700
Date:   Wed, 19 Apr 2017 16:41:45 +0700
From:   Duy Nguyen <pclouds@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Apr 2017, #03; Tue, 18)
Message-ID: <20170419094145.GA9051@ash>
References: <xmqqwpah9ci5.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqwpah9ci5.fsf@gitster.mtv.corp.google.com>
X-Clacks-Overhead: GNU Terry Pratchett
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 18, 2017 at 10:45:22PM -0700, Junio C Hamano wrote:
> * nd/conditional-config-in-early-config (2017-04-17) 3 commits
>  - config: correct file reading order in read_early_config()
>  - config: handle conditional include when $GIT_DIR is not set up
>  - config: prepare to pass more info in git_config_with_options()
> 
>  The recently introduced conditional inclusion of configuration did
>  not work well when early-config mechanism was involved.
> 
>  Will merge to 'next'.

You may want to squash this in before merging to 'next'. I think this
is the last comment from Jeff.

-- 8< --
Subject: [PATCH] fixup! config: correct file reading order in read_early_config()

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 t/helper/test-config.c  | 4 ----
 t/t1309-early-config.sh | 3 ++-
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/t/helper/test-config.c b/t/helper/test-config.c
index 696d0a52fd..8e3ed6a76c 100644
--- a/t/helper/test-config.c
+++ b/t/helper/test-config.c
@@ -84,10 +84,6 @@ int cmd_main(int argc, const char **argv)
 	struct config_set cs;
 
 	if (argc == 3 && !strcmp(argv[1], "read_early_config")) {
-		const char *cmdline_config = getenv("CMDL_CFG");
-
-		if (cmdline_config)
-			git_config_push_parameter(cmdline_config);
 		read_early_config(early_config_cb, (void *)argv[2]);
 		return 0;
 	}
diff --git a/t/t1309-early-config.sh b/t/t1309-early-config.sh
index c15f18dd96..1af8c454cf 100755
--- a/t/t1309-early-config.sh
+++ b/t/t1309-early-config.sh
@@ -47,13 +47,14 @@ test_expect_success 'ceiling #2' '
 	test xdg = "$(cat output)"
 '
 
+cmdline_config="'test.source=cmdline'"
 test_expect_success 'read config file in right order' '
 	echo "[test]source = home" >>.gitconfig &&
 	git init foo &&
 	(
 		cd foo &&
 		echo "[test]source = repo" >>.git/config &&
-		CMDL_CFG=test.source=cmdline test-config \
+		GIT_CONFIG_PARAMETERS=$cmdline_config test-config \
 			read_early_config test.source >actual &&
 		cat >expected <<-\EOF &&
 		home
-- 
2.11.0.157.gd943d85
-- 8< --
