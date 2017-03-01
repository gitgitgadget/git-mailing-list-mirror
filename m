Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BE3E72023D
	for <e@80x24.org>; Wed,  1 Mar 2017 23:17:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752994AbdCAXRA (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Mar 2017 18:17:00 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:58752 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752845AbdCAXQ7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Mar 2017 18:16:59 -0500
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id E5C062023D;
        Wed,  1 Mar 2017 22:22:04 +0000 (UTC)
Date:   Wed, 1 Mar 2017 22:22:04 +0000
From:   Eric Wong <e@80x24.org>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: [PATCH] README: create HTTP/HTTPS links from URLs in Markdown
Message-ID: <20170301222204.GA5413@whir>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Markdown supports automatic links by surrounding URLs with
angle brackets, as documented in
<https://daringfireball.net/projects/markdown/syntax#autolink>

While we're at it, update URLs to avoid redirecting clients for
git-scm.com (by using HTTPS) and public-inbox.org (by adding a
trailing slash).

Signed-off-by: Eric Wong <e@80x24.org>
---
 I was going to cite some style manuals (MLA, APA, etc),
 but it seems current versions do not favor angle brackets.
 However, this remains consistent with the recommendations in
 RFC 2369 <https://ietf.org/rfc/rfc2369.txt> for mail headers.

 README.md | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/README.md b/README.md
index c0cd5580e..f17af66a9 100644
--- a/README.md
+++ b/README.md
@@ -12,7 +12,7 @@ Torvalds with help of a group of hackers around the net.
 
 Please read the file [INSTALL][] for installation instructions.
 
-Many Git online resources are accessible from http://git-scm.com/
+Many Git online resources are accessible from <https://git-scm.com/>
 including full documentation and Git related tools.
 
 See [Documentation/gittutorial.txt][] to get started, then see
@@ -33,8 +33,8 @@ requests, comments and patches to git@vger.kernel.org (read
 [Documentation/SubmittingPatches][] for instructions on patch submission).
 To subscribe to the list, send an email with just "subscribe git" in
 the body to majordomo@vger.kernel.org. The mailing list archives are
-available at https://public-inbox.org/git,
-http://marc.info/?l=git and other archival sites.
+available at <https://public-inbox.org/git/>,
+<http://marc.info/?l=git> and other archival sites.
 
 The maintainer frequently sends the "What's cooking" reports that
 list the current status of various development topics to the mailing
-- 
EW
