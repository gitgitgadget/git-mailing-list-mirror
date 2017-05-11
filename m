Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RCVD_IN_SORBS_WEB,RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 046622018D
	for <e@80x24.org>; Thu, 11 May 2017 13:49:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932814AbdEKNsO (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 May 2017 09:48:14 -0400
Received: from mout.gmx.net ([212.227.15.15]:50882 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932773AbdEKNsD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 May 2017 09:48:03 -0400
Received: from virtualbox ([37.201.192.198]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LanoO-1dt6Up2Toe-00kLI4; Thu, 11
 May 2017 15:47:59 +0200
Date:   Thu, 11 May 2017 15:47:59 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 08/11] PREVIEW: remote: remove support for migrating ancient
 remotes
In-Reply-To: <cover.1494509599.git.johannes.schindelin@gmx.de>
Message-ID: <86474db5654befa3880a33c10eb62075c6e2a5e0.1494509599.git.johannes.schindelin@gmx.de>
References: <cover.1494509599.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:+ILZKZ6dw7E3lEWayDfmL9s4P1zsQIP4y/VKWIvm3irvbceNAfU
 /ODCtaStwGrl1lSSRt2aQ38i0H/0IE89vh2vrk11Sf8ZHQq9aRDOsnv7MwfIlYfLqYIAKY9
 9dniDGxENferYR4dWJ2FWY9qODWgtzqrAirR5+unss2hidZUrtsgn163DavsjNoo7SHIX/B
 QFVAEscKlbG3Lb9EGADcg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ir6btlFHNok=:oL/zxDamD1vg0pQmZlOrqa
 EHI19WHMHBV5ZSzkiaOkL7J+/LGcj7VwWZCXf+IT1t4VzzpWQUSAK7aZJIZGGMYbOLc0YhjAh
 CBan60Lh4GjeBiUFUgoCdr16OtGGqPwiGKE218UL/+49yYa32TiYs2/o/IHliP9v8KNKg6Jw/
 2nLvLZe+g1GNFTA17I5BnwgV6CYb4yBFUPQoD+JMqoSsjH3gXp1GMhHZRmfUITb0c+ibajnAw
 qF+jOQs0O4Qx5OlnU8zLUyGvzY5gho00uUoVJ9dAM5oY+6F8yDl3zpY5fNfuCke2q65derpTq
 12Fk42MeZ8tiIGce6kOWmgQK+IbhiV8zjs26vxbEjEsAwemxJmiQkpIvFoCAjas6/Bsm0pe9Z
 a1wulWakRISvyEItK4TSVOj23TTwKhZQMrrzMDI57h1T4s8qVZPvoHorYsx6TYyi4+tuX2N3L
 6W+fca2hh6pooUumB65MSkQxDPChklQ+9aqrARgmU9/pTHWrmcqLA3jFwttOMvqZfFyyozsZr
 CZsD/Zmi1x4pJ6xCZcmULxDUwpmDOi3oKT7gNVrZxEkm4sglqwdq/zWl9fbJhqOxgqyc412iW
 ppmQIfLkKrPkpAmTuOF3IEnxmIettQk3t2+iMi7b1pBibA9Qj1WdLrLJKH/sNGIZwBLb9spKC
 glK0/nrnzX7LQnuaRAGj9H6wUzRymMhGt4DGmDGKA7as5w2swj2P3OhgIQk7rNWL2uy+eWtqc
 XOBkUvuzl6kpHt9Taeu9dvOvvDYiBgbafHNhccmrxsYK1uki5G1USZhvFPeIftdH5kTCKrPuu
 MrhELZ1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

By now, everybody will have moved on... no need to burden ourselves with
now-obsolete code.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Documentation/git-remote.txt |  4 ----
 builtin/remote.c             | 27 ---------------------
 t/t5505-remote.sh            | 57 --------------------------------------------
 3 files changed, 88 deletions(-)

diff --git a/Documentation/git-remote.txt b/Documentation/git-remote.txt
index 577b969c1bd..746fdd27ced 100644
--- a/Documentation/git-remote.txt
+++ b/Documentation/git-remote.txt
@@ -84,10 +84,6 @@ will always behave as if `--mirror` was passed.
 
 Rename the remote named <old> to <new>. All remote-tracking branches and
 configuration settings for the remote are updated.
-+
-In case <old> and <new> are the same, and <old> is a file under
-`$GIT_DIR/remotes` or `$GIT_DIR/branches`, the remote is converted to
-the configuration file format.
 
 'remove'::
 'rm'::
diff --git a/builtin/remote.c b/builtin/remote.c
index addf97ad293..c3502f24223 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -574,30 +574,6 @@ static int read_remote_branches(const char *refname,
 	return 0;
 }
 
-static int migrate_file(struct remote *remote)
-{
-	struct strbuf buf = STRBUF_INIT;
-	int i;
-
-	strbuf_addf(&buf, "remote.%s.url", remote->name);
-	for (i = 0; i < remote->url_nr; i++)
-		git_config_set_multivar(buf.buf, remote->url[i], "^$", 0);
-	strbuf_reset(&buf);
-	strbuf_addf(&buf, "remote.%s.push", remote->name);
-	for (i = 0; i < remote->push_refspec_nr; i++)
-		git_config_set_multivar(buf.buf, remote->push_refspec[i], "^$", 0);
-	strbuf_reset(&buf);
-	strbuf_addf(&buf, "remote.%s.fetch", remote->name);
-	for (i = 0; i < remote->fetch_refspec_nr; i++)
-		git_config_set_multivar(buf.buf, remote->fetch_refspec[i], "^$", 0);
-	if (remote->origin == REMOTE_REMOTES)
-		unlink_or_warn(git_path("remotes/%s", remote->name));
-	else if (remote->origin == REMOTE_BRANCHES)
-		unlink_or_warn(git_path("branches/%s", remote->name));
-
-	return 0;
-}
-
 static int mv(int argc, const char **argv)
 {
 	struct option options[] = {
@@ -621,9 +597,6 @@ static int mv(int argc, const char **argv)
 	if (!remote_is_configured(oldremote, 1))
 		die(_("No such remote: %s"), rename.old);
 
-	if (!strcmp(rename.old, rename.new) && oldremote->origin != REMOTE_CONFIG)
-		return migrate_file(oldremote);
-
 	newremote = remote_get(rename.new);
 	if (remote_is_configured(newremote, 1))
 		die(_("remote %s already exists."), rename.new);
diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
index 4fd66760c75..857950ac8ee 100755
--- a/t/t5505-remote.sh
+++ b/t/t5505-remote.sh
@@ -798,63 +798,6 @@ Pull: refs/heads/master:refs/heads/origin
 Pull: refs/heads/next:refs/heads/origin2
 EOF
 
-test_expect_success 'migrate a remote from named file in $GIT_DIR/remotes' '
-	git clone one five &&
-	origin_url=$(pwd)/one &&
-	(
-		cd five &&
-		git remote remove origin &&
-		mkdir -p .git/remotes &&
-		cat ../remotes_origin >.git/remotes/origin &&
-		git remote rename origin origin &&
-		test_path_is_missing .git/remotes/origin &&
-		test "$(git config remote.origin.url)" = "$origin_url" &&
-		cat >push_expected <<-\EOF &&
-		refs/heads/master:refs/heads/upstream
-		refs/heads/next:refs/heads/upstream2
-		EOF
-		cat >fetch_expected <<-\EOF &&
-		refs/heads/master:refs/heads/origin
-		refs/heads/next:refs/heads/origin2
-		EOF
-		git config --get-all remote.origin.push >push_actual &&
-		git config --get-all remote.origin.fetch >fetch_actual &&
-		test_cmp push_expected push_actual &&
-		test_cmp fetch_expected fetch_actual
-	)
-'
-
-test_expect_success 'migrate a remote from named file in $GIT_DIR/branches' '
-	git clone one six &&
-	origin_url=$(pwd)/one &&
-	(
-		cd six &&
-		git remote rm origin &&
-		mkdir -p .git/branches &&
-		echo "$origin_url" >.git/branches/origin &&
-		git remote rename origin origin &&
-		test_path_is_missing .git/branches/origin &&
-		test "$(git config remote.origin.url)" = "$origin_url" &&
-		test "$(git config remote.origin.fetch)" = "refs/heads/master:refs/heads/origin" &&
-		test "$(git config remote.origin.push)" = "HEAD:refs/heads/master"
-	)
-'
-
-test_expect_success 'migrate a remote from named file in $GIT_DIR/branches (2)' '
-	git clone one seven &&
-	(
-		cd seven &&
-		git remote rm origin &&
-		mkdir .git/branches &&
-		echo "quux#foom" > .git/branches/origin &&
-		git remote rename origin origin &&
-		test_path_is_missing .git/branches/origin &&
-		test "$(git config remote.origin.url)" = "quux" &&
-		test "$(git config remote.origin.fetch)" = "refs/heads/foom:refs/heads/origin"
-		test "$(git config remote.origin.push)" = "HEAD:refs/heads/foom"
-	)
-'
-
 test_expect_success 'remote prune to cause a dangling symref' '
 	git clone one eight &&
 	(
-- 
2.12.2.windows.2.800.gede8f145e06


