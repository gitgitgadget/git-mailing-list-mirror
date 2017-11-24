Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6A6972036D
	for <e@80x24.org>; Fri, 24 Nov 2017 23:54:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753818AbdKXXyv (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Nov 2017 18:54:51 -0500
Received: from mout.gmx.net ([212.227.17.20]:55503 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753840AbdKXXyu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Nov 2017 18:54:50 -0500
Received: from bedhanger.strangled.net ([188.193.86.106]) by mail.gmx.com
 (mrgmx103 [212.227.17.168]) with ESMTPSA (Nemesis) id
 0LfC4q-1etbI40Epc-00orpc; Sat, 25 Nov 2017 00:54:12 +0100
From:   Ann T Ropea <bedhanger@gmx.de>
To:     Junio C Hamano <gitster@pobox.com>,
        Philip Oakley <philipoakley@iee.org>,
        Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Daniel Barkalow <barkalow@iabervon.org>,
        Ann T Ropea <bedhanger@gmx.de>
Subject: Re: [PATCH v4 1/6] diff: diff_aligned_abbrev: remove ellipsis after abbreviated SHA-1 value
Date:   Sat, 25 Nov 2017 00:53:25 +0100
Message-Id: <20171124235330.15157-1-bedhanger@gmx.de>
X-Mailer: git-send-email 2.13.6
References: <20171119184113.16630-1-bedhanger@gmx.de> <20171113223654.27732-1-bedhanger@gmx.de> <83D263E58ABD46188756D41FE311E469@PhilipOakley> <xmqqfu9pmsx3.fsf@gitster.mtv.corp.google.com> <20171113223654.27732-3-bedhanger@gmx.de> <xmqq1sl17e1u.fsf@gitster.mtv.corp.google.com> <20171119184113.16630-5-bedhanger@gmx.de> <xmqqzi7hlhkx.fsf@gitster.mtv.corp.google.com> <5AE7AD53CF184A27BF8F484D415083D9@PhilipOakley> <xmqqo9nuuadm.fsf@gitster.mtv.corp.google.com> <FDCFD8EC7A754412A6369F03E91926C5@PhilipOakley> <CAPig+cT-r0uLLv_GyTRddPe=ATX883S1jt-8gc=ANZW21S81Mg@mail.gmail.com> <CAPig+cT4MvjLDvFEB6hJOSip=dqkp10ydnpfnoUabK=53OmQkw@mail.gmail.com>
In-Reply-To: <xmqqo9nuuadm.fsf@gitster.mtv.corp.google.com>
X-Provags-ID: V03:K0:VEAHhOkyPhTy7a/rWUbpX5KRBQrF6ZmJ0abFFgWtuUQMimxFqda
 7JXf7WVYKguhZpqu8MXegUWscTkxxTB05DKinswaqMiCokfbSeDDZCxrdQ05bTiP2swPIdp
 pBs5jSTLaq94blYRmqCy3kTWnRKOFr8JqUCiWmkuTdXVUkIE0xyy5B8GRhvEbuTx4HRFdyH
 cOBj9YjuESm5o/iPgoPSA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:nLQgPHL5vnA=:78wknUJqXurNzwleIjyAII
 n0Af9WZimR7fLLQ1OMDuRmuoMWqz47jBUkr/yYcZYbnvVDYlgbp6O6iFhpWvPLgJnPNRc9g7P
 zMggZwDmP6xABevWpTT07HLi/easBdaQNCNBxnaUVrjiVuN+LyeF32oUKe3/BnlWFcQBF0ELq
 635W4Z6or79x8jbJyrL6QsOY/8/i1w7N+XvgcM+NVudThs9+kHrlYD9mdrlBniEfTh4G5pAp7
 ogjCCjl5NxtZQteTHPpJnpM4cLfwcC8DzZk97ge2nNtYMs9UaGKPQVe2sXBJvb7PIVcjMuxm8
 WZDZaLwW+rQMA9BMEfXjzzFPeTtlk3qK/AV2x5ywRqEhmhfF0YrUkje3ETWvsFlpP9CauetKF
 RluT0zHU5zohlBtT3o+Obb5Tk0J+Xnko4FiceQG6cqZjNZC5RmV0leKiz33XTWgLESzRf1fSJ
 rHs8lH2KIteNnCI3wc+oXK9DphHbp4wHGEMiUB5i1rRVH5/aahKWXAQiRM9RDvoA6f1DL/943
 sUSdgU2xY1vnHemx2UUlRFxKRj28aFF89lBPo+eHIboTACecTi9qKnn2k22BWmFXoCMGr9Fe1
 Pgy+6/uPaMds5oqZYFfsDhB5J9GeMewsf64aqLPcwzPNF7aZEksv+ku1QgC/kMYUed1qn8Zwy
 GgH0M/c31bAerXY3G4J/zgNoyodnQ/qgyAD3t1nArv6hmtZO2lYIoZi7ONQJMnRngRzJ+B0th
 vvH/kdwTCNIltfgIUN+fgehKIlMnBIsHuEmwT6HBxKjRBGwc7oSVGKx42tfqMvc+0ygSNhNV7
 n5Uyep/Spo0pWLdFdKIuy/mtHT5/w==
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
v4: improve env var handling (rename, helper func to query, docu)
 diff.c | 23 ++++++++++++++++++++++-
 diff.h |  6 ++++++
 2 files changed, 28 insertions(+), 1 deletion(-)

diff --git a/diff.c b/diff.c
index 0763e89263ef..8395623acdb1 100644
--- a/diff.c
+++ b/diff.c
@@ -4902,14 +4902,20 @@ const char *diff_aligned_abbrev(const struct object_id *oid, int len)
 	int abblen;
 	const char *abbrev;
 
+	/* Do we want all 40 hex characters? */
 	if (len == GIT_SHA1_HEXSZ)
 		return oid_to_hex(oid);
 
+	/* An abbreviated value is fine, possibly followed by an ellipsis. */
 	abbrev = diff_abbrev_oid(oid, len);
+
+	if (!print_sha1_ellipsis())
+		return abbrev;
+
 	abblen = strlen(abbrev);
 
 	/*
-	 * In well-behaved cases, where the abbbreviated result is the
+	 * In well-behaved cases, where the abbreviated result is the
 	 * same as the requested length, append three dots after the
 	 * abbreviation (hence the whole logic is limited to the case
 	 * where abblen < 37); when the actual abbreviated result is a
@@ -6067,3 +6073,18 @@ void setup_diff_pager(struct diff_options *opt)
 	    check_pager_config("diff") != 0)
 		setup_pager();
 }
+
+int print_sha1_ellipsis(void)
+{
+	/*
+	 * Determine if the calling environment contains the variable
+	 * GIT_PRINT_SHA1_ELLIPSIS set to "yes".
+	 */
+	static int cached_result = -1; /* unknown */
+
+	if (cached_result < 0) {
+		const char *v = getenv("GIT_PRINT_SHA1_ELLIPSIS");
+		cached_result = (v && !strcasecmp(v, "yes"));
+	}
+	return cached_result;
+}
diff --git a/diff.h b/diff.h
index 0fb18dd735b5..a98c9e1cc367 100644
--- a/diff.h
+++ b/diff.h
@@ -438,4 +438,10 @@ extern void print_stat_summary(FILE *fp, int files,
 			       int insertions, int deletions);
 extern void setup_diff_pager(struct diff_options *);
 
+/*
+ * Should we print an ellipsis after an abbreviated SHA-1 value
+ * when doing diff-raw output or indicating a detached HEAD?
+ */
+extern int print_sha1_ellipsis(void);
+
 #endif /* DIFF_H */
-- 
2.13.6

