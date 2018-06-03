Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 68EFF1F403
	for <e@80x24.org>; Sun,  3 Jun 2018 16:35:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751498AbeFCQfX (ORCPT <rfc822;e@80x24.org>);
        Sun, 3 Jun 2018 12:35:23 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:38536 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751433AbeFCQfI (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Jun 2018 12:35:08 -0400
Received: by mail-lf0-f68.google.com with SMTP id i83-v6so9403817lfh.5
        for <git@vger.kernel.org>; Sun, 03 Jun 2018 09:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lr7CE8NQS1nhMR+jnmH5FE7hsyUeaDDO2Q5aceaXJuA=;
        b=YAp75veAy2XUBTWQDp2RopyKxKf48j+RvkO669c5GwnXZeWUPZ1b2TTJ8hG5RhFsQl
         T4GXb8x/bNKRZx13y1GFVvNfd2Lq881Sv8Y1RU7VxgDxzVGcS3us6S5wnUjynnivgaUc
         oOr4c5ahsQgdqXWswyRrh56u/CEd0E83Ag2CTQIaL+BsowZXUhS6lwMShZ7hkcmflhfg
         e6lKGnBCVbQ/kDeHFG6iuEGt20f0ZHBduxlJPGPkz3dtrdFI+fBuelTOEkmfMWA2I+Sw
         /yC3wVRog+r6V7zlsL7Rs38wxrITnbGM2vnwCSXcXyanlUy28GTJdw4v44gKD84/v4ik
         nNmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lr7CE8NQS1nhMR+jnmH5FE7hsyUeaDDO2Q5aceaXJuA=;
        b=Cab0NuugAENfvqTjgxEk1nUhSrTVhsPUx2v6dUqw0mWOEeyc369omvA57seShGsfws
         JkbzFfXx9DP5Uhr27+5nHoaC31HWWGECpAm/144KdKIKkavFV6p3Jv2l5lTuAMy/utGF
         F13XyaosTt2PKfU86scQeXfyzvqSsjLM//N4ScSnQeqr92PogW7LQg0tfMWCKoGdKNrK
         nXo8T3zBUxjDRrK7tRcn5ouMdxjjzmugkRwTXCMk81M0DnpuxU76HMmp6OXLt+4sWba1
         /tM0S/wYvGlRkdntZeJpf/MEOVpU8ULMuhbpYNiPZ+MnTPasIn4JawN9xm2Ru7nbubHt
         rNkw==
X-Gm-Message-State: ALKqPwe6aw7SK+FkBGbn0B63ST8qDVA3/bnT+/B8AB+uJvQppEIVIISy
        tpbO9hzbjHcr/atWWjbeobU=
X-Google-Smtp-Source: ADUXVKJsCC+7FYdNRwXKq52xEhMdy/sif0MI27dE7ylOHiIDbPqoF10+oUe1PH/6FiHT9P4a/bqOew==
X-Received: by 2002:a19:1813:: with SMTP id o19-v6mr10529242lfi.14.1528043706408;
        Sun, 03 Jun 2018 09:35:06 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id v79-v6sm4726895lfd.32.2018.06.03.09.35.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 03 Jun 2018 09:35:05 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 23/23] transport-helper.c: mark more strings for translation
Date:   Sun,  3 Jun 2018 18:34:20 +0200
Message-Id: <20180603163420.13702-24-pclouds@gmail.com>
X-Mailer: git-send-email 2.18.0.rc0.333.g22e6ee6cdf
In-Reply-To: <20180603163420.13702-1-pclouds@gmail.com>
References: <20180602043241.9941-1-pclouds@gmail.com>
 <20180603163420.13702-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 t/t5801-remote-helpers.sh |  8 ++--
 transport-helper.c        | 87 ++++++++++++++++++++-------------------
 2 files changed, 48 insertions(+), 47 deletions(-)

