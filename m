Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B955D20C11
	for <e@80x24.org>; Sun,  3 Dec 2017 21:29:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752690AbdLCV3a (ORCPT <rfc822;e@80x24.org>);
        Sun, 3 Dec 2017 16:29:30 -0500
Received: from mout.gmx.net ([212.227.17.22]:61782 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752274AbdLCV31 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Dec 2017 16:29:27 -0500
Received: from bedhanger.strangled.net ([188.193.86.106]) by mail.gmx.com
 (mrgmx101 [212.227.17.168]) with ESMTPSA (Nemesis) id
 0M7TQZ-1fGcBH2oo3-00xMzn; Sun, 03 Dec 2017 22:28:52 +0100
From:   Ann T Ropea <bedhanger@gmx.de>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Philip Oakley <philipoakley@iee.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Git Mailing List <git@vger.kernel.org>,
        Daniel Barkalow <barkalow@iabervon.org>,
        Ann T Ropea <bedhanger@gmx.de>
Subject: Re: [PATCH v5 6/7] diff: diff_aligned_abbrev: remove ellipsis after abbreviated SHA-1 value
Date:   Sun,  3 Dec 2017 22:27:42 +0100
Message-Id: <20171203212743.10228-6-bedhanger@gmx.de>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20171203212743.10228-1-bedhanger@gmx.de>
References: <20171203212743.10228-1-bedhanger@gmx.de>
References: <20171119184113.16630-1-bedhanger@gmx.de> <20171113223654.27732-1-bedhanger@gmx.de> <83D263E58ABD46188756D41FE311E469@PhilipOakley> <xmqqfu9pmsx3.fsf@gitster.mtv.corp.google.com> <20171113223654.27732-3-bedhanger@gmx.de> <xmqq1sl17e1u.fsf@gitster.mtv.corp.google.com> <20171119184113.16630-5-bedhanger@gmx.de> <xmqqzi7hlhkx.fsf@gitster.mtv.corp.google.com> <5AE7AD53CF184A27BF8F484D415083D9@PhilipOakley> <xmqqo9nuuadm.fsf@gitster.mtv.corp.google.com> <FDCFD8EC7A754412A6369F03E91926C5@PhilipOakley> <CAPig+cT-r0uLLv_GyTRddPe=ATX883S1jt-8gc=ANZW21S81Mg@mail.gmail.com> <CAPig+cT4MvjLDvFEB6hJOSip=dqkp10ydnpfnoUabK=53OmQkw@mail.gmail.com> <20171124235330.15157-1-bedhanger@gmx.de> <xmqq4lpjkl4g.fsf@gitster.mtv.corp.google.com> <xmqqd145k9td.fsf@gitster.mtv.corp.google.com>
In-Reply-To: <xmqqd145k9td.fsf@gitster.mtv.corp.google.com>
X-Provags-ID: V03:K0:xmTfxe5sjJ/KzbFi/7pnxNx6z38x+mYx8SxIBWTqvcnpMJ0rFX6
 Qw4J7Y0MYw14ODXzvZZa0D4zNd6QWodjdo6H+Y2uAwSSQaFDnjzRKgznRl0YYd0S9mK0pfd
 d0onSJef0WnJI4v12ok0rrF9yYmgA1y5cVAscBh5hv75WZ4/zVNumi3loXN8HyE4oqVjwM8
 7YNB/Tvyc8oYswMt3GHtw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:J5NsCm49xFY=:+T2pHFd0iJBBBmFAsFwMq+
 a6dtxzP29UuwXLhgK9TtvyK6Ej9SMwxZyTuapWjEDs+VKqWo++DGtWAK9Wh8JtdjkxXvDhyLj
 dPNj3WaapjXjfbusV2xuj4J5qZxYeC74jVtgoRdYKY5EpczB0Z1b8r8UROq0rU5FEbUe8ZFTz
 QQfa7H9lRxr4xRIXRZRuAy3x3MYwk6qc8/No1BF7olZ+49xye/aNwqN+/Ib0AW/B9TkdDwLfY
 VyGhCkAU+3/y+HfMgCti05iTxvILlEkp9Om+onbLdw8cS0+hLzRze0AfPpV+dpcpW/41tXB4r
 zsqd/pM2WsKOXapnW0p5tkLiv3m54fnUdEpqs1HbX2X7yww9/bpmva0/WMYTHbnwi/44Qh/9V
 AOg2VHiYBxxrrwfnnkEcmCpMSWPuaJJazCBP6PocujRne+3MvnvtpLZ3Vr14osg7HPyf1yWCa
 3eD4e3Bu/SDYo5reseJydGZY43vzzUhhbTvh/fvATlvqcHw09L7zubk3sJu3zQCfxHZNwdnUA
 PoiANmSDskSdUlVaPQ5xuvAxGuLmrtLDWw2MOnqZa7vMVpX+hO0caQCjEOkiy5b6AcuXT9v4r
 WGUUVKHbMWuXicPyIjS3707cI0WZr+adSNiMzxTZIssIU9TfRoYLp8X0jA96r68MO9TsMTBWG
 biguYgYuofK95M62T86NaondiRJHMTUjfyGpWYOzfWUtKrHbh5zv9tAl65tpwRw02pnicDHxE
 2OWAewXo5skRpW5ZIV/e7oKtGeYicCs6TvxSMayvHc/Bbnu8e4RBXeHbWbFg/G+1cKLdxt65B
 KvcnvT96ny8m2Bx6ZnvOgUxMhKJrA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Neither Git nor the user are in need of this (visual) aid anymore, but
we must offer a transition period.

A follow-up patch (series) will rectify the situation by covering the
new output format as well as the backward compatible one.

Also, fix a typo: "abbbreviated" ---> "abbreviated".

Signed-off-by: Ann T Ropea <bedhanger@gmx.de>
---
v2: rename patch series & focus on removal of ellipses
v3: env var instead of config option, use one-line comments where appropriate, preserve indent level
v4: improve env var handling (rename, helper func to query, docu)
v5: rewrite series to take Junio's comments in <xmqqd145k9td.fsf@gitster.mtv.corp.google.com> aboard
 diff.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/diff.c b/diff.c
index 2ebe2227b467..a187c670df6b 100644
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
-- 
2.13.6

