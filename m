Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E576C202A0
	for <e@80x24.org>; Sun, 19 Nov 2017 18:42:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751015AbdKSSmO (ORCPT <rfc822;e@80x24.org>);
        Sun, 19 Nov 2017 13:42:14 -0500
Received: from mout.gmx.net ([212.227.15.15]:58767 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750954AbdKSSmM (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Nov 2017 13:42:12 -0500
Received: from bedhanger.strangled.net ([188.193.87.84]) by mail.gmx.com
 (mrgmx001 [212.227.17.190]) with ESMTPSA (Nemesis) id
 0M39zL-1f8Srn3K2J-00stPo; Sun, 19 Nov 2017 19:41:37 +0100
From:   Ann T Ropea <bedhanger@gmx.de>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Philip Oakley <philipoakley@iee.org>,
        Git Mailing List <git@vger.kernel.org>,
        Daniel Barkalow <barkalow@iabervon.org>,
        Ann T Ropea <bedhanger@gmx.de>
Subject: Re: [PATCH v3 2/5] diff: diff_aligned_abbrev: remove ellipsis after abbreviated SHA-1 value
Date:   Sun, 19 Nov 2017 19:41:10 +0100
Message-Id: <20171119184113.16630-2-bedhanger@gmx.de>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20171119184113.16630-1-bedhanger@gmx.de>
References: <20171119184113.16630-1-bedhanger@gmx.de>
References: <20171113223654.27732-1-bedhanger@gmx.de> <83D263E58ABD46188756D41FE311E469@PhilipOakley> <xmqqfu9pmsx3.fsf@gitster.mtv.corp.google.com> <20171113223654.27732-3-bedhanger@gmx.de> <xmqq1sl17e1u.fsf@gitster.mtv.corp.google.com>
In-Reply-To: <xmqq1sl17e1u.fsf@gitster.mtv.corp.google.com>
X-Provags-ID: V03:K0:vOJ1jK17ODqjQs2tR69M6z8+j/hQJ1hXWtixBfpGPxlvsJtXCQh
 sx7Fs7JB+SXTCaFxRkxbK+heE9lmv3RbOqRwUtVK8PRVGFJ3hasS2FzcqmhlvpmVecWr3TS
 9cFqnQNUJZDY318XTrPDz6H2L6Jq4xh7UGEaO08pKxVD/2sAzTPdNd/HKT0ArTiCmG38Xud
 lfsjEKQ5h13sinwO+2kGQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:6maK5NQknV4=:OUFoDTUB70EH5/v1ufg1Sj
 8hA2ivLi4Jisl3C2WOiiGEURswuOtGFnZmr5W3RPJMX4Hbt45Q6Qsr8JQnVvfaoH0tRkneVBj
 WKVgA5O/sY96a/+HPJhaK1zNjuVkp3BCwDv4ceHhEcTfHArtr8ierGFTk1RM90Y2eCsMJWdJE
 a4ZdykqDlSuBaT3bFDKQ+jt63CL7yc+82t+ShUxLapsnBT7/U2sCwoDl652Jr//CkyrY8d5EM
 7Vtmuto2U7fxRFA1hVEifrRU4PY+5DD80SW0ZiucISi8NzTithgFq5Tcin38XKocpKkP4MWwK
 lo3NWe1I962D6KcdeDRG4welM54orhG/jiSJRovPxRxluYb05/eujQbJsBYfK/O3d7WKA2L80
 iv8moI+ZAOPpj9ArqQjV6K1lXXQtI0D3VkzMmo9dJ64A6TqSATdpATDI05u3uDDN6tuBWMiwY
 X22i99seUEmxKTXSpGQr3HlJl84f0r0DM2hySPbTrlcX/ci0Ic8O7rBv2V3orcjBX9Q9wNhjz
 /mg6obmma2/NGSTiGZyEtKOa3s9lIkCCmCG1JaG0FYqmXUbBt/Db9flSq3EJmaOc7dUFraoTg
 dGGkt0My4zK/YtbuuO3himaE6FegKFdn2g+82eIV3jUqE/E03VnvCR4VJTkwGxi4b9cpRf8Hz
 /A9tQuUays9vviBWQPQLzphg1vwqe1a1/4Dl57XHmgEbPQ+ljFzn9l4kTH1QkBycPDCbob2iP
 hNFVu/hx2Ckk1yGhIYg9O3aNQLyH22LxGHhli1EDZLYFtrGyRLcrLGSRMoXkPRa5hYmqgGb0x
 lVJRM8Sof9NOsvIvPpCTLM93VapMg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Neither Git nor the user are in need of this (visual) aid anymore, but
we must offer a transition period.

Also, fix a typo: "abbbreviated" ---> "abbreviated".

Signed-off-by: Ann T Ropea <bedhanger@gmx.de>
---
v2: rename patch series & focus on removal of ellipses
v3: env var instead of config option, use one-line comments where appropriate, preserve indent level
 diff.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/diff.c b/diff.c
index 0763e89263ef..359c6fc85a27 100644
--- a/diff.c
+++ b/diff.c
@@ -4901,15 +4901,22 @@ const char *diff_aligned_abbrev(const struct object_id *oid, int len)
 {
 	int abblen;
 	const char *abbrev;
+	const char *env_printsha1ellipsis = getenv("PRINT_SHA1_ELLIPSIS");
 
+	/* Do we want all 40 hex characters? */
 	if (len == GIT_SHA1_HEXSZ)
 		return oid_to_hex(oid);
 
+	/* An abbreviated value is fine, possibly followed by an ellipsis. */
 	abbrev = diff_abbrev_oid(oid, len);
+
+	if (!(env_printsha1ellipsis && !strcasecmp(env_printsha1ellipsis, "yes")))
+		return abbrev;
+
 	abblen = strlen(abbrev);
 
 	/*
-	 * In well-behaved cases, where the abbbreviated result is the
+	 * In well-behaved cases, where the abbreviated result is the
 	 * same as the requested length, append three dots after the
 	 * abbreviation (hence the whole logic is limited to the case
 	 * where abblen < 37); when the actual abbreviated result is a
-- 
2.13.6

