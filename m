Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.15
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794324484;
	b=puAGTT2QLR5oeSoLf9bAu2kg5NS9tNT1TM6GaJ9oRZ/tWJavQ++YgNzEs4IpXAjDJu7W
	 SHxVusyeJ/bltQSpbpSXUJEvawS2IWN/EUt5tWYqS93L26UuCbU+3I3iBkFUvhjpIpOkN
	 4MKtjra1Hl2yFX9/xy+61fu7HxhIHoehyA5LYKdGIrBWk7iN60QfYaBiP+IU0GZzASLsi
	 MqBSrPPgKr2ja3JfIjje3E63Gc2udkTVevhEd5JZKBSOHLL+MdtqzmLwORfhSVmilbIXb
	 WI/6DczO3blZ+er1F6hvZ8Ons+C3j+E/YUqt5UzPNAWeBy6emMhY2HAuuKi8jtpEBqw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794324484;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-ZohoMailClient;
	bh=PUrAxMb2ByCAIFwLuGY7ACRDlSD9UXydzFIYbITAK8E=;
	b=XTayUVTlY7mS1D0ecVlfNp91suu6ue51qp3XOtX8A0pQpiaumbfqPuC4YtRWUNxp0DIb
	 S2MC95H7lCyi84TP5S4ZH7CdshuSjA1g/vETlJfsn/yYyGHYgxzcxkeBN3IyH14M9DEio
	 NMDwaiRyjv6UD1+CHGEbzfGQ8Wi/WAiBDJ5nMkPGQdNxVp98XIn+e8S3u3xi0thZUclWo
	 0AbvceY6YP/shO6DkQfvJGT+dmcZQlVqSGDflcsQ1hUF+OrdZOPtZ0ZK9bdxWxANsDplY
	 9Nyb9JYVYmaR/iQ/7rrKJp8wveSAOQ4hLkaFR+VhHj/F3B//RBKX4llr0/DMEl+ItPw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=laveeshbansal.com;
	spf=pass smtp.mailfrom=laveeshbansal.com;
	dkim=pass header.d=laveeshbansal.com header.i=@laveeshbansal.com header.a=rsa-sha256 header.s=zoho header.b=cbgCiVND;
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.15
Received: from sender5-op-o15.zoho.com (sender5-op-o15.zoho.com [165.173.182.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A82E606A31C
	for <git@vger.kernel.org>; Tue, 10 Nov 2026 15:28:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6A82E606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=laveeshbansal.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=laveeshbansal.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=laveeshbansal.com header.i=@laveeshbansal.com header.a=rsa-sha256 header.s=zoho header.b=cbgCiVND
ARC-Seal: i=1; a=rsa-sha256; t=1794324436; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=V/J8L47iQOx2K0BCtdNw55PVhDA28IG2wizWlDwoJ8HJP4Vmq9pep3urv4UbcMaj6Y/yGaffBmBpl3Cj6Elm0Stqf6JZ/wMdFRM5eeJXvMIqAlxokGi2s7gAx1oxK+ghp6X23gKJCQrGJiLVNhoQOp4j5+0PgyHBZPxOCyYBoMw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1794324436; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=PUrAxMb2ByCAIFwLuGY7ACRDlSD9UXydzFIYbITAK8E=; 
	b=DFmPOYyJEyCqJtxZJsk01OR0TiemL8ulLTYTJQexED8A5ObPEoYjB93Czp4xUGuu+STjKPt0Duc/ffdEd3c/GOFxG2oIxgShd7OITgffrt66TwNMkJjqCpKnW+sMOS87PS8dpmkvlvpDN+HYqkw0yV/XmLfhGDd6+VElBJCOPyU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=laveeshbansal.com;
	spf=pass  smtp.mailfrom=laveeshb@laveeshbansal.com;
	dmarc=pass header.from=<laveeshb@laveeshbansal.com>
DKIM-Signature: a=rsa-sha256; b=cbgCiVNDOjSCJ+JUFpqf583fGTo2VQn5DelEaR+qDa4KeP1T7YLjwO+NpXsekMh95fg2GGeAjNgpx/sT6yllpFYifUpvICUSvkaXchnqQ6mSj5CWnJzRt4jlj0PzrjcscciVTCbq/I9VPFPMew4UlxKsazzaiZBEbY5jAKfj2jI=; c=relaxed/relaxed; s=zoho; d=laveeshbansal.com; v=1; bh=PUrAxMb2ByCAIFwLuGY7ACRDlSD9UXydzFIYbITAK8E=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1794324426753698.0345998147542;
	Tue, 10 Nov 2026 07:27:06 -0800 (PST)
From: Laveesh Bansal <laveeshb@laveeshbansal.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Karthik Nayak <karthik.188@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= <avarab@gmail.com>
Subject: [PATCH v2 2/2] builtin/reflog: expire each reflog only once
Date: Tue, 10 Nov 2026 07:26:41 -0800
Message-ID: <0e5d78f552deaf3bd0ba2ec70666cebc2957c9e4.1794324064.git.laveeshb@laveeshbansal.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1794324064.git.laveeshb@laveeshbansal.com>
References: <20261108012213.89468-1-laveeshb@laveeshbansal.com> <cover.1794324064.git.laveeshb@laveeshbansal.com>
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

Skip a reflog that this run has already processed.

Signed-off-by: Laveesh Bansal <laveeshb@laveeshbansal.com>
---

Notes:
    With --updateref, the first pass can move the ref, so a second pass
    over the same reflog could prune entries that the new tip no longer
    reaches.  It now ends as if the name had been given once.

 builtin/reflog.c  |  8 ++++++++
 t/t1410-reflog.sh | 14 ++++++++++++++
 2 files changed, 22 insertions(+)

diff --git a/builtin/reflog.c b/builtin/reflog.c
index 42d37a3724..4221136298 100644
--- a/builtin/reflog.c
+++ b/builtin/reflog.c
@@ -190,6 +190,7 @@ static int cmd_reflog_expire(int argc, const char **argv, const char *prefix,
 	struct worktree_reflogs collected = {
 		.reflogs = STRING_LIST_INIT_DUP,
 	};
+	struct string_list seen = STRING_LIST_INIT_DUP;
 	struct string_list_item *item;
 	const struct option options[] = {
 		OPT_BIT('n', "dry-run", &flags, N_("do not actually prune any entries"),
@@ -285,6 +286,12 @@ static int cmd_reflog_expire(int argc, const char **argv, const char *prefix,
 		if (ref)
 			refname = ref;
 
+		if (string_list_has_string(&seen, refname)) {
+			free(ref);
+			continue;
+		}
+		string_list_insert(&seen, refname);
+
 		reflog_expire_options_set_refname(&cb.opts, refname);
 		status |= refs_reflog_expire(get_main_ref_store(the_repository),
 					     refname, flags,
@@ -295,6 +302,7 @@ static int cmd_reflog_expire(int argc, const char **argv, const char *prefix,
 		free(ref);
 	}
 	string_list_clear(&collected.reflogs, 0);
+	string_list_clear(&seen, 0);
 
 	reflog_clear_expire_config(&opts);
 
diff --git a/t/t1410-reflog.sh b/t/t1410-reflog.sh
index 998a7e8667..d22216c36d 100755
--- a/t/t1410-reflog.sh
+++ b/t/t1410-reflog.sh
@@ -274,6 +274,20 @@ test_expect_success 'reflog expire --dry-run --verbose --all' '
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
 test_expect_success 'reflog expire' '
 
 	git reflog expire --verbose \
-- 
2.54.0

