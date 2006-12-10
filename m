X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-2.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD,
	SUBJ_ALL_CAPS shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
From: Clemens Buchacher <clemens.buchacher@fh-hagenberg.at>
Subject: *** SPAM ***
Date: Sun, 10 Dec 2006 14:57:53 +0100
Message-ID: <20061210135753.GA12905@kzelldran.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sun, 10 Dec 2006 13:57:14 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
X-OriginalArrivalTime: 10 Dec 2006 13:56:54.0649 (UTC) FILETIME=[0CDCDE90:01C71C63]
X-Junk-Mail: 
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33889>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GtPB0-0001wo-0r for gcvg-git@gmane.org; Sun, 10 Dec
 2006 14:57:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1760759AbWLJN45 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 10 Dec 2006
 08:56:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760762AbWLJN45
 (ORCPT <rfc822;git-outgoing>); Sun, 10 Dec 2006 08:56:57 -0500
Received: from postman.fh-hagenberg.at ([193.170.124.96]:47592 "EHLO
 postman.fh-hagenberg.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S1760759AbWLJN44 (ORCPT <rfc822;git@vger.kernel.org>); Sun, 10 Dec
 2006 08:56:56 -0500
Received: from kzelldran.dyndns.org ([84.154.115.16]) by
 postman.fh-hagenberg.at over TLS secured channel with Microsoft
 SMTPSVC(6.0.3790.1830); Sun, 10 Dec 2006 14:56:53 +0100
Received: from drizzd by kzelldran.dyndns.org with local (Exim 4.63)
 (envelope-from <drizzd@kzelldran.dyndns.org>) id 1GtPBh-0003Ni-Mn for
 git@vger.kernel.org; Sun, 10 Dec 2006 14:57:53 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Make sure $EDITOR is executed as a command

---
commit 942341e051fdcbb77a6abfbc58cf08ef8cab388d
tree 96e8fd08cdc7c59b0d3d55d7cb5b4302db443aff
parent b6a6e87cb3e1368ad0f78c18fdb6c29dde4ae83e
author Clemens Buchacher <drizzd@aon.at> Sun, 10 Dec 2006 14:37:37 +0100
committer Clemens Buchacher <drizzd@aon.at> Sun, 10 Dec 2006 14:37:37 +0100

 cg-Xlib |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/cg-Xlib b/cg-Xlib
index c1262bf..9d04eb4 100755
--- a/cg-Xlib
+++ b/cg-Xlib
@@ -568,7 +568,7 @@ _editor()
 	actionname="$1"; shift
 	actionkey="$1"; shift
 
-	${EDITOR:-vi} "$LOGMSG2"
+	command ${EDITOR:-vi} "$LOGMSG2"
 	[ -z "$force" ] || return 0
 	[ ! "$LOGMSG2" -nt "$LOGMSG" ] || return 0
