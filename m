X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 11/10] Corrected typo in format-patch bash completion.
Date: Mon, 27 Nov 2006 03:54:46 -0500
Message-ID: <20061127085446.GA19884@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Mon, 27 Nov 2006 08:54:57 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32403>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GocGM-0001ik-F0 for gcvg-git@gmane.org; Mon, 27 Nov
 2006 09:54:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1757481AbWK0Iyv (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 27 Nov 2006
 03:54:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757487AbWK0Iyv
 (ORCPT <rfc822;git-outgoing>); Mon, 27 Nov 2006 03:54:51 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:39309 "EHLO
 corvette.plexpod.net") by vger.kernel.org with ESMTP id S1757481AbWK0Iyu
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 27 Nov 2006 03:54:50 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1GocGE-0005AU-UV; Mon, 27 Nov 2006 03:54:47 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 26E8D20FB7F; Mon, 27 Nov 2006 03:54:47 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 This is in addition to the other 10 patches I just sent.
 It fixes the bad --in-reply-to option in patch 5/10.
 
 contrib/completion/git-completion.bash |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index df67f8e..47b393d 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -346,7 +346,7 @@ _git_format_patch ()
 			--numbered --start-number
 			--keep-subject
 			--signoff
-			--in-repy-to=
+			--in-reply-to=
 			--full-index --binary
 			" -- "$cur"))
 		return
-- 
