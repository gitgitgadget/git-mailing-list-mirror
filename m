Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E965020C11
	for <e@80x24.org>; Sun,  3 Dec 2017 21:29:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752689AbdLCV32 (ORCPT <rfc822;e@80x24.org>);
        Sun, 3 Dec 2017 16:29:28 -0500
Received: from mout.gmx.net ([212.227.17.20]:54727 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751557AbdLCV31 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Dec 2017 16:29:27 -0500
Received: from bedhanger.strangled.net ([188.193.86.106]) by mail.gmx.com
 (mrgmx101 [212.227.17.168]) with ESMTPSA (Nemesis) id
 0Lv9lm-1f4Bzq1dkg-010Nia; Sun, 03 Dec 2017 22:28:52 +0100
From:   Ann T Ropea <bedhanger@gmx.de>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Philip Oakley <philipoakley@iee.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Git Mailing List <git@vger.kernel.org>,
        Daniel Barkalow <barkalow@iabervon.org>,
        Ann T Ropea <bedhanger@gmx.de>
Subject: Re: [PATCH v5 4/7] checkout: describe_detached_head: remove ellipsis after committish
Date:   Sun,  3 Dec 2017 22:27:40 +0100
Message-Id: <20171203212743.10228-4-bedhanger@gmx.de>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20171203212743.10228-1-bedhanger@gmx.de>
References: <20171203212743.10228-1-bedhanger@gmx.de>
References: <20171119184113.16630-1-bedhanger@gmx.de> <20171113223654.27732-1-bedhanger@gmx.de> <83D263E58ABD46188756D41FE311E469@PhilipOakley> <xmqqfu9pmsx3.fsf@gitster.mtv.corp.google.com> <20171113223654.27732-3-bedhanger@gmx.de> <xmqq1sl17e1u.fsf@gitster.mtv.corp.google.com> <20171119184113.16630-5-bedhanger@gmx.de> <xmqqzi7hlhkx.fsf@gitster.mtv.corp.google.com> <5AE7AD53CF184A27BF8F484D415083D9@PhilipOakley> <xmqqo9nuuadm.fsf@gitster.mtv.corp.google.com> <FDCFD8EC7A754412A6369F03E91926C5@PhilipOakley> <CAPig+cT-r0uLLv_GyTRddPe=ATX883S1jt-8gc=ANZW21S81Mg@mail.gmail.com> <CAPig+cT4MvjLDvFEB6hJOSip=dqkp10ydnpfnoUabK=53OmQkw@mail.gmail.com> <20171124235330.15157-1-bedhanger@gmx.de> <xmqq4lpjkl4g.fsf@gitster.mtv.corp.google.com> <xmqqd145k9td.fsf@gitster.mtv.corp.google.com>
In-Reply-To: <xmqqd145k9td.fsf@gitster.mtv.corp.google.com>
X-Provags-ID: V03:K0:4jNfLBFSD1UsYCHKM3/Z6hHJZWWEiMLYqN9ypmnUkwVKRuiDh7v
 WJj4ZlBRUZzKOX0MJq992fTQ3GaA6aZSBGQeTf5Fwywj5NLnT6krgtv8K5QwH3q2IoPU7se
 NpB3my9dvb0JE06g8ONaHhogg/cd6dJIzkAT98avRI7cNl5YxfK6iXL2Bp14jGbwAdGG5yW
 eDcPlt7Fg2uYASF2a+3hA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:gTxz9XE3Ly4=:WbrkDfsCDrPJzkZpJNqk4+
 9PkBI9N/aAaYc3RtxvdC/+h4U5dbK2p98E4tBPet0YxOMWTf0KupI0l1fAmCB5UHFlkYLdvA+
 aZbuFl3vyMc5zT9F87Qwt/zzvXjSU7rKU04Aky6lXBDsE+TSUrcVKD2kmF6pN14nfv3pOFBs5
 MQmpf0VYhDgz2b6RaUn54N09kjmZXCDdtioAhqKESkeEG7lFlSeHLD720AmJBlQWduQrcD5Dv
 c6xoFMu4rCVFfEpDPfjnsDcLStAsMmHnoO5JAph0kXC9W41GCyVQSEO1CQDdEsK3uckugWwS2
 /aEHS4iesMhUkofPtB8qzmacZwt08sVTaU+KdExFhCLH8JUuAlRVctnRqUZFmRdGKlEqkpsD4
 pLYaliE9ZrbKQTDejhWSy5fkuJ0PMGZYrRKnt2mAP1muOj7LDNKR85nT3LoKBkvbq8NFyt9Ce
 jfxcy67/Mwwu2srvL4B/g+GftkwUpy4WNNaDqqsXX2l7Wkt1QH6XX4EeKwDAdu9pxjui9Xdz6
 Frra46qFy6nj5Orthx4LrWWNJalc+9KIOWYBNKicQH6jeEKVZ4WhfTIq/fO67K80bQS6UIwGl
 NCxTzwpna72Isfsli47cr9EvyxgzWR/TeT57m2CycmnD9Ihu8ImdyTZPJDow9BdN8lba58Haz
 HWt+F1ArpUn5RlM1CY+LmcYHyHlCyJFN8pxldN2CPNgMSa/i2nfwBh5dfJSdSro8m0HctCaQ0
 ARdAWBCYnohBhSIYDQLC23E0HdRaM/MDq+095B07KbAgLc9ooQwgMQh1f/FTbiA78dUAC97Cg
 lvcsY+Es2KFfzZet7MdYgtnEvuKng==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We do not want an ellipsis displayed following an (abbreviated) SHA-1
value.

The days when this was necessary to indicate the truncation to
lower-level Git commands and/or the user are bygone.

However, to ease the transition, the ellipsis will still be printed if
the user sets the environment variable GIT_PRINT_SHA1_ELLIPSIS to "yes".

Correct documentation with respect to what describe_detached_head prints
when GIT_PRINT_SHA1_ELLIPSIS is not set as indicated above.

Add tests for the old and new behaviour.

Signed-off-by: Ann T Ropea <bedhanger@gmx.de>
---
v2: rename patch series & focus on removal of ellipses
v3: env var instead of config option, use one-line comments where appropriate, preserve indent level
v4: improve env var handling (rename, helper func to query, docu)
v5: rewrite series to take Junio's comments in <xmqqd145k9td.fsf@gitster.mtv.corp.google.com> aboard
 Documentation/user-manual.txt |   2 +-
 builtin/checkout.c            |  10 +++-
 t/t2020-checkout-detach.sh    | 106 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 115 insertions(+), 3 deletions(-)

diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index 497e82e88dd0..eff78902742a 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -319,7 +319,7 @@ do so (now or later) by using -b with the checkout command again. Example:
 
   git checkout -b new_branch_name
 
-HEAD is now at 427abfa... Linux v2.6.17
+HEAD is now at 427abfa Linux v2.6.17
 ------------------------------------------------
 
 The HEAD then refers to the SHA-1 of the commit instead of to a branch,
diff --git a/builtin/checkout.c b/builtin/checkout.c
index 3faae382de4f..b0499542158f 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -400,10 +400,16 @@ static void show_local_changes(struct object *head,
 static void describe_detached_head(const char *msg, struct commit *commit)
 {
 	struct strbuf sb = STRBUF_INIT;
+
 	if (!parse_commit(commit))
 		pp_commit_easy(CMIT_FMT_ONELINE, commit, &sb);
-	fprintf(stderr, "%s %s... %s\n", msg,
-		find_unique_abbrev(commit->object.oid.hash, DEFAULT_ABBREV), sb.buf);
+	if (print_sha1_ellipsis()) {
+		fprintf(stderr, "%s %s... %s\n", msg,
+			find_unique_abbrev(commit->object.oid.hash, DEFAULT_ABBREV), sb.buf);
+	} else {
+		fprintf(stderr, "%s %s %s\n", msg,
+			find_unique_abbrev(commit->object.oid.hash, DEFAULT_ABBREV), sb.buf);
+	}
 	strbuf_release(&sb);
 }
 
diff --git a/t/t2020-checkout-detach.sh b/t/t2020-checkout-detach.sh
index fbb4ee9bb42d..9d42e38ed905 100755
--- a/t/t2020-checkout-detach.sh
+++ b/t/t2020-checkout-detach.sh
@@ -186,4 +186,110 @@ test_expect_success 'no advice given for explicit detached head state' '
 	test_cmp expect.no-advice actual
 '
 
+# Detached HEAD tests for GIT_PRINT_SHA1_ELLIPSIS
+
+# The first detach operation is more chatty than the following ones.
+cat > 1st_detach <<'EOF'
+Note: checking out 'HEAD^'.
+
+You are in 'detached HEAD' state. You can look around, make experimental
+changes and commit them, and you can discard any commits you make in this
+state without impacting any branches by performing another checkout.
+
+If you want to create a new branch to retain commits you create, you may
+do so (now or later) by using -b with the checkout command again. Example:
+
+  git checkout -b <new-branch-name>
+
+HEAD is now at 7c7cd714e262 three
+EOF
+# The remaining ones just show info about previous and current HEADs.
+cat > 2nd_detach <<'EOF'
+Previous HEAD position was 7c7cd714e262 three
+HEAD is now at 139b20d8e6c5 two
+EOF
+cat > 3rd_detach <<'EOF'
+Previous HEAD position was 139b20d8e6c5 two
+HEAD is now at d79ce1670bdc one
+EOF
+test_expect_success 'describe_detached_head prints no SHA-1 ellipsis when not asked to' '
+	reset && check_not_detached && unset GIT_PRINT_SHA1_ELLIPSIS &&
+
+	# Various ways of *not* asking for ellipses
+
+	unset GIT_PRINT_SHA1_ELLIPSIS && git -c 'core.abbrev=12' checkout HEAD^ 1> actual 2>&1 &&
+	check_detached &&
+	test_cmp 1st_detach actual && unset GIT_PRINT_SHA1_ELLIPSIS &&
+
+	GIT_PRINT_SHA1_ELLIPSIS="no" git -c 'core.abbrev=12' checkout HEAD^ 1> actual 2>&1 &&
+	check_detached &&
+	test_cmp 2nd_detach actual && unset GIT_PRINT_SHA1_ELLIPSIS &&
+
+	GIT_PRINT_SHA1_ELLIPSIS= git -c 'core.abbrev=12' checkout HEAD^ 1> actual 2>&1 &&
+	check_detached &&
+	test_cmp 3rd_detach actual && unset GIT_PRINT_SHA1_ELLIPSIS &&
+
+	# We only have four commits, but we can re-use them
+	reset && check_not_detached && unset GIT_PRINT_SHA1_ELLIPSIS &&
+
+	# Make no mention of the env var at all
+	git -c 'core.abbrev=12' checkout HEAD^ 1> actual 2>&1 &&
+	check_detached &&
+	test_cmp 1st_detach actual && unset GIT_PRINT_SHA1_ELLIPSIS &&
+
+	GIT_PRINT_SHA1_ELLIPSIS='nope' && export GIT_PRINT_SHA1_ELLIPSIS && git -c 'core.abbrev=12' checkout HEAD^ 1> actual 2>&1 &&
+	check_detached &&
+	test_cmp 2nd_detach actual && unset GIT_PRINT_SHA1_ELLIPSIS &&
+
+	GIT_PRINT_SHA1_ELLIPSIS=nein && export GIT_PRINT_SHA1_ELLIPSIS && git -c 'core.abbrev=12' checkout HEAD^ 1> actual 2>&1 &&
+	check_detached &&
+	test_cmp 3rd_detach actual && unset GIT_PRINT_SHA1_ELLIPSIS &&
+
+	true
+'
+
+# The first detach operation is more chatty than the following ones.
+cat > 1st_detach <<'EOF'
+Note: checking out 'HEAD^'.
+
+You are in 'detached HEAD' state. You can look around, make experimental
+changes and commit them, and you can discard any commits you make in this
+state without impacting any branches by performing another checkout.
+
+If you want to create a new branch to retain commits you create, you may
+do so (now or later) by using -b with the checkout command again. Example:
+
+  git checkout -b <new-branch-name>
+
+HEAD is now at 7c7cd714e262... three
+EOF
+# The remaining ones just show info about previous and current HEADs.
+cat > 2nd_detach <<'EOF'
+Previous HEAD position was 7c7cd714e262... three
+HEAD is now at 139b20d8e6c5... two
+EOF
+cat > 3rd_detach <<'EOF'
+Previous HEAD position was 139b20d8e6c5... two
+HEAD is now at d79ce1670bdc... one
+EOF
+test_expect_success 'describe_detached_head does print SHA-1 ellipsis when asked to' '
+	reset && check_not_detached && unset GIT_PRINT_SHA1_ELLIPSIS &&
+
+	# Various ways of asking for ellipses...
+
+	GIT_PRINT_SHA1_ELLIPSIS="yes" && export GIT_PRINT_SHA1_ELLIPSIS && git -c 'core.abbrev=12' checkout HEAD^ 1> actual 2>&1 &&
+	check_detached &&
+	test_cmp 1st_detach actual && unset GIT_PRINT_SHA1_ELLIPSIS &&
+
+	GIT_PRINT_SHA1_ELLIPSIS='yes' git -c 'core.abbrev=12' checkout HEAD^ 1> actual 2>&1 &&
+	check_detached &&
+	test_cmp 2nd_detach actual && unset GIT_PRINT_SHA1_ELLIPSIS &&
+
+	GIT_PRINT_SHA1_ELLIPSIS=yes git -c 'core.abbrev=12' checkout HEAD^ 1> actual 2>&1 &&
+	check_detached &&
+	test_cmp 3rd_detach actual && unset GIT_PRINT_SHA1_ELLIPSIS &&
+
+	true
+'
+
 test_done
-- 
2.13.6