diff --git a/t/t5801-remote-helpers.sh b/t/t5801-remote-helpers.sh
index 88c7f158ef..e3bc53b0c7 100755
--- a/t/t5801-remote-helpers.sh
+++ b/t/t5801-remote-helpers.sh
@@ -126,7 +126,7 @@ test_expect_success 'forced push' '
 test_expect_success 'cloning without refspec' '
 	GIT_REMOTE_TESTGIT_REFSPEC="" \
 	git clone "testgit::${PWD}/server" local2 2>error &&
-	grep "this remote helper should implement refspec capability" error &&
+	test_i18ngrep "this remote helper should implement refspec capability" error &&
 	compare_refs local2 HEAD server HEAD
 '
 
@@ -134,7 +134,7 @@ test_expect_success 'pulling without refspecs' '
 	(cd local2 &&
 	git reset --hard &&
 	GIT_REMOTE_TESTGIT_REFSPEC="" git pull 2>../error) &&
-	grep "this remote helper should implement refspec capability" error &&
+	test_i18ngrep "this remote helper should implement refspec capability" error &&
 	compare_refs local2 HEAD server HEAD
 '
 
@@ -146,7 +146,7 @@ test_expect_success 'pushing without refspecs' '
 	GIT_REMOTE_TESTGIT_REFSPEC="" &&
 	export GIT_REMOTE_TESTGIT_REFSPEC &&
 	test_must_fail git push 2>../error) &&
-	grep "remote-helper doesn.t support push; refspec needed" error
+	test_i18ngrep "remote-helper doesn.t support push; refspec needed" error
 '
 
 test_expect_success 'pulling without marks' '
@@ -246,7 +246,7 @@ test_expect_success 'proper failure checks for fetching' '
 	(cd local &&
 	test_must_fail env GIT_REMOTE_TESTGIT_FAILURE=1 git fetch 2>error &&
 	cat error &&
-	grep -q "error while running fast-import" error
+	test_i18ngrep -q "error while running fast-import" error
 	)
 '
 
diff --git a/transport-helper.c b/transport-helper.c
index 9f487cc905..84a10661cc 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -48,7 +48,7 @@ static void sendline(struct helper_data *helper, struct strbuf *buffer)
 	if (debug)
 		fprintf(stderr, "Debug: Remote helper: -> %s", buffer->buf);
 	if (write_in_full(helper->helper->in, buffer->buf, buffer->len) < 0)
-		die_errno("full write to remote helper failed");
+		die_errno(_("full write to remote helper failed"));
 }
 
 static int recvline_fh(FILE *helper, struct strbuf *buffer)
@@ -77,7 +77,7 @@ static void write_constant(int fd, const char *str)
 	if (debug)
 		fprintf(stderr, "Debug: Remote helper: -> %s", str);
 	if (write_in_full(fd, str, strlen(str)) < 0)
-		die_errno("full write to remote helper failed");
+		die_errno(_("full write to remote helper failed"));
 }
 
 static const char *remove_ext_force(const char *url)
@@ -129,7 +129,7 @@ static struct child_process *get_helper(struct transport *transport)
 
 	code = start_command(helper);
 	if (code < 0 && errno == ENOENT)
-		die("unable to find remote helper for '%s'", data->name);
+		die(_("unable to find remote helper for '%s'"), data->name);
 	else if (code != 0)
 		exit(code);
 
@@ -145,7 +145,7 @@ static struct child_process *get_helper(struct transport *transport)
 	 */
 	duped = dup(helper->out);
 	if (duped < 0)
-		die_errno("can't dup helper output fd");
+		die_errno(_("can't dup helper output fd"));
 	data->out = xfdopen(duped, "r");
 
 	write_constant(helper->in, "capabilities\n");
@@ -196,13 +196,13 @@ static struct child_process *get_helper(struct transport *transport)
 		} else if (starts_with(capname, "no-private-update")) {
 			data->no_private_update = 1;
 		} else if (mandatory) {
-			die("unknown mandatory capability %s; this remote "
-			    "helper probably needs newer version of Git",
+			die(_("unknown mandatory capability %s; this remote "
+			      "helper probably needs newer version of Git"),
 			    capname);
 		}
 	}
 	if (!data->rs.nr && (data->import || data->bidi_import || data->export)) {
-		warning("this remote helper should implement refspec capability");
+		warning(_("this remote helper should implement refspec capability"));
 	}
 	strbuf_release(&buf);
 	if (debug)
