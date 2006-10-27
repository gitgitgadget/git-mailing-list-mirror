X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH] Documentation: add upload-archive service to git-daemon.
Date: Fri, 27 Oct 2006 06:59:18 +0200
Message-ID: <20061027065918.23f33855.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Fri, 27 Oct 2006 04:52:30 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.20; i486-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30290>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GdJhg-0007dj-W6 for gcvg-git@gmane.org; Fri, 27 Oct
 2006 06:52:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1423641AbWJ0EwW (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 27 Oct 2006
 00:52:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423642AbWJ0EwW
 (ORCPT <rfc822;git-outgoing>); Fri, 27 Oct 2006 00:52:22 -0400
Received: from smtp3-g19.free.fr ([212.27.42.29]:8679 "EHLO
 smtp3-g19.free.fr") by vger.kernel.org with ESMTP id S1423641AbWJ0EwV (ORCPT
 <rfc822;git@vger.kernel.org>); Fri, 27 Oct 2006 00:52:21 -0400
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net
 [82.243.130.161]) by smtp3-g19.free.fr (Postfix) with SMTP id 6C8D149EEC;
 Fri, 27 Oct 2006 06:52:20 +0200 (CEST)
To: Junio Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

This patch minimaly documents the upload-archive service,
hoping that someone with better knowledge will improve upon.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Documentation/git-daemon.txt |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-daemon.txt b/Documentation/git-daemon.txt
index 4b2ea2d..a72ed39 100644
--- a/Documentation/git-daemon.txt
+++ b/Documentation/git-daemon.txt
@@ -37,6 +37,8 @@ from `git-fetch`, `git-ls-remote`, and `
 This is ideally suited for read-only updates, i.e., pulling from
 git repositories.
 
+An `upload-archive` also exists to serve `git-archive`.
+
 OPTIONS
 -------
 --strict-paths::
@@ -155,6 +157,9 @@ upload-pack::
 	disable it by setting `daemon.uploadpack` configuration
 	item to `false`.
 
+upload-archive::
+	This serves `git-archive --remote`. 
+
 EXAMPLES
 --------
 git-daemon as inetd server::
-- 
