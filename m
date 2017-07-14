Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RCVD_IN_SORBS_WEB,RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F1AF920357
	for <e@80x24.org>; Fri, 14 Jul 2017 14:45:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754529AbdGNOpb (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Jul 2017 10:45:31 -0400
Received: from mout.gmx.net ([212.227.17.22]:53430 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754299AbdGNOp3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Jul 2017 10:45:29 -0400
Received: from virtualbox ([37.201.192.198]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MDm4o-1dR5sb2lyA-00H7nP; Fri, 14
 Jul 2017 16:45:15 +0200
Date:   Fri, 14 Jul 2017 16:45:14 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Philip Oakley <philipoakley@iee.org>,
        Jeff King <peff@peff.net>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Liam Beguin <liambeguin@gmail.com>
Subject: [PATCH v6 06/10] t3404: relax rebase.missingCommitsCheck tests
In-Reply-To: <cover.1500043436.git.johannes.schindelin@gmx.de>
Message-ID: <47d54a53ad8b5efdb74e0e8624f2740d6ae84c2c.1500043437.git.johannes.schindelin@gmx.de>
References: <cover.1500043436.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:Wc/rAlFXm4VB0PwhFP5/v7rxi7Y1eOwNB8v9a5pk2yLP8dEV5qi
 RoQuHUDVGLyx0a5X8bKrg717d5ArOBkO+OiVsTE9+1HmcZmThBt+zVAwfI82NMTN6jSJNFs
 PsOFmNqOEGyeitgkxyjosFgQwLjhLMmuWDNxVK2cBAx992INOP52fEA4x7NaKbjoOd4DuJU
 aZ0uYS8TOut2ilSQG/jWg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:59WEEZxXG7k=:1a+xRszzQF5gjNQauwHC+P
 USq0ODNFC2YtsCoyL67Rgg7daseIgjjnw5l8RQ9JE4h6+l7KYtDDPLYViAlaW85+YQVxapAXl
 mmHohg5w1GJ83Ay9NQqsXe4ucPXDrygkX9Bx/lBeksgld7UsOAq/+JvV88R2ElMPZmppf0FUt
 JE8cR9+WRC6RPNRPn+3S0r08yXDlFfHFq02Iy6CY3+r0CnD6Cfjo912rLh8JZWUv1BncaY8UL
 7jZbLChkeSqL9XuGvD85uDR1Xqu3nCIvUh6rjJYRsq+EQqE2fQFRYc29shGteCdgZ7tJ9QamM
 S5Dx8spU7WuMtZQ+/g0pCs+JIegQu0x8k0lhfm3z6Q6DdXH9Ea2qKYknsYFKraD47yeHtSjFk
 NYVJoM8zCoJzwh8TsdBQJCTbuPppkSKOG+gol8s+forj8DPVpM6XkTF65oHi0ukZnAzEuucSz
 XiyjzMdCqMI6dnSCm35MhVDy3fnX7xF9Rgw+m9md5PgSKz2B0vGM+HiUSInuOfQUfF/ut+GNn
 3o/FXIjTbGwQxcEUkaCcfEcxfUhktVFj6xrE20faOJnpqdq+gEN8jf3Mu3yuFucM5wxqYJtPo
 OpZYIulYJZq/OpUbylPAjlgbGSZOqwsvlJHIZqmzO4BShGM8p9lLS3LohA0HqZOHwhzLjnjLV
 kAuWEqynsrulbujgpf9c17GILXkKenmwpyrlJq5JjIMA8BdJz7F6kIjwoTakPYCyiKqXRAOnh
 MU5c+ppqS993xvyYNAOxV9DXiraQ4oSOpJNz7o1Ku/2qu7JThsBTAnyeMFwrhp5zLQhbm65zr
 gvdK/K/z4EntqUMnC2ogXYaOT52hBL3+gA8DMLpq+1BFy5+aeA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

These tests were a bit anal about the *exact* warning/error message
printed by git rebase. But those messages are intended for the *end
user*, therefore it does not make sense to test so rigidly for the
*exact* wording.

In the following, we will reimplement the missing commits check in
the sequencer, with slightly different words.

So let's just test for the parts in the warning/error message that
we *really* care about, nothing more, nothing less.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t3404-rebase-interactive.sh | 22 ++++------------------
 1 file changed, 4 insertions(+), 18 deletions(-)

diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index 37821d24543..3704dbb2ecf 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -1249,20 +1249,13 @@ test_expect_success 'rebase -i respects rebase.missingCommitsCheck = error' '
 	test B = $(git cat-file commit HEAD^ | sed -ne \$p)
 '
 
-cat >expect <<EOF
-Warning: the command isn't recognized in the following line:
- - badcmd $(git rev-list --oneline -1 master~1)
-
-You can fix this with 'git rebase --edit-todo' and then run 'git rebase --continue'.
-Or you can abort the rebase with 'git rebase --abort'.
-EOF
-
 test_expect_success 'static check of bad command' '
 	rebase_setup_and_clean bad-cmd &&
 	set_fake_editor &&
 	test_must_fail env FAKE_LINES="1 2 3 bad 4 5" \
 		git rebase -i --root 2>actual &&
-	test_i18ncmp expect actual &&
+	test_i18ngrep "badcmd $(git rev-list --oneline -1 master~1)" actual &&
+	test_i18ngrep "You can fix this with .git rebase --edit-todo.." actual &&
 	FAKE_LINES="1 2 3 drop 4 5" git rebase --edit-todo &&
 	git rebase --continue &&
 	test E = $(git cat-file commit HEAD | sed -ne \$p) &&
@@ -1284,20 +1277,13 @@ test_expect_success 'tabs and spaces are accepted in the todolist' '
 	test E = $(git cat-file commit HEAD | sed -ne \$p)
 '
 
-cat >expect <<EOF
-Warning: the SHA-1 is missing or isn't a commit in the following line:
- - edit XXXXXXX False commit
-
-You can fix this with 'git rebase --edit-todo' and then run 'git rebase --continue'.
-Or you can abort the rebase with 'git rebase --abort'.
-EOF
-
 test_expect_success 'static check of bad SHA-1' '
 	rebase_setup_and_clean bad-sha &&
 	set_fake_editor &&
 	test_must_fail env FAKE_LINES="1 2 edit fakesha 3 4 5 #" \
 		git rebase -i --root 2>actual &&
-	test_i18ncmp expect actual &&
+	test_i18ngrep "edit XXXXXXX False commit" actual &&
+	test_i18ngrep "You can fix this with .git rebase --edit-todo.." actual &&
 	FAKE_LINES="1 2 4 5 6" git rebase --edit-todo &&
 	git rebase --continue &&
 	test E = $(git cat-file commit HEAD | sed -ne \$p)
-- 
2.13.3.windows.1.13.gaf0c2223da0