@@ -269,7 +269,7 @@ static int strbuf_set_helper_option(struct helper_data *data,
 	else if (!strcmp(buf->buf, "unsupported"))
 		ret = 1;
 	else {
-		warning("%s unexpectedly said: '%s'", data->name, buf->buf);
+		warning(_("%s unexpectedly said: '%s'"), data->name, buf->buf);
 		ret = 1;
 	}
 	return ret;
@@ -398,7 +398,7 @@ static int fetch_with_fetch(struct transport *transport,
 		if (starts_with(buf.buf, "lock ")) {
 			const char *name = buf.buf + 5;
 			if (transport->pack_lockfile)
-				warning("%s also locked %s", data->name, name);
+				warning(_("%s also locked %s"), data->name, name);
 			else
 				transport->pack_lockfile = xstrdup(name);
 		}
@@ -409,7 +409,7 @@ static int fetch_with_fetch(struct transport *transport,
 		else if (!buf.len)
 			break;
 		else
-			warning("%s unexpectedly said: '%s'", data->name, buf.buf);
+			warning(_("%s unexpectedly said: '%s'"), data->name, buf.buf);
 	}
 	strbuf_release(&buf);
 	return 0;
@@ -476,7 +476,7 @@ static int fetch_with_import(struct transport *transport,
 	get_helper(transport);
 
 	if (get_importer(transport, &fastimport))
-		die("couldn't run fast-import");
+		die(_("couldn't run fast-import"));
 
 	for (i = 0; i < nr_heads; i++) {
 		posn = to_fetch[i];
@@ -499,7 +499,7 @@ static int fetch_with_import(struct transport *transport,
 	 */
 
 	if (finish_command(&fastimport))
-		die("error while running fast-import");
+		die(_("error while running fast-import"));
 
 	/*
 	 * The fast-import stream of a remote helper that advertises
@@ -528,7 +528,7 @@ static int fetch_with_import(struct transport *transport,
 			private = xstrdup(name);
 		if (private) {
 			if (read_ref(private, &posn->old_oid) < 0)
-				die("could not read ref %s", private);
+				die(_("could not read ref %s"), private);
 			free(private);
 		}
 	}
@@ -554,7 +554,7 @@ static int run_connect(struct transport *transport, struct strbuf *cmdbuf)
 	 */
 	duped = dup(helper->out);
 	if (duped < 0)
-		die_errno("can't dup helper output fd");
+		die_errno(_("can't dup helper output fd"));
 	input = xfdopen(duped, "r");
 	setvbuf(input, NULL, _IONBF, 0);
 
@@ -573,8 +573,8 @@ static int run_connect(struct transport *transport, struct strbuf *cmdbuf)
 			fprintf(stderr, "Debug: Falling back to dumb "
 				"transport.\n");
 	} else {
-		die("unknown response to connect: %s",
-			cmdbuf->buf);
+		die(_(_("unknown response to connect: %s")),
+		    cmdbuf->buf);
 	}
 
 	fclose(input);
@@ -595,9 +595,9 @@ static int process_connect_service(struct transport *transport,
 	if (strcmp(name, exec)) {
 		int r = set_helper_option(transport, "servpath", exec);
 		if (r > 0)
-			warning("setting remote service path not supported by protocol");
+			warning(_("setting remote service path not supported by protocol"));
 		else if (r < 0)
-			warning("invalid remote service path");
+			warning(_("invalid remote service path"));
 	}
 
 	if (data->connect) {
@@ -640,10 +640,10 @@ static int connect_helper(struct transport *transport, const char *name,
 	/* Get_helper so connect is inited. */
 	get_helper(transport);
 	if (!data->connect)
-		die("operation not supported by protocol");
+		die(_("operation not supported by protocol"));
 
 	if (!process_connect_service(transport, name, exec))
-		die("can't connect to subservice %s", name);
+		die(_("can't connect to subservice %s"), name);
 
 	fd[0] = data->helper->out;
 	fd[1] = data->helper->in;
@@ -707,7 +707,7 @@ static int push_update_ref_status(struct strbuf *buf,
 		status = REF_STATUS_REMOTE_REJECT;
 		refname = buf->buf + 6;
 	} else
-		die("expected ok/error, helper said '%s'", buf->buf);
+		die(_("expected ok/error, helper said '%s'"), buf->buf);
 
 	msg = strchr(refname, ' ');
 	if (msg) {
@@ -760,7 +760,7 @@ static int push_update_ref_status(struct strbuf *buf,
 	if (!*ref)
 		*ref = find_ref_by_name(remote_refs, refname);
 	if (!*ref) {
-		warning("helper reported unexpected status of %s", refname);
+		warning(_("helper reported unexpected status of %s"), refname);
 		return 1;
 	}
 
@@ -821,20 +821,20 @@ static void set_common_push_options(struct transport *transport,
 {
 	if (flags & TRANSPORT_PUSH_DRY_RUN) {
 		if (set_helper_option(transport, "dry-run", "true") != 0)
-			die("helper %s does not support dry-run", name);
+			die(_("helper %s does not support dry-run"), name);
 	} else if (flags & TRANSPORT_PUSH_CERT_ALWAYS) {
 		if (set_helper_option(transport, TRANS_OPT_PUSH_CERT, "true") != 0)
-			die("helper %s does not support --signed", name);
+			die(_("helper %s does not support --signed"), name);
 	} else if (flags & TRANSPORT_PUSH_CERT_IF_ASKED) {
 		if (set_helper_option(transport, TRANS_OPT_PUSH_CERT, "if-asked") != 0)
-			die("helper %s does not support --signed=if-asked", name);
+			die(_("helper %s does not support --signed=if-asked"), name);
 	}
 
 	if (flags & TRANSPORT_PUSH_OPTIONS) {
 		struct string_list_item *item;
 		for_each_string_list_item(item, transport->push_options)
 			if (set_helper_option(transport, "push-option", item->string) != 0)
-				die("helper %s does not support 'push-option'", name);
+				die(_("helper %s does not support 'push-option'"), name);
 	}
 }
 
@@ -926,12 +926,12 @@ static int push_refs_with_export(struct transport *transport,
 	struct strbuf buf = STRBUF_INIT;
 
 	if (!data->rs.nr)
-		die("remote-helper doesn't support push; refspec needed");
+		die(_("remote-helper doesn't support push; refspec needed"));
 
 	set_common_push_options(transport, data->name, flags);
 	if (flags & TRANSPORT_PUSH_FORCE) {
 		if (set_helper_option(transport, "force", "true") != 0)
-			warning("helper %s does not support 'force'", data->name);
+			warning(_("helper %s does not support 'force'"), data->name);
 	}
 
 	helper = get_helper(transport);
@@ -978,12 +978,12 @@ static int push_refs_with_export(struct transport *transport,
 	}
 
 	if (get_exporter(transport, &exporter, &revlist_args))
-		die("couldn't run fast-export");
+		die(_("couldn't run fast-export"));
 
 	string_list_clear(&revlist_args, 1);
 
 	if (finish_command(&exporter))
-		die("error while running fast-export");
+		die(_("error while running fast-export"));
 	if (push_update_refs_status(data, remote_refs, flags))
 		return 1;
 
@@ -1007,8 +1007,9 @@ static int push_refs(struct transport *transport,
 	}
 
 	if (!remote_refs) {
-		fprintf(stderr, "No refs in common and none specified; doing nothing.\n"
-			"Perhaps you should specify a branch such as 'master'.\n");
+		fprintf(stderr,
+			_("No refs in common and none specified; doing nothing.\n"
+			  "Perhaps you should specify a branch such as 'master'.\n"));
 		return 0;
 	}
 
@@ -1070,7 +1071,7 @@ static struct ref *get_refs_list(struct transport *transport, int for_push,
 
 		eov = strchr(buf.buf, ' ');
 		if (!eov)
-			die("malformed response in ref list: %s", buf.buf);
+			die(_("malformed response in ref list: %s"), buf.buf);
 		eon = strchr(eov + 1, ' ');
 		*eov = '\0';
 		if (eon)
@@ -1223,7 +1224,7 @@ static int udt_do_read(struct unidirectional_transfer *t)
 	bytes = read(t->src, t->buf + t->bufuse, BUFFERSIZE - t->bufuse);
 	if (bytes < 0 && errno != EWOULDBLOCK && errno != EAGAIN &&
 		errno != EINTR) {
-		error_errno("read(%s) failed", t->src_name);
+		error_errno(_("read(%s) failed"), t->src_name);
 		return -1;
 	} else if (bytes == 0) {
 		transfer_debug("%s EOF (with %i bytes in buffer)",
@@ -1250,7 +1251,7 @@ static int udt_do_write(struct unidirectional_transfer *t)
 	transfer_debug("%s is writable", t->dest_name);
 	bytes = xwrite(t->dest, t->buf, t->bufuse);
 	if (bytes < 0 && errno != EWOULDBLOCK) {
-		error_errno("write(%s) failed", t->dest_name);
+		error_errno(_("write(%s) failed"), t->dest_name);
 		return -1;
 	} else if (bytes > 0) {
 		t->bufuse -= bytes;
@@ -1299,11 +1300,11 @@ static int tloop_join(pthread_t thread, const char *name)
 	void *tret;
 	err = pthread_join(thread, &tret);
 	if (!tret) {
-		error("%s thread failed", name);
+		error(_("%s thread failed"), name);
 		return 1;
 	}
 	if (err) {
-		error("%s thread failed to join: %s", name, strerror(err));
+		error(_("%s thread failed to join: %s"), name, strerror(err));
 		return 1;
 	}
 	return 0;
@@ -1322,11 +1323,11 @@ static int tloop_spawnwait_tasks(struct bidirectional_transfer_state *s)
 	err = pthread_create(&gtp_thread, NULL, udt_copy_task_routine,
 		&s->gtp);
 	if (err)
-		die("can't start thread for copying data: %s", strerror(err));
+		die(_("can't start thread for copying data: %s"), strerror(err));
 	err = pthread_create(&ptg_thread, NULL, udt_copy_task_routine,
 		&s->ptg);
 	if (err)
-		die("can't start thread for copying data: %s", strerror(err));
+		die(_("can't start thread for copying data: %s"), strerror(err));
 
 	ret |= tloop_join(gtp_thread, "Git to program copy");
 	ret |= tloop_join(ptg_thread, "Program to git copy");
@@ -1363,11 +1364,11 @@ static int tloop_join(pid_t pid, const char *name)
 {
 	int tret;
 	if (waitpid(pid, &tret, 0) < 0) {
-		error_errno("%s process failed to wait", name);
+		error_errno(_("%s process failed to wait"), name);
 		return 1;
 	}
 	if (!WIFEXITED(tret) || WEXITSTATUS(tret)) {
-		error("%s process failed", name);
+		error(_("%s process failed"), name);
 		return 1;
 	}
 	return 0;
@@ -1385,7 +1386,7 @@ static int tloop_spawnwait_tasks(struct bidirectional_transfer_state *s)
 	/* Fork thread #1: git to program. */
 	pid1 = fork();
 	if (pid1 < 0)
-		die_errno("can't start thread for copying data");
+		die_errno(_("can't start thread for copying data"));
 	else if (pid1 == 0) {
 		udt_kill_transfer(&s->ptg);
 		exit(udt_copy_task_routine(&s->gtp) ? 0 : 1);
@@ -1394,7 +1395,7 @@ static int tloop_spawnwait_tasks(struct bidirectional_transfer_state *s)
 	/* Fork thread #2: program to git. */
 	pid2 = fork();
 	if (pid2 < 0)
-		die_errno("can't start thread for copying data");
+		die_errno(_("can't start thread for copying data"));
 	else if (pid2 == 0) {
 		udt_kill_transfer(&s->gtp);
 		exit(udt_copy_task_routine(&s->ptg) ? 0 : 1);
-- 
2.18.0.rc0.333.g22e6ee6cdf

