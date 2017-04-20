Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F12EA207BD
	for <e@80x24.org>; Thu, 20 Apr 2017 20:33:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1033837AbdDTUde (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Apr 2017 16:33:34 -0400
Received: from cloud.peff.net ([104.130.231.41]:37194 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1033796AbdDTUcg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Apr 2017 16:32:36 -0400
Received: (qmail 32222 invoked by uid 109); 20 Apr 2017 20:32:35 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 20 Apr 2017 20:32:35 +0000
Received: (qmail 9019 invoked by uid 111); 20 Apr 2017 20:32:59 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 20 Apr 2017 16:32:59 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 20 Apr 2017 16:32:33 -0400
Date:   Thu, 20 Apr 2017 16:32:33 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 1/6] doc: use https links to avoid http redirect
Message-ID: <20170420203232.z3m5xeu3pgazkdkx@sigill.intra.peff.net>
References: <20170420203203.xlbajdfzy7gp3hj3@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170420203203.xlbajdfzy7gp3hj3@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Many sites these days unconditionally redirect http requests
to their https equivalents. Let's make our links https in
the first place to save the client a redirect.

Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/git-bisect-lk2009.txt              | 10 +++++-----
 Documentation/gitweb.conf.txt                    |  4 ++--
 Documentation/howto/rebuild-from-update-hook.txt |  4 ++--
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/Documentation/git-bisect-lk2009.txt b/Documentation/git-bisect-lk2009.txt
index e015f5b3c..716d66d43 100644
--- a/Documentation/git-bisect-lk2009.txt
+++ b/Documentation/git-bisect-lk2009.txt
@@ -1349,10 +1349,10 @@ References
 
 - [[[1]]] http://www.nist.gov/public_affairs/releases/n02-10.htm['Software Errors Cost U.S. Economy $59.5 Billion Annually'. Nist News Release.]
 - [[[2]]] http://java.sun.com/docs/codeconv/html/CodeConventions.doc.html#16712['Code Conventions for the Java Programming Language'. Sun Microsystems.]
-- [[[3]]] http://en.wikipedia.org/wiki/Software_maintenance['Software maintenance'. Wikipedia.]
+- [[[3]]] https://en.wikipedia.org/wiki/Software_maintenance['Software maintenance'. Wikipedia.]
 - [[[4]]] http://article.gmane.org/gmane.comp.version-control.git/45195/[Junio C Hamano. 'Automated bisect success story'. Gmane.]
-- [[[5]]] http://lwn.net/Articles/317154/[Christian Couder. 'Fully automated bisecting with "git bisect run"'. LWN.net.]
-- [[[6]]] http://lwn.net/Articles/277872/[Jonathan Corbet. 'Bisection divides users and developers'. LWN.net.]
+- [[[5]]] https://lwn.net/Articles/317154/[Christian Couder. 'Fully automated bisecting with "git bisect run"'. LWN.net.]
+- [[[6]]] https://lwn.net/Articles/277872/[Jonathan Corbet. 'Bisection divides users and developers'. LWN.net.]
 - [[[7]]] http://article.gmane.org/gmane.linux.scsi/36652/[Ingo Molnar. 'Re: BUG 2.6.23-rc3 can't see sd partitions on Alpha'. Gmane.]
-- [[[8]]] http://www.kernel.org/pub/software/scm/git/docs/git-bisect.html[Junio C Hamano and the git-list. 'git-bisect(1) Manual Page'. Linux Kernel Archives.]
-- [[[9]]] http://github.com/Ealdwulf/bbchop[Ealdwulf. 'bbchop'. GitHub.]
+- [[[8]]] https://www.kernel.org/pub/software/scm/git/docs/git-bisect.html[Junio C Hamano and the git-list. 'git-bisect(1) Manual Page'. Linux Kernel Archives.]
+- [[[9]]] https://github.com/Ealdwulf/bbchop[Ealdwulf. 'bbchop'. GitHub.]
diff --git a/Documentation/gitweb.conf.txt b/Documentation/gitweb.conf.txt
index e6320891b..9c8982ec9 100644
--- a/Documentation/gitweb.conf.txt
+++ b/Documentation/gitweb.conf.txt
@@ -368,8 +368,8 @@ $logo_url::
 $logo_label::
 	URI and label (title) for the Git logo link (or your site logo,
 	if you chose to use different logo image). By default, these both
-	refer to Git homepage, http://git-scm.com[]; in the past, they pointed
-	to Git documentation at http://www.kernel.org[].
+	refer to Git homepage, https://git-scm.com[]; in the past, they pointed
+	to Git documentation at https://www.kernel.org[].
 
 
 Changing gitweb's look
diff --git a/Documentation/howto/rebuild-from-update-hook.txt b/Documentation/howto/rebuild-from-update-hook.txt
index 25378f68d..db219f5c0 100644
--- a/Documentation/howto/rebuild-from-update-hook.txt
+++ b/Documentation/howto/rebuild-from-update-hook.txt
@@ -4,13 +4,13 @@ From: Junio C Hamano <gitster@pobox.com>
 Date: Fri, 26 Aug 2005 18:19:10 -0700
 Abstract: In this how-to article, JC talks about how he
  uses the post-update hook to automate Git documentation page
- shown at http://www.kernel.org/pub/software/scm/git/docs/.
+ shown at https://www.kernel.org/pub/software/scm/git/docs/.
 Content-type: text/asciidoc
 
 How to rebuild from update hook
 ===============================
 
-The pages under http://www.kernel.org/pub/software/scm/git/docs/
+The pages under https://www.kernel.org/pub/software/scm/git/docs/
 are built from Documentation/ directory of the git.git project
 and needed to be kept up-to-date.  The www.kernel.org/ servers
 are mirrored and I was told that the origin of the mirror is on
-- 
2.13.0.rc0.363.g8726c260e

