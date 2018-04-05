Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 79D381F404
	for <e@80x24.org>; Thu,  5 Apr 2018 17:20:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751410AbeDERUh (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Apr 2018 13:20:37 -0400
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:36382 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750786AbeDERUg (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 5 Apr 2018 13:20:36 -0400
Received: from pps.filterd (m0096528.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w35HDTB5005549;
        Thu, 5 Apr 2018 10:20:35 -0700
Authentication-Results: palantir.com;
        spf=softfail smtp.mailfrom=newren@gmail.com
Received: from smtp-transport.yojoe.local (mxw3.palantir.com [66.70.54.23] (may be forged))
        by mx0a-00153501.pphosted.com with ESMTP id 2h277s7329-1;
        Thu, 05 Apr 2018 10:20:34 -0700
Received: from mxw1.palantir.com (smtp.yojoe.local [172.19.0.45])
        by smtp-transport.yojoe.local (Postfix) with ESMTP id C4330229B0E2;
        Thu,  5 Apr 2018 10:20:34 -0700 (PDT)
Received: from newren2-linux.yojoe.local (unknown [10.100.71.66])
        by smtp.yojoe.local (Postfix) with ESMTP id BBB482CDEB1;
        Thu,  5 Apr 2018 10:20:34 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>
Subject: [PATCH 1/2] Documentation: Fix several one-character-off spelling errors
Date:   Thu,  5 Apr 2018 10:20:26 -0700
Message-Id: <20180405172027.31515-1-newren@gmail.com>
X-Mailer: git-send-email 2.17.0.7.g0b50f94d69
X-Proofpoint-SPF-Result: softfail
X-Proofpoint-SPF-Record: v=spf1 redirect=_spf.google.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-04-05_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=4 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1711220000 definitions=main-1804050178
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 Documentation/diff-options.txt                    | 4 ++--
 Documentation/git-fetch-pack.txt                  | 2 +-
 Documentation/git-for-each-ref.txt                | 2 +-
 Documentation/git-send-email.txt                  | 2 +-
 Documentation/git-status.txt                      | 2 +-
 Documentation/technical/api-directory-listing.txt | 2 +-
 6 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index e3a44f03cd..f466600972 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -568,7 +568,7 @@ the normal order.
 --
 +
 Patterns have the same syntax and semantics as patterns used for
-fnmantch(3) without the FNM_PATHNAME flag, except a pathname also
+fnmatch(3) without the FNM_PATHNAME flag, except a pathname also
 matches a pattern if removing any number of the final pathname
 components matches the pattern.  For example, the pattern "`foo*bar`"
 matches "`fooasdfbar`" and "`foo/bar/baz/asdf`" but not "`foobarx`".
@@ -592,7 +592,7 @@ endif::git-format-patch[]
 	Treat all files as text.
 
 --ignore-cr-at-eol::
-	Ignore carrige-return at the end of line when doing a comparison.
+	Ignore carriage-return at the end of line when doing a comparison.
 
 --ignore-space-at-eol::
 	Ignore changes in whitespace at EOL.
diff --git a/Documentation/git-fetch-pack.txt b/Documentation/git-fetch-pack.txt
index f7ebe36a7b..c975884793 100644
--- a/Documentation/git-fetch-pack.txt
+++ b/Documentation/git-fetch-pack.txt
@@ -88,7 +88,7 @@ be in a separate packet, and the list must end with a flush packet.
 	infinite even if there is an ancestor-chain that long.
 
 --shallow-since=<date>::
-	Deepen or shorten the history of a shallow'repository to
+	Deepen or shorten the history of a shallow repository to
 	include all reachable commits after <date>.
 
 --shallow-exclude=<revision>::
diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
index dffa14a795..085d177d97 100644
--- a/Documentation/git-for-each-ref.txt
+++ b/Documentation/git-for-each-ref.txt
@@ -121,7 +121,7 @@ refname::
 	stripping with positive <N>, or it becomes the full refname if
 	stripping with negative <N>.  Neither is an error.
 +
-`strip` can be used as a synomym to `lstrip`.
+`strip` can be used as a synonym to `lstrip`.
 
 objecttype::
 	The type of the object (`blob`, `tree`, `commit`, `tag`).
diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
index 71ef97ba9b..cd149e7056 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -255,7 +255,7 @@ must be used for each option.
 
 --batch-size=<num>::
 	Some email servers (e.g. smtp.163.com) limit the number emails to be
-	sent per session (connection) and this will lead to a faliure when
+	sent per session (connection) and this will lead to a failure when
 	sending many messages.  With this option, send-email will disconnect after
 	sending $<num> messages and wait for a few seconds (see --relogin-delay)
 	and reconnect, to work around such a limit.  You may want to
diff --git a/Documentation/git-status.txt b/Documentation/git-status.txt
index 6c230c0c72..c16e27e63d 100644
--- a/Documentation/git-status.txt
+++ b/Documentation/git-status.txt
@@ -113,7 +113,7 @@ The possible options are:
 	- 'matching'    - Shows ignored files and directories matching an
 			  ignore pattern.
 +
-When 'matching' mode is specified, paths that explicity match an
+When 'matching' mode is specified, paths that explicitly match an
 ignored pattern are shown. If a directory matches an ignore pattern,
 then it is shown, but not paths contained in the ignored directory. If
 a directory does not match an ignore pattern, but all contents are
diff --git a/Documentation/technical/api-directory-listing.txt b/Documentation/technical/api-directory-listing.txt
index 7fae00f44f..4f44ca24f6 100644
--- a/Documentation/technical/api-directory-listing.txt
+++ b/Documentation/technical/api-directory-listing.txt
@@ -53,7 +53,7 @@ The notable options are:
 	not be returned even if all of its contents are ignored. In
 	this case, the contents are returned as individual entries.
 +
-If this is set, files and directories that explicity match an ignore
+If this is set, files and directories that explicitly match an ignore
 pattern are reported. Implicity ignored directories (directories that
 do not match an ignore pattern, but whose contents are all ignored)
 are not reported, instead all of the contents are reported.
-- 
2.17.0.7.g0b50f94d69

