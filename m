X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH] diff-format.txt: Expand information about pathnames quoting in patch format
Date: Thu, 26 Oct 2006 21:03:30 +0200
Message-ID: <200610262103.31058.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Thu, 26 Oct 2006 19:03:37 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=GGDfTYDNjaZNDqHnnTen/9NYY8SPMgCThKnfpB4p5Vjkij3q9Qnkf68SLdFTOwmz61sJs9SaFnz0lTuVoSIe7h4cMbUUrEleZj3NM2hSXogWrA3Zkt2l+h5goUYt/dF/3p+iqG+5+r9g2p4UtAtUXhNuHtAUeG8sSPvpsU7CVP4=
User-Agent: KMail/1.9.3
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30259>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GdAVV-00055v-U8 for gcvg-git@gmane.org; Thu, 26 Oct
 2006 21:03:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1423724AbWJZTC6 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 26 Oct 2006
 15:02:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423679AbWJZTC6
 (ORCPT <rfc822;git-outgoing>); Thu, 26 Oct 2006 15:02:58 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:16427 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S1423724AbWJZTC5
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 26 Oct 2006 15:02:57 -0400
Received: by ug-out-1314.google.com with SMTP id 32so462005ugm for
 <git@vger.kernel.org>; Thu, 26 Oct 2006 12:02:55 -0700 (PDT)
Received: by 10.66.252.4 with SMTP id z4mr3383056ugh; Thu, 26 Oct 2006
 12:02:55 -0700 (PDT)
Received: from host-81-190-23-110.torun.mm.pl ( [81.190.23.110]) by
 mx.google.com with ESMTP id 32sm956556ugf.2006.10.26.12.02.55; Thu, 26 Oct
 2006 12:02:55 -0700 (PDT)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
 Documentation/diff-format.txt |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/Documentation/diff-format.txt b/Documentation/diff-format.txt
index ed4ebcb..f980ecf 100644
--- a/Documentation/diff-format.txt
+++ b/Documentation/diff-format.txt
@@ -146,6 +146,9 @@ the file that rename/copy produces, resp
 
 3.  TAB, LF, and backslash characters in pathnames are
     represented as `\t`, `\n`, and `\\`, respectively.
+    If there is need to quote pathname then the whole
+    pathname is put in double quotes, and quote characters
+    in pathname are represented as `\"`.
 
 
 combined diff format
-- 
1.4.3.3
