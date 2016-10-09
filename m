Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1B21820986
	for <e@80x24.org>; Sun,  9 Oct 2016 08:07:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752575AbcJIIHn (ORCPT <rfc822;e@80x24.org>);
        Sun, 9 Oct 2016 04:07:43 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36118 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751561AbcJIIHm (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Oct 2016 04:07:42 -0400
Received: by mail-wm0-f66.google.com with SMTP id 123so9347566wmb.3
        for <git@vger.kernel.org>; Sun, 09 Oct 2016 01:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kaarsemaker-net.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:date:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=dY8RiT6CVE5ZNdaPgC7jlgnpGZYs4MFx/y9mw78YZTo=;
        b=HlXumRpwUSHAPSrMEQ3qjxH3MWCIAFmwtDaCUQVfYSmqFTB9foFYgMFhp4RM6Ks05n
         /oVpyhQVGyevzaJs/mp7wEA5FhSVdFM0mCKPeDS7OFsei3Mze4p9HXifVvlvaf5ofL3i
         BkGOdnswLXMhafykpBK9eAbzZRjiX7oG8cmJYzj4wASBJCKgQ9Lu4TCnaA4xT1m61TeR
         /Sfl1CHeJ1roH5hpPycSBQbkpwxeeH0J/jjbVlsO0l4LDxwaXalE4IZP8oM2tAvAB40D
         8chGwas3FWAXrh1d7WlbJtQMge8eSCgHRGDPVddI1WAk8gW678i+llnBYQJ470m0J16v
         r6mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dY8RiT6CVE5ZNdaPgC7jlgnpGZYs4MFx/y9mw78YZTo=;
        b=eqdideXGuEevYMN4kJcLvJQPE728c9y93dbXMDCD1M4mtyuTS+cO2z/wCw8DoMS6Zb
         6nQouw/PVYY81Q7zJN1BGcwNYEnlc3OQPZkkhSsV0yfTClXDuVcn4nOB0ffEypnLv1EZ
         8SuMBSJhDK7hJBNLw9nvjoTCviDWl6uRTjWC1CHfmXoHwn8EVPvsatxG3JebNqASSaDE
         ppr3bloctjHFknyBpLTeE8XHJTBOgpzXHZqt6gXA/HiUs9V6iK5X+GM7fddWnolChIsA
         MGph7VUU4m4z/IdISsKqKJgh8yHkOE0pHVfL4i40+CjO+zcju2q5JoC7lT2u+16ohk16
         +QuQ==
X-Gm-Message-State: AA6/9RmuBBwDERUHnWpyk8uYllkyolHI4GjpgO1z2tnE/N7HN/j3lPgl6d+RgsPTnazPtQ==
X-Received: by 10.28.169.198 with SMTP id s189mr5051528wme.23.1475999514990;
        Sun, 09 Oct 2016 00:51:54 -0700 (PDT)
Received: from [10.42.1.91] ([145.132.209.114])
        by smtp.gmail.com with ESMTPSA id i12sm11967244wmf.6.2016.10.09.00.51.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 09 Oct 2016 00:51:54 -0700 (PDT)
Message-ID: <1475999513.7410.8.camel@kaarsemaker.net>
Subject: Re: Bug? git worktree fails with master on bare repo
From:   Dennis Kaarsemaker <dennis@kaarsemaker.net>
To:     Michael Tutty <mtutty@gforgegroup.com>, git@vger.kernel.org,
        pclouds@gmail.com
Date:   Sun, 09 Oct 2016 09:51:53 +0200
In-Reply-To: <CAOi_75+2SG2WYHBMQhfGj96eKsZ66niJzOevVGM5eJv-qqrVNg@mail.gmail.com>
References: <CAOi_75+2SG2WYHBMQhfGj96eKsZ66niJzOevVGM5eJv-qqrVNg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.0-2ubuntu1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, 2016-10-08 at 19:30 -0500, Michael Tutty wrote:
> Hey all,
> I'm working on some server-side software to do a merge. By using git
> worktree it's possible to check out a given branch for a bare repo and
> merge another branch into it. It's very fast, even with large
> repositories.
> 
> The only exception seems to be merging to master. When I do git
> worktree add /tmp/path/to/worktree master I get an error:
> 
> [fatal: 'master' is already checked out at '/path/to/bare/repo']
> 
> But this is clearly not true, git worktree list gives:
> 
> [/path/to/bare/repo (bare)]
> 
> ...and of course, there is no work tree at that path, just the bare
> repo files you'd expect.

The worktree code treats the base repo as a worktree, even if it's
bare. For the purpose of being able to do a checkout of the main branch
of a bare repo, this patch should do:

diff --git a/t/t2025-worktree-add.sh b/t/t2025-worktree-add.sh
index 4bcc335..b618d6b 100755
--- a/t/t2025-worktree-add.sh
+++ b/t/t2025-worktree-add.sh
@@ -138,6 +138,14 @@ test_expect_success 'checkout from a bare repo without "add"' '
        )
 '
 
