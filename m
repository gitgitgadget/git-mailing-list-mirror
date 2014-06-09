From: Jeremiah Mahler <jmmahler@gmail.com>
Subject: [PATCH] api-strbuf.txt minor typos
Date: Sun,  8 Jun 2014 20:32:03 -0700
Message-ID: <1402284723-14182-1-git-send-email-jmmahler@gmail.com>
Cc: Jeremiah Mahler <jmmahler@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 09 05:33:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WtqKR-0006f7-3y
	for gcvg-git-2@plane.gmane.org; Mon, 09 Jun 2014 05:32:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754299AbaFIDcz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Jun 2014 23:32:55 -0400
Received: from mail-pa0-f43.google.com ([209.85.220.43]:49122 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753992AbaFIDcy (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Jun 2014 23:32:54 -0400
Received: by mail-pa0-f43.google.com with SMTP id rd3so279493pab.2
        for <git@vger.kernel.org>; Sun, 08 Jun 2014 20:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=jLvPkarPOAGPVm7DLjOwvOZfQmhNLkyhmyoxR+r5d+A=;
        b=iva3uQGncQ/1bI4z9HVB38+7zxxqoBdgK1z1x3lb+66KxiBDFf4PLPVOXN3NuIHmFV
         TqAwiN8tRt0j9mIts1WrDNYc1DkIsMCpxZChfy5hco3KFCcw/RTOLqtxMOAFPdDSvmVN
         otCHjlUvyTHBgnn778U/8ydQL50HOMBtG74nMgYhSWz9PZWbVpCNWr/OJQja+lF0r+cC
         NYTRYyfQlx0/iLr0jIWjd7EXasvXa3DEZ8jgoP/0gbwFMt8WYAjd3Op7Ge3NWAxFbKCr
         f6uNlp2zw5H0jHeGVwy/icGEOuTxl2nvRF/37NioHFEddAv4/yzcL6iyi6Z3IKv4xjXP
         vAMg==
X-Received: by 10.66.142.199 with SMTP id ry7mr1962301pab.10.1402284773907;
        Sun, 08 Jun 2014 20:32:53 -0700 (PDT)
Received: from hudson (108-76-185-60.lightspeed.frokca.sbcglobal.net. [108.76.185.60])
        by mx.google.com with ESMTPSA id uk1sm5317144pac.26.2014.06.08.20.32.50
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sun, 08 Jun 2014 20:32:52 -0700 (PDT)
X-Google-Original-From: "Jeremiah Mahler" <jeri@hudson>
Received: by hudson (sSMTP sendmail emulation); Sun, 08 Jun 2014 20:32:49 -0700
X-Mailer: git-send-email 2.0.0.574.gc6f278f
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251057>

Fixed some minor typos in api-strbuf.txt: 'A' instead of 'An', 'have'
instead of 'has', a overlong line, and 'another' instead of 'an other'.

Signed-off-by: Jeremiah Mahler <jmmahler@gmail.com>
---
 Documentation/technical/api-strbuf.txt | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/technical/api-strbuf.txt b/Documentation/technical/api-strbuf.txt
index 077a709..f9c06a7 100644
--- a/Documentation/technical/api-strbuf.txt
+++ b/Documentation/technical/api-strbuf.txt
@@ -7,10 +7,10 @@ use the mem* functions than a str* one (memchr vs. strchr e.g.).
 Though, one has to be careful about the fact that str* functions often
 stop on NULs and that strbufs may have embedded NULs.
 
-An strbuf is NUL terminated for convenience, but no function in the
+A strbuf is NUL terminated for convenience, but no function in the
 strbuf API actually relies on the string being free of NULs.
 
-strbufs has some invariants that are very important to keep in mind:
+strbufs have some invariants that are very important to keep in mind:
 
 . The `buf` member is never NULL, so it can be used in any usual C
 string operations safely. strbuf's _have_ to be initialized either by
@@ -56,8 +56,8 @@ Data structures
 * `struct strbuf`
 
 This is the string buffer structure. The `len` member can be used to
-determine the current length of the string, and `buf` member provides access to
-the string itself.
+determine the current length of the string, and `buf` member provides
+access to the string itself.
 
 Functions
 ---------
@@ -202,7 +202,7 @@ strbuf_addstr(sb, "immediate string");
 
 `strbuf_addbuf`::
 
-	Copy the contents of an other buffer at the end of the current one.
+	Copy the contents of another buffer at the end of the current one.
 
 `strbuf_adddup`::
 
-- 
2.0.0.574.gc6f278f
