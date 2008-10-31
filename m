From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH] Documentation/gitattributes: Add subsection header for each attribute
Date: Fri, 31 Oct 2008 23:24:55 +0100
Message-ID: <1225491895-31987-1-git-send-email-jnareb@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 31 23:28:25 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kw2S8-0007HO-KF
	for gcvg-git-2@gmane.org; Fri, 31 Oct 2008 23:26:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753419AbYJaWZf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Oct 2008 18:25:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752535AbYJaWZe
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Oct 2008 18:25:34 -0400
Received: from ik-out-1112.google.com ([66.249.90.178]:23229 "EHLO
	ik-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753402AbYJaWZd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Oct 2008 18:25:33 -0400
Received: by ik-out-1112.google.com with SMTP id c29so441705ika.5
        for <git@vger.kernel.org>; Fri, 31 Oct 2008 15:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:from:to:cc
         :subject:date:message-id:x-mailer;
        bh=KiixLVN9X9KXjw0jW7/4ucmE97ZsgBKvwqQc90OevNM=;
        b=WjuW5n46hf3j7nfhyYJRZmFeuCqmJDwFi2ylR1BDgS+esyiRdnL72fJklhlSDrQGZl
         kOj6JtLUxbGSbVAG++4tLH5CYPE0LcWyY5y+FbEBH7id8u34VZQ6i8jJsJcOIVCnGYmE
         +mh2ErNBOfoXxWbjdtd6Dk6KVYbqUQfILsiFs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=dF4RB3WXKb5AoDKwr1146vszZA29wK4/Qy/WbLI47OzrTqdoED7GdIj+kdoVSLjvnJ
         +1lKV3uPFpvF1qzWrVNXBnP6NN1Nb5EKes6dZOB7XaFwuperhtKG9G+zjOoTCI3/PpUM
         gg3eGHxK4GxjCTPjiEQ6F4Jv5jz+mbxGmOfnw=
Received: by 10.210.11.13 with SMTP id 13mr2980551ebk.176.1225491931870;
        Fri, 31 Oct 2008 15:25:31 -0700 (PDT)
Received: from localhost.localdomain (abwk207.neoplus.adsl.tpnet.pl [83.8.234.207])
        by mx.google.com with ESMTPS id 20sm4844446eyk.4.2008.10.31.15.25.29
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 31 Oct 2008 15:25:30 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m9VMP6hU032015;
	Fri, 31 Oct 2008 23:25:11 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m9VMOtK1032012;
	Fri, 31 Oct 2008 23:24:55 +0100
X-Mailer: git-send-email 1.6.0.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99661>

This makes attributes easier to find; before this patch some
attributes had individual subsections, and some didn't.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
 Documentation/gitattributes.txt |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
index 24e880c..eb64841 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -213,6 +213,9 @@ with `crlf`, and then `ident` and fed to `filter`.
 Generating diff text
 ~~~~~~~~~~~~~~~~~~~~
 
+`diff`
+^^^^^^
+
 The attribute `diff` affects if 'git-diff' generates textual
 patch for the path or just says `Binary files differ`.  It also
 can affect what line is shown on the hunk header `@@ -k,l +n,m @@`
@@ -331,6 +334,9 @@ patterns are available:
 Performing a three-way merge
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
+`merge`
+^^^^^^^
+
 The attribute `merge` affects how three versions of a file is
 merged when a file-level merge is necessary during `git merge`,
 and other programs such as `git revert` and `git cherry-pick`.
-- 
1.6.0.3
