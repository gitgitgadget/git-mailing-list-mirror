Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ED28B2036D
	for <e@80x24.org>; Fri, 24 Nov 2017 23:55:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753874AbdKXXy7 (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Nov 2017 18:54:59 -0500
Received: from mout.gmx.net ([212.227.15.19]:53180 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753862AbdKXXy5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Nov 2017 18:54:57 -0500
Received: from bedhanger.strangled.net ([188.193.86.106]) by mail.gmx.com
 (mrgmx002 [212.227.17.190]) with ESMTPSA (Nemesis) id
 0LanoO-1ey18E34mG-00kL20; Sat, 25 Nov 2017 00:54:18 +0100
From:   Ann T Ropea <bedhanger@gmx.de>
To:     Junio C Hamano <gitster@pobox.com>,
        Philip Oakley <philipoakley@iee.org>,
        Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Daniel Barkalow <barkalow@iabervon.org>,
        Ann T Ropea <bedhanger@gmx.de>
Subject: Re: [PATCH v4 2/6] checkout: describe_detached_head: remove ellipsis after committish
Date:   Sat, 25 Nov 2017 00:53:26 +0100
Message-Id: <20171124235330.15157-2-bedhanger@gmx.de>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20171124235330.15157-1-bedhanger@gmx.de>
References: <20171124235330.15157-1-bedhanger@gmx.de>
References: <20171119184113.16630-1-bedhanger@gmx.de> <20171113223654.27732-1-bedhanger@gmx.de> <83D263E58ABD46188756D41FE311E469@PhilipOakley> <xmqqfu9pmsx3.fsf@gitster.mtv.corp.google.com> <20171113223654.27732-3-bedhanger@gmx.de> <xmqq1sl17e1u.fsf@gitster.mtv.corp.google.com> <20171119184113.16630-5-bedhanger@gmx.de> <xmqqzi7hlhkx.fsf@gitster.mtv.corp.google.com> <5AE7AD53CF184A27BF8F484D415083D9@PhilipOakley> <xmqqo9nuuadm.fsf@gitster.mtv.corp.google.com> <FDCFD8EC7A754412A6369F03E91926C5@PhilipOakley> <CAPig+cT-r0uLLv_GyTRddPe=ATX883S1jt-8gc=ANZW21S81Mg@mail.gmail.com> <CAPig+cT4MvjLDvFEB6hJOSip=dqkp10ydnpfnoUabK=53OmQkw@mail.gmail.com>
In-Reply-To: <xmqqo9nuuadm.fsf@gitster.mtv.corp.google.com>
X-Provags-ID: V03:K0:gzT6NoaOP8392R+ezVz3Pd/gRbAn3mFuC/1vo5rqmutszvUwOlf
 BeMTVL95GrFUvIyM/aRnwiQ8q55XO7sW24LxiDdeViU260iKMRHV4YbeUzWna3DGYCYRA0z
 wjHN7QVxLpepxFbvjWChuBJHxNfxGY7n5P2WClD2KQR1HMz5TfvU3DJczITvhrS/evMvD4u
 tfY5mW9K4gMY9+FdkV0GA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:qHNAmPF/Hgc=:C17IRxco6D6B//JSib/qBG
 3fDGVHBJIVNTNBqBmE6Tq/1KKZiQcvDcd3Rc68G6Qlq9w9dqKl9aPs+EyDScfk5WJX30AO/2r
 YUvRd/fN3NMaUd0L/OVemvWCTydr3mFV/2RNvOrKJoSfmQ2Qzdes4q/Eq2GpfTMG3i7qVodsx
 +5UYeRx4l9/Tu5c4GfXsGJdU11tKjFR8bZWPONRnVAqOQ0s//koCuFJSWkQkJKeuk6yN9G+Nk
 sL29ET9pyTjkVa4F2jvfbPL6HbXajwCnz4AMBAiKywQYKQzO/kfA5NxJNU/LsxBK+Vg+bi3I1
 34pCzNpjy8NNdf1gpH6UADKbfoqxmqnOCyN1sRsl/qRxoMszxyRbrZnFiTkmGleGKU2DmrWU9
 ljGBRFHEbSJ/+JaDMmjTDy3h1kISDHoitsKSQTBqUSJGbGK3HAmnPqv9lEKcybR9cpfT7a1Qi
 X1ARnr9jjW+CY/aifhihTQFzcqnhKnhfs4nlvuM2CTAO0vq+KbuSgL7FwRPLpjlM+32/xn1lU
 LlFfcqx77BAO6mi1BiRJdIC2ciCch91HI31mE6WZ0bUE0J33LJJPZp9t6eH3ldxguacmcGzXH
 MOwk0ZoheKGRfRQ5iQio4sS8JQ8Pu+6GuGh5dvJZXWJJ/TCFxofMDP7HZuwTjTDSLHtbZLbMB
 lCVLW7+yaSwcvActZLCp9+JGaZjzvLoEtYnSXo8O2csDIRUUJ+EybDIaxKiMkru6ZknqcIiCP
 6n+Y8EXexKK5BmdqMC7elhIi6dEFgvhzOCBfYSXw6+1tesDKtZ8dQHiU2Cta7NMQJy3rxhS1J
 +jL4idp0G00eomXRNlnF7G1g2rong==
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

Signed-off-by: Ann T Ropea <bedhanger@gmx.de>
---
v2: rename patch series & focus on removal of ellipses
v3: env var instead of config option, use one-line comments where appropriate, preserve indent level
v4: improve env var handling (rename, helper func to query, docu)
 builtin/checkout.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 7d8bcc383351..d260fb925cac 100644
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
 
-- 
2.13.6

