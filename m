Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.15
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794100959;
	b=bh56Nu3GuoGVFJT67o+BRPirFW8Q7e3pWgKL96NbStDX95Id0qcQJZRF+7aNVI93EsoZ
	 qINkt6T9zc9ncvDpxEgmR23356mVMgkpNwvXaHH8Wv1PHzORUeFqKCXla8k6Sl2S5PwWJ
	 yszzce3XygvpeIalAi6NJzFLXS1XgtVDiprmZReUH6MrfjksSBUg4cKj4SoctsLRMGmMu
	 Vhui2/1sCh0kCMz/ZdOqcgfvhOMaTDv6BRdy6aCJwuFswbZoxU+nnD4TxinVVXRTHtZpX
	 VjEDZtzoISiuzdpziwzuY2zR6eEBgMcbCamp+1Cemi2ufNDFjSQnW8s4AbrpP8TGo5A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794100959;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-ZohoMailClient;
	bh=QEA6qpoTdFIcV9uVMdtoBM7rPgIHyJWZuTg24UswJog=;
	b=oPzYYT4U/R2c4tba2QQxNYQGQ3JnJba7tMOokkdAXhftPgaMEpc0ac+6MQ4t5syfuOva
	 0LO/wsT1Zav4Kc4bkAfovdMQODk3T04asUc0kvZK+SsO6rk/6QbANsPBtpg/hUWCzGDqp
	 TgQ7R0mX/Bd4o5WNl2WADAzB07nwV9KqkJayjmNJY4mcWBLWI/LCL/ozpSjnEpV7h9dph
	 Vu9vY14+xDc8oV/TaFOcokArP6y0fOynidzLy1BEh87tykifSY4nzrmOK+Cbz11Gr9Xfu
	 xiGm8i133kz7HTCSyHJepUEL2v2uhaSiBBqextpephbVyJIL7kN/yw5BLK1ASmSgREQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=laveeshbansal.com;
	spf=pass smtp.mailfrom=laveeshbansal.com;
	dkim=pass header.d=laveeshbansal.com header.i=@laveeshbansal.com header.a=rsa-sha256 header.s=zoho header.b=Rh4OAECP;
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.15
Received: from sender5-op-o15.zoho.com (sender5-op-o15.zoho.com [165.173.182.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E319606A330
	for <git@vger.kernel.org>; Sun,  8 Nov 2026 01:22:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8E319606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=laveeshbansal.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=laveeshbansal.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=laveeshbansal.com header.i=@laveeshbansal.com header.a=rsa-sha256 header.s=zoho header.b=Rh4OAECP
ARC-Seal: i=1; a=rsa-sha256; t=1794100950; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=FZ0tVpfExLq/3MTv7ullM+8/kIVG1L11/aXRDDSsg4FWY3jCHGadpi/6/pXUH0t0Oocql7Lz2NxxMbR9+6Q6T9bAgyQYrfDCmYqiuYkXrPVVfmX61f50/hx8OoW3wgo+1n4qFdfMfO11QDjOyG8Fi5burS7nOpZpu8UC7CwCCvI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1794100950; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=QEA6qpoTdFIcV9uVMdtoBM7rPgIHyJWZuTg24UswJog=; 
	b=B8772T2ll64g85XV7wPhBPJLqAPIZxp2dfSt3b/7J/QgJmiaJ+MDTvv+j3Cr/BKsS3YW8ogooGPpBds8pqe+ciXHdUghygOj4pBprwJpbMij06xb/3WD80ZXNeN6gSAhXK1ehBTMB4eOVun20eus6FrKKnbXqZl5I9IzDV399HM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=laveeshbansal.com;
	spf=pass  smtp.mailfrom=laveeshb@laveeshbansal.com;
	dmarc=pass header.from=<laveeshb@laveeshbansal.com>
DKIM-Signature: a=rsa-sha256; b=Rh4OAECPzALBiP4W7cJDBv2pAe69xV51AuZjbqAi0vVPR8LivdtMQIQxOL5Fkb4TCEwrKapzi7eckufzSHBT4SMZlr6S9Y+osNsICuyQYhwkFTfI86T4znHW8boeoI9/98h8/2MLweGkaGHPsFbudrthzw8FRDH1jGfkZhnjvNQ=; c=relaxed/relaxed; s=zoho; d=laveeshbansal.com; v=1; bh=QEA6qpoTdFIcV9uVMdtoBM7rPgIHyJWZuTg24UswJog=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1794100948573711.9145598098438;
	Sat, 7 Nov 2026 17:22:28 -0800 (PST)
From: Laveesh Bansal <laveeshb@laveeshbansal.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Karthik Nayak <karthik.188@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= <avarab@gmail.com>
Subject: [PATCH] builtin/reflog: expire --all and named refs in one loop
Date: Sat,  7 Nov 2026 17:22:13 -0800
Message-ID: <20261108012213.89468-1-laveeshb@laveeshbansal.com>
X-Mailer: git-send-email 2.54.0
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

"git reflog expire" sets up the call to refs_reflog_expire() twice,
once for --all and once for refs named on the command line.
d1536ac3e2 (builtin/reflog: say "would prune" for named refs with
--dry-run, 2026-10-23) fixed the named-ref copy, which was missing
dry_run. Junio suggested a single loop in the review of that fix [1].

Collect the refs from both sources into one list and expire them in a
single loop. The names given on the command line are still looked up
in that loop, so the output and the exit status stay the same.

[1] https://lore.kernel.org/git/xmqqqzhdy7pi.fsf@gitster.g/

Assisted-by: Claude Sonnet 5.5
Signed-off-by: Laveesh Bansal <laveeshb@laveeshbansal.com>
---

Notes:
    The lookup stays in the loop. Doing it while collecting would report an
    unknown name before any expiry output, and make "expire --expire=now
    HEAD @{-1}" succeed.
    
    I ran the full test suite, and the reflog tests with reftable, sha256
    and SANITIZE=leak. Output, exit status and the resulting reflogs match
    the base for the cases I tried, including @{-1} and unknown names.

 builtin/reflog.c | 50 +++++++++++++++++++++++-------------------------
 1 file changed, 24 insertions(+), 26 deletions(-)

diff --git a/builtin/reflog.c b/builtin/reflog.c
index 49e5453dd9..42d37a3724 100644
--- a/builtin/reflog.c
+++ b/builtin/reflog.c
@@ -187,6 +187,10 @@ static int cmd_reflog_expire(int argc, const char **argv, const char *prefix,
 	unsigned int flags = 0;
 	int verbose = 0;
 	reflog_expiry_should_prune_fn *should_prune_fn = should_expire_reflog_ent;
+	struct worktree_reflogs collected = {
+		.reflogs = STRING_LIST_INIT_DUP,
+	};
+	struct string_list_item *item;
 	const struct option options[] = {
 		OPT_BIT('n', "dry-run", &flags, N_("do not actually prune any entries"),
 			EXPIRE_REFLOGS_DRY_RUN),
@@ -244,10 +248,6 @@ static int cmd_reflog_expire(int argc, const char **argv, const char *prefix,
 	}
 
 	if (do_all) {
-		struct worktree_reflogs collected = {
-			.reflogs = STRING_LIST_INIT_DUP,
-		};
-		struct string_list_item *item;
 		struct worktree **worktrees, **p;
 
 		worktrees = get_worktrees(the_repository);
@@ -259,44 +259,42 @@ static int cmd_reflog_expire(int argc, const char **argv, const char *prefix,
 					     collect_reflog, &collected);
 		}
 		free_worktrees(worktrees);
-
-		for_each_string_list_item(item, &collected.reflogs) {
-			struct expire_reflog_policy_cb cb = {
-				.opts = opts,
-				.dry_run = !!(flags & EXPIRE_REFLOGS_DRY_RUN),
-			};
-
-			reflog_expire_options_set_refname(&cb.opts,  item->string);
-			status |= refs_reflog_expire(get_main_ref_store(the_repository),
-						     item->string, flags,
-						     reflog_expiry_prepare,
-						     should_prune_fn,
-						     reflog_expiry_cleanup,
-						     &cb);
-		}
-		string_list_clear(&collected.reflogs, 0);
 	}
 
+	/* util marks the names that still have to be looked up */
 	for (i = 0; i < argc; i++) {
-		char *ref;
+		item = string_list_append(&collected.reflogs, argv[i]);
+		item->util = (void *)1;
+	}
+
+	for_each_string_list_item(item, &collected.reflogs) {
 		struct expire_reflog_policy_cb cb = {
 			.opts = opts,
 			.dry_run = !!(flags & EXPIRE_REFLOGS_DRY_RUN),
 		};
-
-		if (!repo_dwim_log(the_repository, argv[i], strlen(argv[i]), NULL, &ref)) {
-			status |= error(_("reflog could not be found: '%s'"), argv[i]);
+		const char *refname = item->string;
+		char *ref = NULL;
+
+		if (item->util &&
+		    !repo_dwim_log(the_repository, item->string,
+				   strlen(item->string), NULL, &ref)) {
+			status |= error(_("reflog could not be found: '%s'"),
+					item->string);
 			continue;
 		}
-		reflog_expire_options_set_refname(&cb.opts, ref);
+		if (ref)
+			refname = ref;
+
+		reflog_expire_options_set_refname(&cb.opts, refname);
 		status |= refs_reflog_expire(get_main_ref_store(the_repository),
-					     ref, flags,
+					     refname, flags,
 					     reflog_expiry_prepare,
 					     should_prune_fn,
 					     reflog_expiry_cleanup,
 					     &cb);
 		free(ref);
 	}
+	string_list_clear(&collected.reflogs, 0);
 
 	reflog_clear_expire_config(&opts);
 
-- 
2.54.0

