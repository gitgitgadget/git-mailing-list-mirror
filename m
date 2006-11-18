X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Petr Baudis <pasky@suse.cz>
Subject: [PATCH] git-apply: Documentation typo fix
Date: Sat, 18 Nov 2006 06:05:11 +0100
Message-ID: <20061118050511.13383.11467.stgit@machine.or.cz>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
NNTP-Posting-Date: Sat, 18 Nov 2006 05:05:27 +0000 (UTC)
Cc: <git@vger.kernel.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: StGIT/0.11
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31756>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GlIOJ-0005HE-K7 for gcvg-git@gmane.org; Sat, 18 Nov
 2006 06:05:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1753810AbWKRFFO (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 18 Nov 2006
 00:05:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753018AbWKRFFO
 (ORCPT <rfc822;git-outgoing>); Sat, 18 Nov 2006 00:05:14 -0500
Received: from w241.dkm.cz ([62.24.88.241]:464 "EHLO machine.or.cz") by
 vger.kernel.org with ESMTP id S1753810AbWKRFFM (ORCPT
 <rfc822;git@vger.kernel.org>); Sat, 18 Nov 2006 00:05:12 -0500
Received: (qmail 13393 invoked from network); 18 Nov 2006 06:05:11 +0100
Received: from localhost (HELO machine.or.cz) (xpasky@127.0.0.1) by localhost
 with SMTP; 18 Nov 2006 06:05:11 +0100
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

inacurate -> inaccurate, sorry if it was a pun. ;-)

Signed-off-by: Petr Baudis <pasky@suse.cz>
---

 Documentation/git-apply.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-apply.txt b/Documentation/git-apply.txt
index d9137c7..2cc32d1 100644
--- a/Documentation/git-apply.txt
+++ b/Documentation/git-apply.txt
@@ -150,7 +150,7 @@ discouraged.
 * `strip` outputs warnings for a few such errors, strips out the
   trailing whitespaces and applies the patch.
 
---inacurate-eof::
+--inaccurate-eof::
 	Under certain circumstances, some versions of diff do not correctly
 	detect a missing new-line at the end of the file. As a result, patches
