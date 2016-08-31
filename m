Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5D29D1F859
	for <e@80x24.org>; Wed, 31 Aug 2016 15:32:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964817AbcHaPci (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Aug 2016 11:32:38 -0400
Received: from mail-wm0-f52.google.com ([74.125.82.52]:37265 "EHLO
        mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933887AbcHaPch (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2016 11:32:37 -0400
Received: by mail-wm0-f52.google.com with SMTP id i5so96818787wmg.0
        for <git@vger.kernel.org>; Wed, 31 Aug 2016 08:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kaarsemaker-net.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=x8R/5hL2I2tCJDtE44EjjdyIcXxaq7PRSKDss9J7Twg=;
        b=BAIBcFZzFGIkhpi5HC5wmJ6pryYCf5bRjtRGSsQg7sspIbKYQzvg/vJ+wuWb7Nfwgi
         QQaGKVKbGmEbcEHdOL+PSXmfIe510ERiapkRjejk0739NSLXom+pdZiiRGK3/dBRjxy9
         FhjI5pB19ZO9q6ilOQQse7WdjuEApWMBFAG9NSYOsllLtI/GvpIDgvH2fa5+lBv3zV4p
         X/pFYV9Kg33OCeQUFXiSU0RaQTREaQ0V4VYIEdGPl9qEq1ojWgylZRH9xTK9VeNjQ1Ve
         /ktabtoVmcUOLzoj7avNyTw/FEw4bGRL7f28297v991rkrAdUxYOa7Eyb29RpqTbFW+I
         7N9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=x8R/5hL2I2tCJDtE44EjjdyIcXxaq7PRSKDss9J7Twg=;
        b=gel8ito4Qvb0DMsbajQjZ8Scdxucd2SGyCj4Zu+fGq5pxglcmMz9mM9HfsGEhGVPvI
         YAflIt2rH4ttZAtXtAUlhHtbwT2FtKauPaXkudT0Wkq8hRFIUj1lVkxsCIgzAD/NUUGO
         b6VPN3W3GWM4SFqGnGKAhhWgeheLykuXoYOM+Dln9grCHoe3IQFDv1/35L1ljjhELnCI
         whYomYqyttn+PXS56CIdzoLl3sZ65zXeLum8E+9EYj6Z4YN2eAT+PSuq7HCFJ6KNYA6d
         /CLdDLblAD911uN56Ts+S1IpRcmhMT7na6uJqY0ch+//kEhMbZ+iuO0Xh44j2bfgGEoQ
         jqUA==
X-Gm-Message-State: AE9vXwOJMAJ6yH6dfTVrJnf1VZ42OhjQQK9D2HT5srf7gLFWrbr3yxpE1p1BPuNMYzVXvw==
X-Received: by 10.28.169.203 with SMTP id s194mr10482909wme.95.1472657555355;
        Wed, 31 Aug 2016 08:32:35 -0700 (PDT)
Received: from [10.42.1.91] ([145.132.209.114])
        by smtp.gmail.com with ESMTPSA id w8sm368781wjj.45.2016.08.31.08.32.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Aug 2016 08:32:34 -0700 (PDT)
Message-ID: <1472657553.4265.63.camel@kaarsemaker.net>
Subject: Re: bug: 'core.logallrefupdates' is not set by default in non-bare
 repository
From:   Dennis Kaarsemaker <dennis@kaarsemaker.net>
To:     Jeff King <peff@peff.net>
Cc:     doak <doak@gmx.de>, "git@vger.kernel.org" <git@vger.kernel.org>
Date:   Wed, 31 Aug 2016 17:32:33 +0200
In-Reply-To: <20160831104825.quyqb54bo5k7fdxs@sigill.intra.peff.net>
References: <c46d36ef-3c2e-374f-0f2e-ffe31104e023@gmx.de>
         <1472634746.4265.47.camel@kaarsemaker.net>
         <20160831104825.quyqb54bo5k7fdxs@sigill.intra.peff.net>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.18.5.2-0ubuntu3 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On wo, 2016-08-31 at 06:48 -0400, Jeff King wrote:
> On Wed, Aug 31, 2016 at 11:12:26AM +0200, Dennis Kaarsemaker wrote:
> 
> > 
> > That is indeed a bug. git reads the config of t1 and then thinks a
> > template config has set that value, so it won't override it.
> This is a regression in v2.9.0 due to my ae5f677 (lazily load
> core.sharedrepository, 2016-03-11).
> 
> > 
> > This is caused by git init reading the config via
> > get_shared_repository. The comment above it indicates that this may
> > not
> > be needed, and indeed not doing it makes this bug go away.
> Hrm. I'm not sure if that will work, though, because we may call
> get_shared_repository() from other code-paths (e.g., anything that
> calls
> adjust_shared_perm(), like safe_create_leading_directories).

Agreed, the diff was more to point out what triggered this (so I could
send that and run away to spend the day with jr.) than an attempt at a
patch.

> We may need to do something like turn off the
> need_shared_repository_from_config in init-db, since I think it would
> not want to ever read from the default config sources in most of its
> code-paths (OTOH, it should in theory respect core.sharedRepository
> in ~/.gitconfig, so maybe there is another more elegant way of
> handling this).

I would go even further and say that git init should completely ignore
the config of a repository you happen to be in when creating a new
repository.

> I'm out of time for the day, so it will be a while before I can dig
> further. Please feel free to figure it out while I am sleeping. :)
> 
> -Peff

I hope you slept well :)

This is what I came up with to implement my suggestion above, comments
welcome.

diff --git a/builtin/init-db.c b/builtin/init-db.c
index 3a45f0b..d0fd3dc 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -493,6 +493,12 @@ int cmd_init_db(int argc, const char **argv, const char *prefix)
 		int mkdir_tried = 0;
 	retry:
 		if (chdir(argv[0]) < 0) {
+			/*
+			 * We're creating a new repository. If we're already in another
+			 * repository, ignore its config
+			 */
+			ignore_repo_config = 1;
+			git_config_clear();
 			if (!mkdir_tried) {
 				int saved;
 				/*
@@ -500,7 +506,6 @@ int cmd_init_db(int argc, const char **argv, const char *prefix)
 				 * and we know shared_repository should always be 0;
 				 * but just in case we play safe.
 				 */
-				saved = get_shared_repository();
 				set_shared_repository(0);
 				switch (safe_create_leading_directories_const(argv[0])) {
 				case SCLD_OK:
@@ -513,7 +518,6 @@ int cmd_init_db(int argc, const char **argv, const char *prefix)
 					die_errno(_("cannot mkdir %s"), argv[0]);
 					break;
 				}
-				set_shared_repository(saved);
 				if (mkdir(argv[0], 0777) < 0)
 					die_errno(_("cannot mkdir %s"), argv[0]);
 				mkdir_tried = 1;
@@ -524,6 +528,11 @@ int cmd_init_db(int argc, const char **argv, const char *prefix)
 	} else if (0 < argc) {
 		usage(init_db_usage[0]);
 	}
+
+	need_shared_repository_from_config = 1;
+	ignore_repo_config = 0;
+	git_config_clear();
+
 	if (is_bare_repository_cfg == 1) {
 		char *cwd = xgetcwd();
 		setenv(GIT_DIR_ENVIRONMENT, cwd, argc > 0);
diff --git a/cache.h b/cache.h
index f30a441..1be16fc 100644
--- a/cache.h
+++ b/cache.h
@@ -640,6 +640,8 @@ extern int hold_locked_index(struct lock_file *, int);
 extern void set_alternate_index_output(const char *);
 
 /* Environment bits from configuration mechanism */
+extern int ignore_repo_config;
+extern int need_shared_repository_from_config;
 extern int trust_executable_bit;
 extern int trust_ctime;
 extern int check_stat;
diff --git a/config.c b/config.c
index 0dfed68..2df0189 100644
--- a/config.c
+++ b/config.c
@@ -1304,7 +1304,7 @@ static int do_git_config_sequence(config_fn_t fn, void *data)
 		ret += git_config_from_file(fn, user_config, data);
 
 	current_parsing_scope = CONFIG_SCOPE_REPO;
-	if (repo_config && !access_or_die(repo_config, R_OK, 0))
+	if (repo_config && !ignore_repo_config && !access_or_die(repo_config, R_OK, 0))
 		ret += git_config_from_file(fn, repo_config, data);
 
 	current_parsing_scope = CONFIG_SCOPE_CMDLINE;
diff --git a/environment.c b/environment.c
index ca72464..f6dbba8 100644
--- a/environment.c
+++ b/environment.c
@@ -12,6 +12,8 @@
 #include "fmt-merge-msg.h"
 #include "commit.h"
 
+int ignore_repo_config = 0;
+int need_shared_repository_from_config = 1;
 int trust_executable_bit = 1;
 int trust_ctime = 1;
 int check_stat = 1;
@@ -326,7 +328,6 @@ const char *get_commit_output_encoding(void)
 }
 
 static int the_shared_repository = PERM_UMASK;
-static int need_shared_repository_from_config = 1;
 
 void set_shared_repository(int value)
 {
