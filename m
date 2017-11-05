Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 495AC20281
	for <e@80x24.org>; Sun,  5 Nov 2017 16:29:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750821AbdKEQ3C (ORCPT <rfc822;e@80x24.org>);
        Sun, 5 Nov 2017 11:29:02 -0500
Received: from mout.gmx.net ([212.227.17.21]:51774 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750731AbdKEQ3B (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Nov 2017 11:29:01 -0500
Received: from bedhanger.strangled.net ([188.192.144.31]) by mail.gmx.com
 (mrgmx103 [212.227.17.168]) with ESMTPSA (Nemesis) id
 0MRGvT-1dgstP3Sff-00UZTX; Sun, 05 Nov 2017 17:28:28 +0100
From:   Ann T Ropea <bedhanger@gmx.de>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Daniel Barkalow <barkalow@iabervon.org>,
        Ann T Ropea <bedhanger@gmx.de>
Subject: [PATCH 3/3] Documentation: revisions: add note about 3dots usages as continuation indications
Date:   Sun,  5 Nov 2017 17:27:30 +0100
Message-Id: <20171105162730.31405-3-bedhanger@gmx.de>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20171105162730.31405-1-bedhanger@gmx.de>
References: <20171105162730.31405-1-bedhanger@gmx.de>
X-Provags-ID: V03:K0:+5b/0hRxrqG+GhMke526kwSeTAQDsGkFlnJdJyul2C3KRmhh4AS
 mh5bF5hqVqSNxdkcjRFZNj7eU2F0UAHn6ribJn7MJg/msnethxi3xyqoZwViIQ1tK6/q3wE
 tFhYF0y4VIrPYfXcSN6FNZwbuQtvKzfY8hk9l7KyttmN9sWKGyMs6NYNjOFr8B8Vbj2kW0r
 2V+ZafY81cJguY8BtR46Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:n6AhmgmCipc=:OE0rj4+iTmMvXVujGUt2FY
 jdipl37N2E79SX18oq3wlY9Zd0mh0xpmMFgx9uZJNAvDkLe+j0MXBeRcy2IgTkqbm8P6LRNWc
 wqYa4USKjVysnMcie3y1E8wWzdjmv1sVtAhFXD0LRAmkCifPwDXWWTb8QND4SSNj9CU30+3XJ
 XsAFKilf6RTr4uvBnfhq0OfNun4Wd3gWEyg0iN/j78Y6j/FLTd21+m0TglDYjAPJrAfYcsF+o
 lZAY4XnwEDq/Vvcz1KNxQjNcHEtNVHrgdnFEm2/1hrZ0kw4S1BGZya4mHkas5RMyEwlDLjVvW
 flWToKeY0K43PUxulamF/ZMmZi6UjIowpFB57TlKxnVXbJjNVHfiITXg6L8tVcGVEsjhvG791
 iuiaE+XqUujQaCmlZ7NEqtciLcIBRwzvITPdM+ng9EE4PrSjgYhAJsbKY2C2Kj+EJhEBJG332
 MX2QHEB5WdIMR4Uvpt3OFWnIEEuAR+aooe7UCqyQtEmVhc0gmjwmPN9F1fQMkayJEDbvo5Hx4
 IbgS6j5QfFaIGItV3E2sGDHsGlBLWxDRnSS8WWK00Itzv1smZNlHO0lpgBcnG+5HDQZMYgkIg
 cvkJ4e2p3jKNo3nK2q/c3pbL4KKOa20C8z/Pl8HftzkCFYjvqI9MMg2MtH16/HtsqEl01qB6Y
 y04OxF0mOIjZ+BPETnvu58LPuIizabK7z5edPeydNkTIuO0efe9fd87YwtwLc20HTkyclu4m5
 15HOXWp9ol7u23+Iv5jGV+VVSFhtznG9bej2O0Zrc/d7IlUQcPOI7ArrBjHSWQECc4JYK5LNA
 +MzL+seDGHL+et9cqKeLElDNgHLEA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Also, fix typo: "three dot" ---> "three-dot" (align with "two-dot").

Signed-off-by: Ann T Ropea <bedhanger@gmx.de>
---
 Documentation/revisions.txt | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/Documentation/revisions.txt b/Documentation/revisions.txt
index 61277469c874..d1b126427177 100644
--- a/Documentation/revisions.txt
+++ b/Documentation/revisions.txt
@@ -271,7 +271,7 @@ The '..' (two-dot) Range Notation::
  for commits that are reachable from r2 excluding those that are reachable
  from r1 by '{caret}r1 r2' and it can be written as 'r1..r2'.
 
-The '...' (three dot) Symmetric Difference Notation::
+The '...' (three-dot) Symmetric Difference Notation::
  A similar notation 'r1\...r2' is called symmetric difference
  of 'r1' and 'r2' and is defined as
  'r1 r2 --not $(git merge-base --all r1 r2)'.
@@ -285,6 +285,15 @@ is a shorthand for 'HEAD..origin' and asks "What did the origin do since
 I forked from them?"  Note that '..' would mean 'HEAD..HEAD' which is an
 empty range that is both reachable and unreachable from HEAD.
 
+However, there are instances where '<sha1>...' is *not*
+equivalent to '<sha1>...HEAD'.  See the "RAW OUTPUT FORMAT"
+section of linkgit:git-diff[1]: the three-dot notations used
+there are simply continuation indications for the abbreviated
+SHA-1 values.  The ones encountered there are usually
+associated with file/index/tree contents rather than with commit
+objects, and the range operators described above are only
+applicable to commit objects (i.e., 'r1' and 'r2').
+
 Other <rev>{caret} Parent Shorthand Notations
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 Three other shorthands exist, particularly useful for merge commits,
-- 
2.13.6

