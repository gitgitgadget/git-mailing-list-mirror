X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] Documentation/git-merge-file.txt: make asciidoc not complain
Date: Sun, 17 Dec 2006 15:48:12 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0612171546180.3635@wbgn013.biozentrum.uni-wuerzburg.de>
References: <86y7p7cssx.fsf@blue.stonehenge.com> <4584857D.703@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Sun, 17 Dec 2006 14:48:19 +0000 (UTC)
Cc: "Randal L. Schwartz" <merlyn@stonehenge.com>, git@vger.kernel.org,
	junkio@cox.net
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <4584857D.703@gmail.com>
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34692>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GvxJK-0003rw-9A for gcvg-git@gmane.org; Sun, 17 Dec
 2006 15:48:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1752739AbWLQOsP (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 17 Dec 2006
 09:48:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752740AbWLQOsP
 (ORCPT <rfc822;git-outgoing>); Sun, 17 Dec 2006 09:48:15 -0500
Received: from mail.gmx.net ([213.165.64.20]:56455 "HELO mail.gmx.net"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP id S1752739AbWLQOsP
 (ORCPT <rfc822;git@vger.kernel.org>); Sun, 17 Dec 2006 09:48:15 -0500
Received: (qmail invoked by alias); 17 Dec 2006 14:48:13 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp032) with SMTP; 17 Dec 2006 15:48:13 +0100
To: A Large Angry SCM <gitzilla@gmail.com>
Sender: git-owner@vger.kernel.org


Noticed by Randal L. Schwartz, this is a fix proposed by
A Large Angry SCM.

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
---

	On Sat, 16 Dec 2006, A Large Angry SCM wrote:

	> Randal L. Schwartz wrote:
	> > asciidoc -b xhtml11 -d manpage -f asciidoc.conf git-merge-file.txt
	> > ERROR: manpage document title is mandatory
	> > ERROR: git-merge-file.txt: line 3: title not permitted in sidebar body
	> > [...]
	> > make[1]: *** [git-merge-file.html] Error 1
	> > make: *** [doc] Error 2
	> 
	> Add 5 "=" to line 2.

	... which this patch does. This time, it is asciidoc-tested, too.

 Documentation/git-merge-file.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-merge-file.txt b/Documentation/git-merge-file.txt
index 0b41d66..09fe24f 100644
--- a/Documentation/git-merge-file.txt
+++ b/Documentation/git-merge-file.txt
@@ -1,5 +1,5 @@
 git-merge-file(1)
-============
+=================
 
 NAME
 ----
-- 
1.4.4.2.ga4be2-dirty
