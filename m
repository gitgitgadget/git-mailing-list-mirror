Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.15
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795290834;
	b=s5hcV60qhsZ7dc20n2hKlGFPQ/kr/CNzzqWQ3IMVvPKbIP+XN1zOgpLWcnrv1WMzEvyc
	 S6ysECZlF/wleVGnYDtjlIQuAVAS+9/Op+uzyYYJ2R9M+TIdOsdGT9n+3oZVJaJuf9xGW
	 Z8oQievOdtJuljJP3t9YDJtpYvylurkVqOqpBz9xbNrUmuMmBNxq1j+oD9QNuOOaJyszh
	 WErzmjpU+NFmmAEIQF8C8JSzRBTU0NJ/ccNssNelhFZ2EAiYCaGk8jP5QRJ2qZ51Hj5MM
	 aVLVIMinh1V+pOwydF8dmOTIkXompumsCVrJWhnoLu5KApQGaphl/SM56+UoJoA/HdQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795290834;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-ZohoMailClient;
	bh=Mir1YAB233W46SZlMGkUF5xg8Xd1gUnbP91UFaBbWIU=;
	b=yKynoDWKEiQUJosG8DWV/U0AP7UD8+1rm6bs90dX44xhQ8Jv0FHAscCdAw0SgGC5mnU/
	 QrcpXvllr1NX+3+0YMcF5sBAJSsXaeMMmOBdqvOOdDuVFcNmsLsAckq6JpIOwUGNCkK9O
	 uRDlfvpWMR0kXOGIuqeIdYSsjqyPWkrSVK5V3Js1aasp8EcxHsUd8hi19utHxUqdhzcRW
	 wt+Bxo9uhQoDDZrJyypWD09/Hrc9GvruoNvB+TFE7b8Jlcqe1TgmwD522CziqmeSa4/vZ
	 PIXtgu2oJmVqGdHG0aXQCtiyJGT4wZ8zw3eKeN1cazRMvx37ui017jH8diLeDy1wg4g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=laveeshbansal.com;
	spf=pass smtp.mailfrom=laveeshbansal.com;
	dkim=pass header.d=laveeshbansal.com header.i=@laveeshbansal.com header.a=rsa-sha256 header.s=zoho header.b="L90Ty/pi";
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.15
Received: from sender6-op-o15.zoho.com (sender6-op-o15.zoho.com [165.173.180.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23876606A320
	for <git@vger.kernel.org>; Sat, 21 Nov 2026 19:53:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 23876606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=laveeshbansal.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=laveeshbansal.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=laveeshbansal.com header.i=@laveeshbansal.com header.a=rsa-sha256 header.s=zoho header.b=L90Ty/pi
ARC-Seal: i=1; a=rsa-sha256; t=1795290817; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=LluvBSvSlHBvE/FeatrVZMnnJ0Q9l5ADkB5VL+zCuIgKZrs2LvNVUe6F1UVFxnYjzOEwsmGNuCe7R9SyPqpsWgsZ/QABvW1DXlhafMvy41s05WZR2UoAQTaZEw5itwBZw4Fv229TcasZRnIMMTzUX/RpiK1wQoPT3mjRNthkwBw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1795290817; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=Mir1YAB233W46SZlMGkUF5xg8Xd1gUnbP91UFaBbWIU=; 
	b=b5NNMY1OZAD9kwUm8oqcUJfdsfhmSK771Str2wtiUq+Ekad8Cahj5nlMdB7wYlolk1L6TUEP1Cny+Iz8hNsW/ZB/1bfXrcTA62O0TxSAYbxI+dVbkBn7QXUNCYcgf7QD7MYwcCYZYToDDaHxW6OG9st8z29KspJpbS950Q6Ju9U=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=laveeshbansal.com;
	spf=pass  smtp.mailfrom=laveeshb@laveeshbansal.com;
	dmarc=pass header.from=<laveeshb@laveeshbansal.com>
DKIM-Signature: a=rsa-sha256; b=L90Ty/pi1B1gKGB77gJCRHY2J5ah1lppKid9MgnnAf7wSE6RdqFmlgDApoyR11ZrKJ1DEWjk4SeVUDRz3rs8FlZzg47orSf2gVCW9OB0m6q/aCsAOD6gWXiARYzuBBvhMueQJ1qMjy1v8Da303+L98otFFBFPLq94ZRoamieWKo=; c=relaxed/relaxed; s=zoho; d=laveeshbansal.com; v=1; bh=Mir1YAB233W46SZlMGkUF5xg8Xd1gUnbP91UFaBbWIU=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1795290813661289.29033274660617;
	Sat, 21 Nov 2026 11:53:33 -0800 (PST)
From: Laveesh Bansal <laveeshb@laveeshbansal.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Karthik Nayak <karthik.188@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= <avarab@gmail.com>
Subject: [PATCH v3 2/2] builtin/reflog: expire each reflog only once
Date: Sat, 21 Nov 2026 11:53:17 -0800
Message-ID: <3ac3a8fbba527fefeb331ae0334c4106a9806b5b.1795290319.git.laveeshb@laveeshbansal.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1795290319.git.laveeshb@laveeshbansal.com>
References: <cover.1794324064.git.laveeshb@laveeshbansal.com> <cover.1795290319.git.laveeshb@laveeshbansal.com>
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

"git reflog expire" processes a reflog once for every time it is named,
and reports it every time:

    $ git reflog expire --dry-run --verbose --expire=now main main
    would prune commit (initial): one
    would prune commit (initial): one

The same happens for two names of the same ref, such as "main" and
"refs/heads/main", and for a name that --all already covers.

With --updateref, naming a ref twice can also lose entries.  The first
pass can move the ref to the last entry it kept, and the second pass
then prunes entries that mention commits the new tip does not reach.

Skip a reflog that this run has already processed.  Add tests for the
repeated output and for --updateref.

Signed-off-by: Laveesh Bansal <laveeshb@laveeshbansal.com>
---

Notes:
    I kept the order in which reflogs are expired.  With --updateref,
    expiring a branch can move it, and "HEAD" is checked against the tip of
    every ref, so expiring "HEAD" before or after that branch can prune
    different entries.  Sorting the names would change that order, so I
    used a strset instead.
    
    This does not catch names that reach a reflog through a worktree
    prefix, such as "HEAD" and "main-worktree/HEAD", or names that do not
    exist.  Those are still processed or reported twice.

 builtin/reflog.c  |  8 ++++++++
 t/t1410-reflog.sh | 37 +++++++++++++++++++++++++++++++++++++
 2 files changed, 45 insertions(+)

diff --git a/builtin/reflog.c b/builtin/reflog.c
index 42d37a3724..51a3d29505 100644
--- a/builtin/reflog.c
+++ b/builtin/reflog.c
@@ -12,6 +12,7 @@
 #include "reflog.h"
 #include "refs.h"
 #include "parse-options.h"
+#include "strmap.h"
 
 #define BUILTIN_REFLOG_SHOW_USAGE \
 	N_("git reflog [show] [<log-options>] [<ref>]")
@@ -190,6 +191,7 @@ static int cmd_reflog_expire(int argc, const char **argv, const char *prefix,
 	struct worktree_reflogs collected = {
 		.reflogs = STRING_LIST_INIT_DUP,
 	};
+	struct strset seen = STRSET_INIT;
 	struct string_list_item *item;
 	const struct option options[] = {
 		OPT_BIT('n', "dry-run", &flags, N_("do not actually prune any entries"),
@@ -285,6 +287,11 @@ static int cmd_reflog_expire(int argc, const char **argv, const char *prefix,
 		if (ref)
 			refname = ref;
 
+		if (!strset_add(&seen, refname)) {
+			free(ref);
+			continue;
+		}
+
 		reflog_expire_options_set_refname(&cb.opts, refname);
 		status |= refs_reflog_expire(get_main_ref_store(the_repository),
 					     refname, flags,
@@ -295,6 +302,7 @@ static int cmd_reflog_expire(int argc, const char **argv, const char *prefix,
 		free(ref);
 	}
 	string_list_clear(&collected.reflogs, 0);
+	strset_clear(&seen);
 
 	reflog_clear_expire_config(&opts);
 
diff --git a/t/t1410-reflog.sh b/t/t1410-reflog.sh
index 998a7e8667..92aeff9bfe 100755
--- a/t/t1410-reflog.sh
+++ b/t/t1410-reflog.sh
@@ -274,6 +274,43 @@ test_expect_success 'reflog expire --dry-run --verbose --all' '
 	test_cmp before after
 '
 
+test_expect_success 'reflog expire does not process a reflog twice' '
+	git reflog expire --dry-run --verbose \
+		--expire=$(($test_tick - 10000)) \
+		--expire-unreachable=$(($test_tick - 10000)) \
+		--stale-fix \
+		--all >once &&
+	git reflog expire --dry-run --verbose \
+		--expire=$(($test_tick - 10000)) \
+		--expire-unreachable=$(($test_tick - 10000)) \
+		--stale-fix \
+		--all main refs/heads/main main >twice &&
+	test_cmp once twice
+'
+
+test_expect_success 'reflog expire --updateref with a ref named twice' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		git checkout -b topic &&
+		test_commit one &&
+		test_commit two &&
+		test_commit three &&
+		git reset --hard two &&
+		git reset --hard three &&
+		# Without the newest entry the reflog ends at two while
+		# topic is at three, so --updateref has a ref to move.
+		git reflog delete topic@{0} &&
+		git reflog topic >expect &&
+		git reflog expire --updateref --expire=never \
+			--expire-unreachable=now topic topic &&
+		git reflog topic >actual &&
+		test_cmp expect actual &&
+		test_cmp_rev two topic
+	)
+'
+
 test_expect_success 'reflog expire' '
 
 	git reflog expire --verbose \
-- 
2.54.0

