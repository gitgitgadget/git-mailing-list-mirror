X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Yann Dirson <ydirson@altern.org>
Subject: [PATCH 2/3] More config examples.
Date: Thu, 30 Nov 2006 01:27:23 +0100
Message-ID: <20061130002723.21981.11262.stgit@gandelf.nowhere.earth>
References: <20061130002304.21981.67797.stgit@gandelf.nowhere.earth>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
NNTP-Posting-Date: Thu, 30 Nov 2006 00:29:11 +0000 (UTC)
Cc: GIT list <git@vger.kernel.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <20061130002304.21981.67797.stgit@gandelf.nowhere.earth>
User-Agent: StGIT/0.11
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32686>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GpZmS-0002Pj-QX for gcvg-git@gmane.org; Thu, 30 Nov
 2006 01:28:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S967727AbWK3A1z (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 29 Nov 2006
 19:27:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967728AbWK3A1z
 (ORCPT <rfc822;git-outgoing>); Wed, 29 Nov 2006 19:27:55 -0500
Received: from smtp5-g19.free.fr ([212.27.42.35]:33734 "EHLO
 smtp5-g19.free.fr") by vger.kernel.org with ESMTP id S967727AbWK3A1y (ORCPT
 <rfc822;git@vger.kernel.org>); Wed, 29 Nov 2006 19:27:54 -0500
Received: from bylbo.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net
 [81.57.214.146]) by smtp5-g19.free.fr (Postfix) with ESMTP id 89E63279CB;
 Thu, 30 Nov 2006 01:27:53 +0100 (CET)
Received: from gandelf.nowhere.earth ([10.0.0.5] ident=dwitch) by
 bylbo.nowhere.earth with esmtp (Exim 4.62) (envelope-from
 <ydirson@altern.org>) id 1GpZn3-0006B0-4N; Thu, 30 Nov 2006 01:28:37 +0100
To: Catalin Marinas <catalin.marinas@gmail.com>
Sender: git-owner@vger.kernel.org




Signed-off-by: Yann Dirson <ydirson@altern.org>
---

 examples/stgitrc |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/examples/stgitrc b/examples/stgitrc
index cc6e910..9ed2988 100644
--- a/examples/stgitrc
+++ b/examples/stgitrc
@@ -32,6 +32,7 @@
 
 # this value overrides the default PAGER environment variable
 #pager: ~/share/stgit/contrib/diffcol.sh
+#pager: filterdiff --annotate | colordiff | less -FRX
 
 # GIT pull command (should take the same arguments as git-pull)
