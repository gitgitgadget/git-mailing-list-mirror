Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_WEB,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3E08020357
	for <e@80x24.org>; Fri, 14 Jul 2017 14:45:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754424AbdGNOpF (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Jul 2017 10:45:05 -0400
Received: from mout.gmx.net ([212.227.17.20]:60455 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754076AbdGNOpE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Jul 2017 10:45:04 -0400
Received: from virtualbox ([37.201.192.198]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LevUh-1e0Qhe1Kd5-00qiph; Fri, 14
 Jul 2017 16:44:53 +0200
Date:   Fri, 14 Jul 2017 16:44:38 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Philip Oakley <philipoakley@iee.org>,
        Jeff King <peff@peff.net>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Liam Beguin <liambeguin@gmail.com>
Subject: [PATCH v6 01/10] t3415: verify that an empty instructionFormat is
 handled as before
In-Reply-To: <cover.1500043436.git.johannes.schindelin@gmx.de>
Message-ID: <52e711346eba2fca30225da1d4f42cb17f7ee08b.1500043437.git.johannes.schindelin@gmx.de>
References: <cover.1500043436.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:Jf6PoMQOYQRSj2hBYknTvYv/dmxPj6UcGc+aqivgWOcth+YiX6k
 TS6jm8X0M9VrvqS7XICb71n80mqichujR9KowdLGWL0mMAQaNE3HFlc/LsXdKMH2gBU62Nd
 YypDpIZoKeZLf1mxpp3X4HgC5Q1qRP8dJLJdq9jKXgGlObMzU9BL0cd6LWj49IGgjUOXe21
 SpJuEe+QsOQSZ3tgaFrNw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:uMaEebz2sG8=:AqXu1cX75/dwyIG5ZcKzMN
 8nXfYME9l+jyutYpFGjaH1dcO4DLz3zR4t5t01M3EWsbIqi7jcH+wExJDT/03YJum0E7mT2yN
 Qxix+lSPVxkFNAXfNdlKBhbLiPa4lMawSeW1Pcy8NvwBVV2znroQzbCog1EQrbpHDPfsM3WZz
 Fd99cApU7TEJqMqLVxiuzhpjcdJwPk42AQxI5F6+Bc3rn4V8hmONBJMv5wQ65AkFgSFdbCBsm
 X1k/1090tf0akLgehCSVQ7k5B+tTyr38WeqkGmBwzwOcDW/yKXt7ubRXB0RQFZtBbic1tjrRl
 BeDKCiLRRYySq/kswTuMJVJxg/TnHI2UL63sizqsP4MkVMpibZXHAe6c3FLt8qZyydllHE2nf
 zcQHA1nyS/sY5/F4RKc3tTz8hUyX4kL+zMy4nrKSi+5cRHfR6gxmgrV9d6IVsN7g8UOPMjPLx
 IVmSUIB1jNBIwXW8rV592ghAKksvdDFliokpYX8DfgGtn6GZqjxMRbI0Zwm8hFGZi2CuqLAw6
 dgGLBX676mDVNHI6nYs82IE7KlJBy+Tt//p5jQGX+uqgsBLvsCJcQl0vBIeCo04sCgeJ5p2lA
 8E7qomQzC31HClOoW8AwX0E++qieGk67vcylUOuql5DN5RfeMPUjpb7PN4OVORb8C5mKC2gIM
 hj/zpv6iIJz7tkiZlL+ByRGRr8wK0LXJnQeMvkE9NN65OwzQiWUSwoFTpctHcQ/aspWsGXmWD
 heCzvwp46zfyZUJ6iwewwr6zdOAI+k4rx9y7hpsY680Tf0h7jB+tmkFfLTYaAf/dVt3s1i4Ua
 N4HnLZ1jh1Y/vxfRxcA2mSn4Fxar2DaCDDIyeVE5AUpctNOyr8=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

An upcoming patch will move the todo list generation into the
rebase--helper. An early version of that patch regressed on an empty
rebase.instructionFormat value (the shell version could not discern
between an empty one and a non-existing one, but the C version used the
empty one as if that was intended to skip the oneline from the `pick
<hash>` lines).

Let's verify that this still works as before.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t3415-rebase-autosquash.sh | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/t/t3415-rebase-autosquash.sh b/t/t3415-rebase-autosquash.sh
index 5848949ec37..6d99f624b62 100755
--- a/t/t3415-rebase-autosquash.sh
+++ b/t/t3415-rebase-autosquash.sh
@@ -271,6 +271,18 @@ test_expect_success C_LOCALE_OUTPUT 'autosquash with custom inst format' '
 	test 2 = $(git cat-file commit HEAD^ | grep squash | wc -l)
 '
 
+test_expect_success 'autosquash with empty custom instructionFormat' '
+	git reset --hard base &&
+	test_commit empty-instructionFormat-test &&
+	(
+		set_cat_todo_editor &&
+		test_must_fail git -c rebase.instructionFormat= \
+			rebase --autosquash  --force -i HEAD^ >actual &&
+		git log -1 --format="pick %h %s" >expect &&
+		test_cmp expect actual
+	)
+'
+
 set_backup_editor () {
 	write_script backup-editor.sh <<-\EOF
 	cp "$1" .git/backup-"$(basename "$1")"
-- 
2.13.3.windows.1.13.gaf0c2223da0


