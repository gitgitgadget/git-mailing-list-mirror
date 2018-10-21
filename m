Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4CBFD1F453
	for <e@80x24.org>; Sun, 21 Oct 2018 18:46:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728032AbeJVDB0 (ORCPT <rfc822;e@80x24.org>);
        Sun, 21 Oct 2018 23:01:26 -0400
Received: from mout.gmx.net ([212.227.15.15]:37641 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727825AbeJVDB0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 Oct 2018 23:01:26 -0400
Received: from p2520la.lan ([217.235.92.200]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Lkwc9-1fe92d2D9p-00alPv; Sun, 21
 Oct 2018 20:46:10 +0200
Received: from p2520la.lan ([217.235.92.200]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Lkwc9-1fe92d2D9p-00alPv; Sun, 21
 Oct 2018 20:46:10 +0200
From:   Tim Schumacher <timschumi@gmx.de>
To:     git@vger.kernel.org
Cc:     timschumi@gmx.de
Subject: [PATCH 1/2] alias: Rework comment about processing aliases
Date:   Sun, 21 Oct 2018 20:46:18 +0200
Message-Id: <20181021184619.6688-1-timschumi@gmx.de>
X-Mailer: git-send-email 2.19.1.450.ga4b8ab536
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:7PuzMI7Vbu3W6MMinr8Ke/P1Y65DJlmCDHbZ5OhtotMzUu4D0c/
 2g/An44dx00OWlZnX9KcheKJhVPUhRTSg4Byc7gvb274BI+sKgxfQ4Efv9cd/8Cu0nYPbfe
 HJWr//Cu5VZ3QLT4ws+X3YFXoCE7DDH0eplg5dwcRKoKVbuh0WMGURgSYpirrBVAamJHZTZ
 e3DvXjlSDpS8hzbpVFYkg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:g0kJDg3e2dg=:1diPSB5dPeq1Usy5CnSk+A
 AlmPK7lsLx2DRPDnXUmty4Wve+mlm2OFlodNcDvJ9YxcZrB17J+OJQck5dRp/PjIxOrQzVYzq
 cwvlgMNsveD1ZG0RjX6XG8qQ3x0mCjeBfkNZMb+oj1ZE3jkiSBEUROeH/4NUsDMWgeMFVLQQ4
 QatdMATtgfz8Dm2Wp7knJm4/RyFNrL7hmh2bWDGD3LBS9uYZ0Tz5aN5BbemFWcg5MKkKQZQv2
 fh58SYDwv9CD1vopb9inj8lCn6EwCKKddLshH8PU2o+Sow4JvvjyWAA4mwBLLf9dq7kZwz/uZ
 zIZrzXredalnDVnGbz4YBW0n9mXwwlCxnXCdXBibSRdJ2bjp0z+6azenFQIDVJkmaWTZI7jbe
 YRAnh9ytWLA6UmNiTwQa2XdLWLHdaj+rV3iGtwBEX6aEPH+clSSDzehd4DvMixsEI+w9Kcdlq
 XOcuk97XNCq+cJ2AodW6idikWlcmLiOwq6l0dce0xESzqlILOTySlc9NeQbWJauMGDgV+XGTW
 Lhk4h77qocsIifCEwfcZUe+4fTC50nlF4KM2zy9n6NU3G8rFX9EBOBCfdCiuIs2eei2limKPc
 GjfHG+Jwxbi6Lb/i7wMPu73Bribsfl6fN3OIHFGwTG8wRKHvGEho/U3uEr376/E7RimNM8Ysm
 u+CSYnUX4Zuej45Y/qHv4hwSQ/kh8RMEEJx+MckbsYxiOOtxVxhPJS2AQVCThH5kiC6MuWfjc
 jeNB6IWgKLRtAliBn6EZTTsYIdrkiyaGs97TuUZP6FeBqfFIetXzXXI3o/dWzil7fh96dIwEo
 fgNUrFznhl1i85DcLAvuRjdoEn/FA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The old comment's message wasn't really clear and it was in a weird
location for it to talk about the alias handling process as a whole.

Rephrase and move it to the top of the while() loop to make the
message more clear.
---
 git.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/git.c b/git.c
index 6a81ed6fc..0f77bce7d 100644
--- a/git.c
+++ b/git.c
@@ -718,6 +718,11 @@ static int run_argv(int *argcp, const char ***argv)
 	struct strbuf env = STRBUF_INIT;
 
 	init_cmd_history(&env, &cmd_list);
+
+	/*
+	 * Check if argv[0] is a command before seeing if it is an
+	 * alias to avoid taking over existing commands
+	 */
 	while (1) {
 		/*
 		 * If we tried alias and futzed with our environment,
@@ -753,11 +758,6 @@ static int run_argv(int *argcp, const char ***argv)
 
 		add_cmd_history(&env, &cmd_list, *argv[0]);
 
-		/*
-		 * It could be an alias -- this works around the insanity
-		 * of overriding "git log" with "git show" by having
-		 * alias.log = show
-		 */
 		if (!handle_alias(argcp, argv))
 			break;
 		done_alias = 1;
-- 
2.19.1.450.ga4b8ab536

