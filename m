Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1AE621F404
	for <e@80x24.org>; Fri, 20 Apr 2018 21:07:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752590AbeDTVHk (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Apr 2018 17:07:40 -0400
Received: from mout.gmx.net ([212.227.17.21]:39983 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752291AbeDTVHj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Apr 2018 17:07:39 -0400
Received: from [192.168.0.129] ([37.201.195.116]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MMXVC-1f3ZF00Uhy-008IZu; Fri, 20
 Apr 2018 23:07:36 +0200
Date:   Fri, 20 Apr 2018 23:07:20 +0200 (DST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH v2 2/4] rebase -i: Handle "combination of <n> commits" with
 GETTEXT_POISON
In-Reply-To: <cover.1524258351.git.johannes.schindelin@gmx.de>
Message-ID: <6fe8b38c7097c826f17e5f45e39ffbc35a529849.1524258351.git.johannes.schindelin@gmx.de>
References: <CAPig+cRrS0_nYJJY=O6cboV630sNQHPV5QGrQdD8MW-sYzNFGQ@mail.gmail.com> <cover.1524258351.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:km3HBH2PHeZhuqsR8zuuyQKAT/O+NEC0CwDoN+/ZRH42tRdtTK1
 tdEGDaFjiAOStlbBXkGUkwPs6HDotbQFr3lFChuI+EI4Z0vbp5RC9OFmotgvbUGIpG0eEJK
 FQFzlun3XvRE/AFUp0svrIXWg1GDLb1fLBL0LByot0r9PE4vpjAPLIkj/oWK8rhGUtXkzlj
 rdw08v6abJTT17gj61HcA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Yb0E8S1qOds=:PMXEtq7XSBjL2obp28bdiV
 RHhPtQeBifIOwOQsDXwy3z139unsYybbdtV2j6B9rgq87x8C1GYkztch569xkGEzFWfEV4Qov
 JHBjwURdTKRF/XR+PrOWsYSKVXwmGiM5SjnOtLfZpnoZPeTg7zq7VL8L2yJt/HGXMMNo4D89A
 2dqcUWO+A7euHpXhZBGrx3EOhcxyxWC9NXhi0ygdUFBAmAqt02t1LqbP7PW4dgaOGH8gIPHAs
 k+KpESZVtLhNRSxTr9KjrYeqKWwvwHAbv3nf+y2jgeceQ+HyDc6ohL+sjzHN9QNOeQ6UJP4q6
 /MsBuBapT/rlJRnfkPr566jn6vTeBtj7QB4kz0EpR6j5VM3Wu83k4ww0ZDe/mbiXm7wZT6sXH
 R0Km2ziiOD+ZYsBgz+j649QbJgs9/3t3bGcjqPA12udEFdbrcCwn88GPNMz+vUnGHZN5aFglr
 cgT/HeytzuSZLH6oFmL7BR37Tl5Uyv2FLvoUtsTO7OShl5RKMLps5YxTSkvds66RCOoj2Lq2u
 TOpZkGOHiqhhIXIScE9lmdFIgfbH1zCYZVwCZL6wd6VJiLu7mR2ux4NScuVlTQIBV6tPFiwfh
 aDrJt7oA71jK4PUhlEVMwwPl2qaPUDLPfn6+kPzlvxXeEZhMRTugyamy9ExfbmvTX5JEMta1S
 lEAr8wiCbPyIvEBe8D9vXZ2IGUdC2xvkYm0eRXUcwfImsvWlsvYBw7j/FO6aiBET6olQnxSOL
 pS1a1JN2E7tB3ZS3Y7IsnIcyglmJjFYP46CnkLzE6thYF3lxekICDu4Jp7cO4S02Dn2jHIJAy
 +e/1Dwz26r/eaMpnb9YhxFw3+n6LWJc5OXk6lB86ZmkQGq6D98=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We previously relied on the localized versions of

	# This is a combination of <N> commits

(which we write into the commit messages during fixup/squash chains)
to contain <N> as ASCII.

Thisis not true in general, and certainly not in GETTEXT_POISON, as
demonstrated by the regression test we just introduced in t3418.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sequencer.c | 36 ++++++++++++++++++++++--------------
 1 file changed, 22 insertions(+), 14 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 667f35ebdff..dc482e76a28 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1343,19 +1343,18 @@ static int update_squash_messages(enum todo_command command,
 		eol = strchrnul(buf.buf, '\n');
 		if (buf.buf[0] != comment_line_char ||
 		    (p += strcspn(p, "0123456789\n")) == eol)
-			return error(_("unexpected 1st line of squash message:"
-				       "\n\n\t%.*s"),
-				     (int)(eol - buf.buf), buf.buf);
-		count = strtol(p, NULL, 10);
-
-		if (count < 1)
-			return error(_("invalid 1st line of squash message:\n"
-				       "\n\t%.*s"),
-				     (int)(eol - buf.buf), buf.buf);
+			count = -1;
+		else
+			count = strtol(p, NULL, 10);
 
 		strbuf_addf(&header, "%c ", comment_line_char);
-		strbuf_addf(&header,
-			    _("This is a combination of %d commits."), ++count);
+		if (count < 1)
+			strbuf_addf(&header, _("This is a combination of "
+					       "several commits."));
+		else
+			strbuf_addf(&header,
+				    _("This is a combination of %d commits."),
+				    ++count);
 		strbuf_splice(&buf, 0, eol - buf.buf, header.buf, header.len);
 		strbuf_release(&header);
 	} else {
@@ -1398,13 +1397,22 @@ static int update_squash_messages(enum todo_command command,
 	if (command == TODO_SQUASH) {
 		unlink(rebase_path_fixup_msg());
 		strbuf_addf(&buf, "\n%c ", comment_line_char);
-		strbuf_addf(&buf, _("This is the commit message #%d:"), count);
+		if (count < 2)
+			strbuf_addf(&buf, _("This is the next commit "
+					    "message:"));
+		else
+			strbuf_addf(&buf, _("This is the commit message #%d:"),
+				    count);
 		strbuf_addstr(&buf, "\n\n");
 		strbuf_addstr(&buf, body);
 	} else if (command == TODO_FIXUP) {
 		strbuf_addf(&buf, "\n%c ", comment_line_char);
-		strbuf_addf(&buf, _("The commit message #%d will be skipped:"),
-			    count);
+		if (count < 2)
+			strbuf_addf(&buf, _("The next commit message will be "
+					    "skipped:"));
+		else
+			strbuf_addf(&buf, _("The commit message #%d will be "
+					    "skipped:"), count);
 		strbuf_addstr(&buf, "\n\n");
 		strbuf_add_commented_lines(&buf, body, strlen(body));
 	} else
-- 
2.17.0.windows.1.15.gaa56ade3205


