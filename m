Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 00E52202A0
	for <e@80x24.org>; Sun, 19 Nov 2017 18:42:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751020AbdKSSmO (ORCPT <rfc822;e@80x24.org>);
        Sun, 19 Nov 2017 13:42:14 -0500
Received: from mout.gmx.net ([212.227.15.15]:55458 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750952AbdKSSmN (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Nov 2017 13:42:13 -0500
Received: from bedhanger.strangled.net ([188.193.87.84]) by mail.gmx.com
 (mrgmx002 [212.227.17.190]) with ESMTPSA (Nemesis) id
 0LwqwS-1fDhva3dtY-016QJN; Sun, 19 Nov 2017 19:41:34 +0100
From:   Ann T Ropea <bedhanger@gmx.de>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Philip Oakley <philipoakley@iee.org>,
        Git Mailing List <git@vger.kernel.org>,
        Daniel Barkalow <barkalow@iabervon.org>,
        Ann T Ropea <bedhanger@gmx.de>
Subject: Re: [PATCH v3 1/5] checkout: describe_detached_head: remove ellipsis after committish
Date:   Sun, 19 Nov 2017 19:41:09 +0100
Message-Id: <20171119184113.16630-1-bedhanger@gmx.de>
X-Mailer: git-send-email 2.13.6
References: <20171113223654.27732-1-bedhanger@gmx.de> <83D263E58ABD46188756D41FE311E469@PhilipOakley> <xmqqfu9pmsx3.fsf@gitster.mtv.corp.google.com> <20171113223654.27732-3-bedhanger@gmx.de> <xmqq1sl17e1u.fsf@gitster.mtv.corp.google.com>
In-Reply-To: <xmqq1sl17e1u.fsf@gitster.mtv.corp.google.com>
X-Provags-ID: V03:K0:hvqK4mBbHSxvao9k6rEpvcjfMfIj+WNQc/qOO6Ruvb1qehjELLo
 Io8QYWkFjiNRnlM9FaRvGt1jRGIAZSuRFel1I4Njto0TtEYeRlPGjyB/R6X7qAUv20sk+wl
 PJBuantKRUnMY3hjUksTqg8Qs8LQV8lQqwLbomHn5XwNrMGWx1ntaK8MXB/GuvBUSYsEoUw
 Opc7nAom1CcQPzQ+mKd/w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:/Z0TIn950RQ=:ySElpf1L53VPNiTZIi2FgG
 FUc9pciVe7Z/TTxir8Ky97Rfr72ubIKix4VNJe8IIavDLTeNyd7xyBpi1vS6BfzYSz5NZbQP/
 EfDCeORnalGez+9Ze/iAKg/FWcOkS3JLl7cQjGkXjkYdpDJX1wku77AEhy2vrG1nQN6K0vQB8
 vfvRL7JfPNy2ojjLQILNWHy79NvfG7QonjxyXHxtmsG3Bz+wAIjOIZKbSPPnDHx8FB6jfvtCC
 ML/FzrAzLLKL0v3rYyliAub9jGh10c3Sh7BAmSw83+Srs52RQa3gO8USQfIL+YIeEZOrffJJb
 zDw1EFCpFi2Ao5WfUfjtUZN6/0/Spw0BkP54RushlaThfUV+cXH0tY5LzoCsDh9Bw1UK+KgeF
 NAYIM+R7TIXUEEorhfR7vJEbB7KZIsXF17oSqpVyrs79JgSQ3Os7ygOtE1sW9m1PYjFf9lTNO
 SKUpDeKUX7VPs0ywr/yoi/OdToZXfRBKoQdDNMGqjf6T1zRZWxBbFRC++NmZlLlih2BexrotM
 cZnJX+5Ysa1MRO3Gifhnuj0hBTx6U36kojcYM6FMoHK+/PATqkT47x3dF74H96i5x9XXFyAaA
 2eModPLBB5mpxyrEdWleiZ41frJ78kq3jp2vmhN583Zi9mF9s7kRPWemY58QXytR7UnZ52OKo
 3R1mVII+IhclfLRM445AaV08sLzEcy2FmX0X1m34FkJdx7xwl453hyPpk6NnCnxWAPLZEVHxc
 TK8Oy5yuk8Y7GoNCkdLn7M/s0qOeaQCrPXaFKFj8YyfddAyukJi1BsxIhGoZAqa5HSMsNE/1n
 bl+pBFXVFlkYgdGsfNkS065zZv2DA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We do not want an ellipsis displayed following an (abbreviated) SHA-1
value.

The days when this was necessary to indicate the truncation to
lower-level Git commands and/or the user are bygone.

However, to ease the transition, the ellipsis will still be printed if
the user (actively!) sets the environment variable PRINT_SHA1_ELLIPSIS
to "yes" (case does not matter).

The transient nature of this fallback suggests that we should not prefix
the variable by "GIT_".

Signed-off-by: Ann T Ropea <bedhanger@gmx.de>
---
v2: rename patch series & focus on removal of ellipses
v3: env var instead of config option, use one-line comments where appropriate, preserve indent level
 builtin/checkout.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 7d8bcc383351..e6d3a28fe26e 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -400,10 +400,17 @@ static void show_local_changes(struct object *head,
 static void describe_detached_head(const char *msg, struct commit *commit)
 {
 	struct strbuf sb = STRBUF_INIT;
+	const char *env_printsha1ellipsis = getenv("PRINT_SHA1_ELLIPSIS");
+
 	if (!parse_commit(commit))
 		pp_commit_easy(CMIT_FMT_ONELINE, commit, &sb);
-	fprintf(stderr, "%s %s... %s\n", msg,
-		find_unique_abbrev(commit->object.oid.hash, DEFAULT_ABBREV), sb.buf);
+	if (env_printsha1ellipsis && !strcasecmp(env_printsha1ellipsis, "yes")) {
+		fprintf(stderr, "%s %s... %s\n", msg,
+			find_unique_abbrev(commit->object.oid.hash, DEFAULT_ABBREV), sb.buf);
+	} else {
+		fprintf(stderr, "%s %s %s\n", msg,
+			find_unique_abbrev(commit->object.oid.hash, DEFAULT_ABBREV), sb.buf);
+	}
 	strbuf_release(&sb);
 }
 
-- 
2.13.6

