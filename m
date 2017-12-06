Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8971C20A40
	for <e@80x24.org>; Wed,  6 Dec 2017 00:22:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753116AbdLFAWQ (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Dec 2017 19:22:16 -0500
Received: from mout.gmx.net ([212.227.15.18]:59078 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752929AbdLFAWP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Dec 2017 19:22:15 -0500
Received: from bedhanger.strangled.net ([188.193.86.106]) by mail.gmx.com
 (mrgmx002 [212.227.17.190]) with ESMTPSA (Nemesis) id
 0MN0jA-1eSx2X0YZM-006ebe; Wed, 06 Dec 2017 01:21:37 +0100
From:   Ann T Ropea <bedhanger@gmx.de>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Philip Oakley <philipoakley@iee.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Git Mailing List <git@vger.kernel.org>,
        Daniel Barkalow <barkalow@iabervon.org>,
        Ann T Ropea <bedhanger@gmx.de>
Subject: Re: [PATCH v7 4/7] checkout: describe_detached_head: remove ellipsis after committish
Date:   Wed,  6 Dec 2017 01:20:42 +0100
Message-Id: <20171206002042.18863-1-bedhanger@gmx.de>
X-Mailer: git-send-email 2.13.6
References: <20171203212743.10228-1-bedhanger@gmx.de> <20171119184113.16630-1-bedhanger@gmx.de> <20171113223654.27732-1-bedhanger@gmx.de> <83D263E58ABD46188756D41FE311E469@PhilipOakley> <xmqqfu9pmsx3.fsf@gitster.mtv.corp.google.com> <20171113223654.27732-3-bedhanger@gmx.de> <xmqq1sl17e1u.fsf@gitster.mtv.corp.google.com> <20171119184113.16630-5-bedhanger@gmx.de> <xmqqzi7hlhkx.fsf@gitster.mtv.corp.google.com> <5AE7AD53CF184A27BF8F484D415083D9@PhilipOakley> <xmqqo9nuuadm.fsf@gitster.mtv.corp.google.com> <FDCFD8EC7A754412A6369F03E91926C5@PhilipOakley> <CAPig+cT-r0uLLv_GyTRddPe=ATX883S1jt-8gc=ANZW21S81Mg@mail.gmail.com> <CAPig+cT4MvjLDvFEB6hJOSip=dqkp10ydnpfnoUabK=53OmQkw@mail.gmail.com> <20171124235330.15157-1-bedhanger@gmx.de> <xmqq4lpjkl4g.fsf@gitster.mtv.corp.google.com> <xmqqd145k9td.fsf@gitster.mtv.corp.google.com> <20171203212743.10228-4-bedhanger@gmx.de> <xmqqshcqmoe7.fsf@gitster.mtv.corp.google.com> <20171204231313.17929-1-bedhanger@gmx.de> <xmqq8tehjh6f.fsf@gitster.mtv.corp.google.com>
In-Reply-To: <xmqq8tehjh6f.fsf@gitster.mtv.corp.google.com>
X-Provags-ID: V03:K0:sDzzBkuiFuBWRzGITA2OcsQZmQdufw90OvDq8PznzskEcLMBFRE
 jGQ/CBW9qXI2v0hDhpG68LY0l/ReiXlYExaMj10/LB7mq4u7HX+nDzRvRngfcZOSopFESkt
 SdBDffOn7HHyyCJ1Vb9nKg7KO+dnTztCMWfLjkFkrSX2VMO6vAaDJxL9zYYdBDXOW6EvZaY
 IxJ7NHMO/Jgb0ikPOSJYw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:6CXoTRFnJvA=:femXTfYPNNqef531ZDj+1y
 mbu1WEZxyLYBshkGQ2eCOp+kyQB67/xzVhLMMLbwOL7lfaAJFS83DW6nrq5MRCmoCEy7hc+nr
 BUuUNJdnNu3JsdGbR70ryMp6IAYvpzHlzUPd5OncsrsdRoYZRyiVGqNhZfiUj3v25JGjodNxp
 q1ChyY4Vlqdf8XRSpasgVqZW6l88xCptNcXShf3kQTTLJedu7wtg15ixKWdWuTq+7AOq5xLvh
 IzNGDFtMRSVW+rchyUHblYLr3d/YXa8KAzkmPSLUzxPcxxJevopusbD/73/fZNWcrkCne7K1L
 RHXMh/zcyzGC9PcQXmGlyivEeImPZIacE4vVsaM45G27zPdT/QSg2e2DQ4c4iGk8YZt0JpFzH
 wc8AFVbut0jf9wMSd+CjwgzNoGxtW24Q7bGNelLoBdW2+sz3eUtq5DCNPwMjZQ+R4lQI8Rlhy
 3qlAR1orboSQ0FqYuamIy4iCfDJCuG/DWcn9e9GUmURHcFlnPtC94xXXYCJl9ks/zLff9Cq5M
 iQghx1leSI1FH9fyEOSeU5GPfLs5caM1JxY8AateEHkSmSD1Na60YdB2lw8VGYeq7cfq+yu7u
 C1kFXfvlViOzY25dpWZTg0S+VEmuqyW1xLsLTq9NeDcYYBQv13FGV3d4mxp9Gu+SPyKLRj8/k
 PogX36ibFtQ/R6sopYivIs6BanwfuvfPhCH6lFkiLJ30MbC9aNqA0pLfccEHb/Pds16iw4F7P
 IDfH1ThGMJOwPgqtsuBmtj9+GGJhzYxB+paacNG84EI3Taav+qqQSiZxyGs8VOurZ0B9vBHMP
 Q65ivQeQZGqKR/Ex5/GqYgEm4aOaA==
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
v6: polish to take Junio's comments from <xmqqshcqmoe7.fsf@gitster.mtv.corp.google.com> into account
v7: fix style issues (redirection, here-dox, long lines, setting/exporting/unsetting of env var): cf. <xmqq8tehjh6f.fsf@gitster.mtv.corp.google.com>
 Documentation/user-manual.txt |   2 +-
 builtin/checkout.c            |  10 +++-
 t/t2020-checkout-detach.sh    | 123 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 132 insertions(+), 3 deletions(-)

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
index fbb4ee9bb42d..e8e284cf9c04 100755
--- a/t/t2020-checkout-detach.sh
+++ b/t/t2020-checkout-detach.sh
@@ -186,4 +186,127 @@ test_expect_success 'no advice given for explicit detached head state' '
 	test_cmp expect.no-advice actual
 '
 
+# Detached HEAD tests for GIT_PRINT_SHA1_ELLIPSIS (new format)
+test_expect_success 'describe_detached_head prints no SHA-1 ellipsis when not asked to' "
+
+	# The first detach operation is more chatty than the following ones.
+	cat >1st_detach <<-'EOF' &&
+	Note: checking out 'HEAD^'.
+
+	You are in 'detached HEAD' state. You can look around, make experimental
+	changes and commit them, and you can discard any commits you make in this
+	state without impacting any branches by performing another checkout.
+
+	If you want to create a new branch to retain commits you create, you may
+	do so (now or later) by using -b with the checkout command again. Example:
+
+	  git checkout -b <new-branch-name>
+
+	HEAD is now at 7c7cd714e262 three
+	EOF
+
+	# The remaining ones just show info about previous and current HEADs.
+	cat >2nd_detach <<-'EOF' &&
+	Previous HEAD position was 7c7cd714e262 three
+	HEAD is now at 139b20d8e6c5 two
+	EOF
+
+	cat >3rd_detach <<-'EOF' &&
+	Previous HEAD position was 139b20d8e6c5 two
+	HEAD is now at d79ce1670bdc one
+	EOF
+
+	reset &&
+	check_not_detached &&
+
+	# Various ways of *not* asking for ellipses
+
+	sane_unset GIT_PRINT_SHA1_ELLIPSIS &&
+	git -c 'core.abbrev=12' checkout HEAD^ >actual 2>&1 &&
+	check_detached &&
+	test_i18ncmp 1st_detach actual &&
+
+	GIT_PRINT_SHA1_ELLIPSIS="no" git -c 'core.abbrev=12' checkout HEAD^ >actual 2>&1 &&
+	check_detached &&
+	test_i18ncmp 2nd_detach actual &&
+
+	GIT_PRINT_SHA1_ELLIPSIS= git -c 'core.abbrev=12' checkout HEAD^ >actual 2>&1 &&
+	check_detached &&
+	test_i18ncmp 3rd_detach actual &&
+
+	sane_unset GIT_PRINT_SHA1_ELLIPSIS &&
+
+	# We only have four commits, but we can re-use them
+	reset &&
+	check_not_detached &&
+
+	# Make no mention of the env var at all
+	git -c 'core.abbrev=12' checkout HEAD^ >actual 2>&1 &&
+	check_detached &&
+	test_i18ncmp 1st_detach actual &&
+
+	GIT_PRINT_SHA1_ELLIPSIS='nope' &&
+	git -c 'core.abbrev=12' checkout HEAD^ >actual 2>&1 &&
+	check_detached &&
+	test_i18ncmp 2nd_detach actual &&
+
+	GIT_PRINT_SHA1_ELLIPSIS=nein &&
+	git -c 'core.abbrev=12' checkout HEAD^ >actual 2>&1 &&
+	check_detached &&
+	test_i18ncmp 3rd_detach actual &&
+
+	true
+"
+
+# Detached HEAD tests for GIT_PRINT_SHA1_ELLIPSIS (old format)
+test_expect_success 'describe_detached_head does print SHA-1 ellipsis when asked to' "
+
+	# The first detach operation is more chatty than the following ones.
+	cat >1st_detach <<-'EOF' &&
+	Note: checking out 'HEAD^'.
+	
+	You are in 'detached HEAD' state. You can look around, make experimental
+	changes and commit them, and you can discard any commits you make in this
+	state without impacting any branches by performing another checkout.
+	
+	If you want to create a new branch to retain commits you create, you may
+	do so (now or later) by using -b with the checkout command again. Example:
+	
+	  git checkout -b <new-branch-name>
+	
+	HEAD is now at 7c7cd714e262... three
+	EOF
+
+	# The remaining ones just show info about previous and current HEADs.
+	cat >2nd_detach <<-'EOF' &&
+	Previous HEAD position was 7c7cd714e262... three
+	HEAD is now at 139b20d8e6c5... two
+	EOF
+
+	cat >3rd_detach <<-'EOF' &&
+	Previous HEAD position was 139b20d8e6c5... two
+	HEAD is now at d79ce1670bdc... one
+	EOF
+
+	reset &&
+	check_not_detached &&
+
+	# Various ways of asking for ellipses...
+	# The user can just use any kind of quoting (including none).
+
+	GIT_PRINT_SHA1_ELLIPSIS="yes" git -c 'core.abbrev=12' checkout HEAD^ >actual 2>&1 &&
+	check_detached &&
+	test_i18ncmp 1st_detach actual &&
+
+	GIT_PRINT_SHA1_ELLIPSIS='yes' git -c 'core.abbrev=12' checkout HEAD^ >actual 2>&1 &&
+	check_detached &&
+	test_i18ncmp 2nd_detach actual &&
+
+	GIT_PRINT_SHA1_ELLIPSIS=yes git -c 'core.abbrev=12' checkout HEAD^ >actual 2>&1 &&
+	check_detached &&
+	test_i18ncmp 3rd_detach actual &&
+
+	true
+"
+
 test_done
-- 
2.13.6

