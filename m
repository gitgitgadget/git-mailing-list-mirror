From: Alexander Kuleshov <kuleshovmail@gmail.com>
Subject: [PATCH 2/2] Documentation/git-init-db.txt: minor style fixes
Date: Fri, 16 Jan 2015 00:16:28 +0600
Message-ID: <1421345788-4811-1-git-send-email-kuleshovmail@gmail.com>
Cc: git@vger.kernel.org, Alexander Kuleshov <kuleshovmail@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 15 19:16:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YBoyG-0007FI-K5
	for gcvg-git-2@plane.gmane.org; Thu, 15 Jan 2015 19:16:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752926AbbAOSQg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Jan 2015 13:16:36 -0500
Received: from mail-la0-f50.google.com ([209.85.215.50]:33117 "EHLO
	mail-la0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752818AbbAOSQf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Jan 2015 13:16:35 -0500
Received: by mail-la0-f50.google.com with SMTP id pn19so15034153lab.9
        for <git@vger.kernel.org>; Thu, 15 Jan 2015 10:16:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=/ijexHtzMVkOUNztwfDGpyleFvRfSI7G5BFph1LdyD0=;
        b=Hdl+JJLsEJKtULiN/pmrig8Ht6zxwlggpHCWT/DpqTZoiEu8vHCzFKO9ZUxSy9+YNg
         q/X5a6m27o2vPBRem6tDFW83ZKkPuhP4iV5h/bK8Pmh10x4A8tHkNPdYjV+oyidbvvCj
         57HFVEEv9znnHtrdfmgu/MPEmM2S7JnizoUp88uqB6J/JRdU3cC/+JG78kGyNNFNqfcM
         N8H5G7zY8AE9wfBawQx9uB2crRupst43GYejlLvvZ77X4y+TPIa0KozHxsjBouZxczul
         5x5ZdTuei07QfqKjLdkzdX8KzuU6m8LXYh8sg5A0x9gRfyZdZdgpaw1UpIWQBkgGgWfh
         pQjg==
X-Received: by 10.152.238.1 with SMTP id vg1mr11441266lac.83.1421345793734;
        Thu, 15 Jan 2015 10:16:33 -0800 (PST)
Received: from localhost.localdomain ([95.59.93.191])
        by mx.google.com with ESMTPSA id t10sm807073lat.31.2015.01.15.10.16.31
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 15 Jan 2015 10:16:33 -0800 (PST)
X-Mailer: git-send-email 2.3.0.rc0.315.g0e14eda
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262498>

* line-wrap 'git init-db' synopsis
* last possible argument '[<directory>]' was missed

Signed-off-by: Alexander Kuleshov <kuleshovmail@gmail.com>
---
 Documentation/git-init-db.txt | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-init-db.txt b/Documentation/git-init-db.txt
index 648a6cd..b66da6d 100644
--- a/Documentation/git-init-db.txt
+++ b/Documentation/git-init-db.txt
@@ -9,7 +9,9 @@ git-init-db - Creates an empty Git repository
 SYNOPSIS
 --------
 [verse]
-'git init-db' [-q | --quiet] [--bare] [--template=<template_directory>] [--separate-git-dir <git dir>] [--shared[=<permissions>]]
+'git init-db' [-q | --quiet] [--bare] [--template=<template-directory>]
+	     [--separate-git-dir <git-dir>]
+	     [--shared[=<permissions>]] [<directory>]
 
 
 DESCRIPTION
-- 
2.3.0.rc0.315.g0e14eda
