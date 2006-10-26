X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH (amend)] diff-format.txt: Correct information about pathnames quoting in patch format
Date: Thu, 26 Oct 2006 22:21:02 +0200
Message-ID: <200610262221.03266.jnareb@gmail.com>
References: <200610262103.31058.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Thu, 26 Oct 2006 20:21:15 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=mqi+3dlHrCssIzoC0DbiYTpUcu6IhvjScKdn1ntygR6bmIZ65a5XuU1H9Ls4YVN5K8BgCvIBfiP/fdgEfY7rgTBgRYf+2aoOv17WFYQ0XMJ29+TmMGTUeKtZFQGwEsjT03yBWWJAkjjnFpL3LsESDYPUsogJEO/z59AeFBZms/c=
User-Agent: KMail/1.9.3
In-Reply-To: <200610262103.31058.jnareb@gmail.com>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30261>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GdBiS-0003zR-0l for gcvg-git@gmane.org; Thu, 26 Oct
 2006 22:20:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1423491AbWJZUUZ (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 26 Oct 2006
 16:20:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423514AbWJZUUZ
 (ORCPT <rfc822;git-outgoing>); Thu, 26 Oct 2006 16:20:25 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:65526 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S1423491AbWJZUUY
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 26 Oct 2006 16:20:24 -0400
Received: by ug-out-1314.google.com with SMTP id 22so427175uga for
 <git@vger.kernel.org>; Thu, 26 Oct 2006 13:20:22 -0700 (PDT)
Received: by 10.66.220.17 with SMTP id s17mr3520582ugg; Thu, 26 Oct 2006
 13:20:22 -0700 (PDT)
Received: from host-81-190-23-110.torun.mm.pl ( [81.190.23.110]) by
 mx.google.com with ESMTP id j34sm784834ugc.2006.10.26.13.20.22; Thu, 26 Oct
 2006 13:20:22 -0700 (PDT)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
Discard previous version, please. This one should be correct.

 Documentation/diff-format.txt |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/diff-format.txt b/Documentation/diff-format.txt
index ed4ebcb..e4520e2 100644
--- a/Documentation/diff-format.txt
+++ b/Documentation/diff-format.txt
@@ -144,8 +144,10 @@ the file that rename/copy produces, resp
        dissimilarity index <number>
        index <hash>..<hash> <mode>
 
-3.  TAB, LF, and backslash characters in pathnames are
-    represented as `\t`, `\n`, and `\\`, respectively.
+3.  TAB, LF, double quote and backslash characters in pathnames
+    are represented as `\t`, `\n`, `\"` and `\\`, respectively.
+    If there is need for such substitution then the whole
+    pathname is put in double quotes.
 
 
 combined diff format
-- 
1.4.3.3