+test_expect_success '"add" default branch of a bare repo' '
+       (
+               git clone --bare . bare2 &&
+               cd bare2 &&
+               git worktree add ../there3 master
+       )
+'
+
 test_expect_success 'checkout with grafts' '
        test_when_finished rm .git/info/grafts &&
        test_commit abc &&
diff --git a/worktree.c b/worktree.c
index 5acfe4c..35e95b7 100644
--- a/worktree.c
+++ b/worktree.c
@@ -345,6 +345,8 @@ const struct worktree *find_shared_symref(const char *symref,
 
        for (i = 0; worktrees[i]; i++) {
                struct worktree *wt = worktrees[i];
+               if(wt->is_bare)
+                       continue;
 
                if (wt->is_detached && !strcmp(symref, "HEAD")) {
                        if (is_worktree_being_rebased(wt, target)) {


But I'm wondering why the worktree code does this. A bare repo isn't a
worktree and I think it shouldn't treat it as one. A patch that rips
out this feature and updates the tests to match would look like this:


diff --git a/builtin/worktree.c b/builtin/worktree.c
index 5c4854d..3600530 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -382,15 +382,11 @@ static int add(int ac, const char **av, const char *prefix)
 static void show_worktree_porcelain(struct worktree *wt)
 {
 	printf("worktree %s\n", wt->path);
-	if (wt->is_bare)
-		printf("bare\n");
-	else {
-		printf("HEAD %s\n", sha1_to_hex(wt->head_sha1));
-		if (wt->is_detached)
-			printf("detached\n");
-		else
-			printf("branch %s\n", wt->head_ref);
-	}
+	printf("HEAD %s\n", sha1_to_hex(wt->head_sha1));
+	if (wt->is_detached)
+		printf("detached\n");
+	else
+		printf("branch %s\n", wt->head_ref);
 	printf("\n");
 }
 
@@ -401,16 +397,12 @@ static void show_worktree(struct worktree *wt, int path_maxlen, int abbrev_len)
 	int path_adj = cur_path_len - utf8_strwidth(wt->path);
 
 	strbuf_addf(&sb, "%-*s ", 1 + path_maxlen + path_adj, wt->path);
-	if (wt->is_bare)
-		strbuf_addstr(&sb, "(bare)");
-	else {
-		strbuf_addf(&sb, "%-*s ", abbrev_len,
-				find_unique_abbrev(wt->head_sha1, DEFAULT_ABBREV));
-		if (!wt->is_detached)
-			strbuf_addf(&sb, "[%s]", shorten_unambiguous_ref(wt->head_ref, 0));
-		else
-			strbuf_addstr(&sb, "(detached HEAD)");
-	}
+	strbuf_addf(&sb, "%-*s ", abbrev_len,
+			find_unique_abbrev(wt->head_sha1, DEFAULT_ABBREV));
+	if (!wt->is_detached)
+		strbuf_addf(&sb, "[%s]", shorten_unambiguous_ref(wt->head_ref, 0));
+	else
+		strbuf_addstr(&sb, "(detached HEAD)");
 	printf("%s\n", sb.buf);
 
 	strbuf_release(&sb);
diff --git a/t/t2025-worktree-add.sh b/t/t2025-worktree-add.sh
index 4bcc335..b618d6b 100755
--- a/t/t2025-worktree-add.sh
+++ b/t/t2025-worktree-add.sh
@@ -138,6 +138,14 @@ test_expect_success 'checkout from a bare repo without "add"' '
 	)
 '
 
+test_expect_success '"add" default branch of a bare repo' '
+	(
+		git clone --bare . bare2 &&
+		cd bare2 &&
+		git worktree add ../there3 master
+	)
+'
+
 test_expect_success 'checkout with grafts' '
 	test_when_finished rm .git/info/grafts &&
 	test_commit abc &&
diff --git a/t/t2027-worktree-list.sh b/t/t2027-worktree-list.sh
index 1b1b65a..842e9d9 100755
--- a/t/t2027-worktree-list.sh
+++ b/t/t2027-worktree-list.sh
@@ -62,9 +62,8 @@ test_expect_success 'bare repo setup' '
 
 test_expect_success '"list" all worktrees from bare main' '
 	test_when_finished "rm -rf there && git -C bare1 worktree prune" &&
-	git -C bare1 worktree add --detach ../there master &&
-	echo "$(pwd)/bare1 (bare)" >expect &&
-	echo "$(git -C there rev-parse --show-toplevel) $(git -C there rev-parse --short HEAD) (detached HEAD)" >>expect &&
+	git -C bare1 worktree add ../there master &&
+	echo "$(git -C there rev-parse --show-toplevel) $(git -C there rev-parse --short HEAD) [master]" >expect &&
 	git -C bare1 worktree list | sed "s/  */ /g" >actual &&
 	test_cmp expect actual
 '
@@ -72,10 +71,7 @@ test_expect_success '"list" all worktrees from bare main' '
 test_expect_success '"list" all worktrees --porcelain from bare main' '
 	test_when_finished "rm -rf there && git -C bare1 worktree prune" &&
 	git -C bare1 worktree add --detach ../there master &&
-	echo "worktree $(pwd)/bare1" >expect &&
-	echo "bare" >>expect &&
-	echo >>expect &&
-	echo "worktree $(git -C there rev-parse --show-toplevel)" >>expect &&
+	echo "worktree $(git -C there rev-parse --show-toplevel)" >expect &&
 	echo "HEAD $(git -C there rev-parse HEAD)" >>expect &&
 	echo "detached" >>expect &&
 	echo >>expect &&
@@ -85,9 +81,8 @@ test_expect_success '"list" all worktrees --porcelain from bare main' '
 
 test_expect_success '"list" all worktrees from linked with a bare main' '
 	test_when_finished "rm -rf there && git -C bare1 worktree prune" &&
-	git -C bare1 worktree add --detach ../there master &&
-	echo "$(pwd)/bare1 (bare)" >expect &&
-	echo "$(git -C there rev-parse --show-toplevel) $(git -C there rev-parse --short HEAD) (detached HEAD)" >>expect &&
+	git -C bare1 worktree add ../there master &&
+	echo "$(git -C there rev-parse --show-toplevel) $(git -C there rev-parse --short HEAD) [master]" >expect &&
 	git -C there worktree list | sed "s/  */ /g" >actual &&
 	test_cmp expect actual
 '
diff --git a/worktree.c b/worktree.c
index 5acfe4c..d4dbaab 100644
--- a/worktree.c
+++ b/worktree.c
@@ -84,7 +84,7 @@ static struct worktree *get_main_worktree(void)
 	strbuf_add_absolute_path(&worktree_path, get_git_common_dir());
 	is_bare = !strbuf_strip_suffix(&worktree_path, "/.git");
 	if (is_bare)
-		strbuf_strip_suffix(&worktree_path, "/.");
+		goto done;
 
 	strbuf_addf(&path, "%s/HEAD", get_git_common_dir());
 
@@ -94,7 +94,6 @@ static struct worktree *get_main_worktree(void)
 	worktree = xmalloc(sizeof(struct worktree));
 	worktree->path = strbuf_detach(&worktree_path, NULL);
 	worktree->id = NULL;
-	worktree->is_bare = is_bare;
 	worktree->head_ref = NULL;
 	worktree->is_detached = is_detached;
 	worktree->is_current = 0;
@@ -141,7 +140,6 @@ static struct worktree *get_linked_worktree(const char *id)
 	worktree = xmalloc(sizeof(struct worktree));
 	worktree->path = strbuf_detach(&worktree_path, NULL);
 	worktree->id = xstrdup(id);
-	worktree->is_bare = 0;
 	worktree->head_ref = NULL;
 	worktree->is_detached = is_detached;
 	worktree->is_current = 0;
diff --git a/worktree.h b/worktree.h
index 90e1311..04a75e8 100644
--- a/worktree.h
+++ b/worktree.h
@@ -8,7 +8,6 @@ struct worktree {
 	char *lock_reason;	/* internal use */
 	unsigned char head_sha1[20];
 	int is_detached;
-	int is_bare;
 	int is_current;
 	int lock_reason_valid;
 };
