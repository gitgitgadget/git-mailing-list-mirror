From: Andrew Wong <andrew.kw.w@gmail.com>
Subject: [PATCH] Documentation/githooks: Fix linkgit
Date: Fri,  1 Mar 2013 12:23:57 -0500
Message-ID: <1362158637-931-1-git-send-email-andrew.kw.w@gmail.com>
Cc: Andrew Wong <andrew.kw.w@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 01 18:29:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UBTmC-0000cg-PS
	for gcvg-git-2@plane.gmane.org; Fri, 01 Mar 2013 18:29:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751371Ab3CAR3R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Mar 2013 12:29:17 -0500
Received: from mail-ie0-f174.google.com ([209.85.223.174]:44629 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750886Ab3CAR3R (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Mar 2013 12:29:17 -0500
Received: by mail-ie0-f174.google.com with SMTP id k10so3776801iea.19
        for <git@vger.kernel.org>; Fri, 01 Mar 2013 09:29:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer;
        bh=VDbqTgum+gWIrIe3IgVbYEVcvBb+TwpismWEF7mSXtw=;
        b=yszB6S/R1dzXo4UgqSEteL+j0GSHEyk8q1hutGRjjPYvRH7oO+9jfCOGpaTwoxiaJ7
         N9F/M0+684wAUZGB7LIzrvlxhUIgvCkAdfFMRM8oyXfxL5TSssQMKJ2SWst6HSziTmar
         qRZ4l6yH70bFXSoToGJ4F8wZoXQcWejl8dpf8pJ6eg6GVSd3nBM/HuDklJDBuY0TgsBU
         xGTCS8Oags49UBqbGn8O4x/WV0VpnnZU8owaC7ytVZsWr28ZeM3sazuRwCsq+6C2bj5O
         oOUDzem56tbbVp6Tb/uPnWzQmzESkalqJvqLhkqxrVRmLtv40vKjKmMYivrIIkPb9Duk
         0w9w==
X-Received: by 10.50.12.229 with SMTP id b5mr7008043igc.105.1362158956737;
        Fri, 01 Mar 2013 09:29:16 -0800 (PST)
Received: from localhost.localdomain ([69.165.234.69])
        by mx.google.com with ESMTPS id ip8sm14172216igc.4.2013.03.01.09.29.15
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 01 Mar 2013 09:29:16 -0800 (PST)
X-Mailer: git-send-email 1.8.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217283>

Signed-off-by: Andrew Wong <andrew.kw.w@gmail.com>
---
 Documentation/githooks.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
index 8181e4e..eab9b35 100644
--- a/Documentation/githooks.txt
+++ b/Documentation/githooks.txt
@@ -365,7 +365,7 @@ preceding SP is also omitted.  Currently, no commands pass any
 'extra-info'.
 
 The hook always runs after the automatic note copying (see
-"notes.rewrite.<command>" in linkgit:git-config.txt) has happened, and
+"notes.rewrite.<command>" in linkgit:git-config.txt[1]) has happened, and
 thus has access to these notes.
 
 The following command-specific comments apply:
-- 
1.8.2.rc0.22.gb3600c3
