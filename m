From: Karsten Blees <karsten.blees@gmail.com>
Subject: [PATCH 1/2] gitignore.txt: fix documentation of "**" patterns
Date: Thu, 07 Nov 2013 17:30:47 +0100
Message-ID: <527BC037.2000106@gmail.com>
References: <527BC00D.8000501@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Duy Nguyen <pclouds@gmail.com>,
	Karsten Blees <karsten.blees@gmail.com>
To: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 07 17:30:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VeSTp-0004YZ-Up
	for gcvg-git-2@plane.gmane.org; Thu, 07 Nov 2013 17:30:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754458Ab3KGQaq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Nov 2013 11:30:46 -0500
Received: from mail-bk0-f46.google.com ([209.85.214.46]:45666 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753329Ab3KGQap (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Nov 2013 11:30:45 -0500
Received: by mail-bk0-f46.google.com with SMTP id e11so332673bkh.19
        for <git@vger.kernel.org>; Thu, 07 Nov 2013 08:30:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=Q8uB8F0rvNhN+Lf28ik4unBUfMc3PtSEpkdqUb0nbsU=;
        b=ndrwsVP1D793VCQCMoRYHBmM7bpz3UmOCHwv7+7shE80Atnin10/tBg3moGZlNpHjQ
         ZGJSC0fWXSN9rNfK8lf2OYYfOuE1e5PEqaIAmRu0oYP6uGw1tSk2xC4saYuOJMIgkdPn
         kBsSiATlqLtEkMmsGemWgqGTmf7q3ZahM50RU7LaLJiCzUlDrdQxT/H1NoLjbA8+7QWM
         hWbiCsJOSG7UGrz2mis1r/ztJe48d/LkQw0Deiu8rua8vJpRhflOr8CpLmKLnqjP4ZV5
         zOjbnBIERc7k0JX+K7PJ8mUw56KbVi0rnbuVVg6yW6MonrL0q6zp6pMJasfiypTJRCg2
         dZsA==
X-Received: by 10.204.2.140 with SMTP id 12mr2207823bkj.47.1383841844281;
        Thu, 07 Nov 2013 08:30:44 -0800 (PST)
Received: from [10.1.100.55] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id pu8sm2884033bkb.9.2013.11.07.08.30.42
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 07 Nov 2013 08:30:43 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.1.0
In-Reply-To: <527BC00D.8000501@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237415>

"**" means bold in ASCIIDOC, so we need to escape it.

Signed-off-by: Karsten Blees <blees@dcon.de>
---
 Documentation/gitignore.txt | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/gitignore.txt b/Documentation/gitignore.txt
index 54e334e..f971960 100644
--- a/Documentation/gitignore.txt
+++ b/Documentation/gitignore.txt
@@ -113,12 +113,12 @@ full pathname may have special meaning:
 
  - A leading "`**`" followed by a slash means match in all
    directories. For example, "`**/foo`" matches file or directory
-   "`foo`" anywhere, the same as pattern "`foo`". "**/foo/bar"
+   "`foo`" anywhere, the same as pattern "`foo`". "`**/foo/bar`"
    matches file or directory "`bar`" anywhere that is directly
    under directory "`foo`".
 
- - A trailing "/**" matches everything inside. For example,
-   "abc/**" matches all files inside directory "abc", relative
+ - A trailing "`/**`" matches everything inside. For example,
+   "`abc/**`" matches all files inside directory "`abc`", relative
    to the location of the `.gitignore` file, with infinite depth.
 
  - A slash followed by two consecutive asterisks then a slash
-- 
1.8.4.msysgit.0.12.g88f5ed0
