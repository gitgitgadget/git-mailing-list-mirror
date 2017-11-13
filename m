Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D8EA11F42B
	for <e@80x24.org>; Mon, 13 Nov 2017 22:38:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752646AbdKMWip (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Nov 2017 17:38:45 -0500
Received: from mout.gmx.net ([212.227.17.22]:62157 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751376AbdKMWio (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Nov 2017 17:38:44 -0500
Received: from bedhanger.strangled.net ([188.192.144.31]) by mail.gmx.com
 (mrgmx103 [212.227.17.168]) with ESMTPSA (Nemesis) id
 0MOOJl-1eK87p1QRh-005rob; Mon, 13 Nov 2017 23:38:08 +0100
From:   Ann T Ropea <bedhanger@gmx.de>
To:     Philip Oakley <philipoakley@iee.org>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Daniel Barkalow <barkalow@iabervon.org>,
        Ann T Ropea <bedhanger@gmx.de>
Subject: Re: [PATCH v2 3/6] diff: diff_aligned_abbrev: remove ellipsis after abbreviated SHA-1 value
Date:   Mon, 13 Nov 2017 23:36:51 +0100
Message-Id: <20171113223654.27732-3-bedhanger@gmx.de>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20171113223654.27732-1-bedhanger@gmx.de>
References: <20171113223654.27732-1-bedhanger@gmx.de>
References: <83D263E58ABD46188756D41FE311E469@PhilipOakley> <xmqqfu9pmsx3.fsf@gitster.mtv.corp.google.com>
In-Reply-To: <EA775C6AB4684B7A86A88C733C132827@PhilipOakley>
X-Provags-ID: V03:K0:1Hck+xYzffmeKCYSBlgL05WjwC5gni3+jE3Hb68H5xsOm4CZqzG
 Xa/X0H+eWSUokpQpT+WK0lMthPfr7S4WL0KjtCffDUe/tZXlpAVjbo5xt4xiBbct0D2LFvG
 00qMbsLO4KrU3lDXV4RLQ18voHHW3IPoRpiFwSiRdIisU/jU3+Hlq4HBoxQLRiAQFY1gIOu
 VqVEYfXdaNH+VB7dx87BA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:FdJ3yYz1peE=:lkyOfeXQUER5repyAk3QA7
 kaBLKc8ya51ur09QONvZlwZPmei7p0cR1/ymY1UJkVyg86EZXN0vYwM/em/xJNCGFJETaL+fA
 5frf1gJuB/LDO2glZ2fW8kVx/LUEPuXcHzc/l8x+DO7SAzHrUIejr+hYnX4+vHYGrdhAhD0C6
 /1zvzIy4buiVS0vn+PtHY/W5gKE+w4az8PSLPEjrdAyRbiB8RMLDTFElVlfrKknAiG8MIjCc7
 PDJ+otGWtPc1uTFZJCKpFiFbc2nnyuiX5w1yTo/0yjzxStmlyUdQKE+agM7DOln/yG1FEEaqh
 tKI+osM3/nJmYcynAY9ZC1Q3VL+NZzVGgdLuFIGiYWYEPByjGMi5cEDY3ZjUqhckt118mCb4A
 NPpQc39EQW5BW4gweWYlPLV5mb2rtZmDPPb19uwCaliMDmTeIv/jYFEdaWe7qHHbrUirLtk0j
 ID9LSMz0+oEqzDMq4UXRhUKOEth/7hWsCBVHDuVUXgs1Vv+Rl+3sVqbldPQ9dLNStFmF1WInT
 myE+sY1C/qcvzLKL6vzu7qrnN8+leGV4ePdFp50/QrUiL42VfvtnJBqos11PVxJBE9zuzoVvj
 ZdyE98IGO0CJMWLj3apGokgTmWOgorZb+lcx6X4yAbEhc6Wp+r2qWGFDmjRHsgMmGG/L2ZqmS
 j4fu72sHiWfA1PfpUqe08LwA+q4TIu2e3SYvTJEWX95gPQ5tk9a5k4TzEUU9iouXj5F1RAuYR
 86TYJZEc0I9bG61n+RArMw89qlEdQ0AhhRtnkKq4r41vV9b7OYXehxo9zu9gp62eStb1s/IAQ
 vlh7r3djjEBXUtt8pAiegrFDbU6Kg==
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
 diff.c | 69 +++++++++++++++++++++++++++++++++++++-----------------------------
 1 file changed, 39 insertions(+), 30 deletions(-)

diff --git a/diff.c b/diff.c
index 0763e89263ef..9709dc37c6d7 100644
--- a/diff.c
+++ b/diff.c
@@ -4902,41 +4902,50 @@ const char *diff_aligned_abbrev(const struct object_id *oid, int len)
 	int abblen;
 	const char *abbrev;
 
+	/* Do we want all 40 hex characters?
+	 */
 	if (len == GIT_SHA1_HEXSZ)
 		return oid_to_hex(oid);
 
-	abbrev = diff_abbrev_oid(oid, len);
-	abblen = strlen(abbrev);
-
-	/*
-	 * In well-behaved cases, where the abbbreviated result is the
-	 * same as the requested length, append three dots after the
-	 * abbreviation (hence the whole logic is limited to the case
-	 * where abblen < 37); when the actual abbreviated result is a
-	 * bit longer than the requested length, we reduce the number
-	 * of dots so that they match the well-behaved ones.  However,
-	 * if the actual abbreviation is longer than the requested
-	 * length by more than three, we give up on aligning, and add
-	 * three dots anyway, to indicate that the output is not the
-	 * full object name.  Yes, this may be suboptimal, but this
-	 * appears only in "diff --raw --abbrev" output and it is not
-	 * worth the effort to change it now.  Note that this would
-	 * likely to work fine when the automatic sizing of default
-	 * abbreviation length is used--we would be fed -1 in "len" in
-	 * that case, and will end up always appending three-dots, but
-	 * the automatic sizing is supposed to give abblen that ensures
-	 * uniqueness across all objects (statistically speaking).
+	/* An abbreviated value is fine, possibly followed by an
+	 * ellipsis.
 	 */
-	if (abblen < GIT_SHA1_HEXSZ - 3) {
-		static char hex[GIT_MAX_HEXSZ + 1];
-		if (len < abblen && abblen <= len + 2)
-			xsnprintf(hex, sizeof(hex), "%s%.*s", abbrev, len+3-abblen, "..");
-		else
-			xsnprintf(hex, sizeof(hex), "%s...", abbrev);
-		return hex;
-	}
+	if (print_sha1_ellipsis) {
+		abbrev = diff_abbrev_oid(oid, len);
+		abblen = strlen(abbrev);
+
+		/*
+		 * In well-behaved cases, where the abbreviated result is the
+		 * same as the requested length, append three dots after the
+		 * abbreviation (hence the whole logic is limited to the case
+		 * where abblen < 37); when the actual abbreviated result is a
+		 * bit longer than the requested length, we reduce the number
+		 * of dots so that they match the well-behaved ones.  However,
+		 * if the actual abbreviation is longer than the requested
+		 * length by more than three, we give up on aligning, and add
+		 * three dots anyway, to indicate that the output is not the
+		 * full object name.  Yes, this may be suboptimal, but this
+		 * appears only in "diff --raw --abbrev" output and it is not
+		 * worth the effort to change it now.  Note that this would
+		 * likely to work fine when the automatic sizing of default
+		 * abbreviation length is used--we would be fed -1 in "len" in
+		 * that case, and will end up always appending three-dots, but
+		 * the automatic sizing is supposed to give abblen that ensures
+		 * uniqueness across all objects (statistically speaking).
+		 */
+		if (abblen < GIT_SHA1_HEXSZ - 3) {
+			static char hex[GIT_MAX_HEXSZ + 1];
+			if (len < abblen && abblen <= len + 2)
+				xsnprintf(hex, sizeof(hex), "%s%.*s", abbrev, len+3-abblen, "..");
+			else
+				xsnprintf(hex, sizeof(hex), "%s...", abbrev);
+			return hex;
+		}
 
-	return oid_to_hex(oid);
+		return oid_to_hex(oid);
+	} else {
+		return diff_abbrev_oid(oid, len);
+	}
 }
 
 static void diff_flush_raw(struct diff_filepair *p, struct diff_options *opt)
-- 
2.13.6

