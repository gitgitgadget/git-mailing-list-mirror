From: Alexander Kuleshov <kuleshovmail@gmail.com>
Subject: [PATCH] Documentation/init-db.txt: minor style and synopsys fixes
Date: Wed, 14 Jan 2015 23:33:59 +0600
Message-ID: <1421256839-28660-1-git-send-email-kuleshovmail@gmail.com>
Cc: git@vger.kernel.org, Alexander Kuleshov <kuleshovmail@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 14 18:34:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YBRpe-0006Yo-AT
	for gcvg-git-2@plane.gmane.org; Wed, 14 Jan 2015 18:34:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752591AbbANReJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Jan 2015 12:34:09 -0500
Received: from mail-lb0-f181.google.com ([209.85.217.181]:35173 "EHLO
	mail-lb0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751363AbbANReI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jan 2015 12:34:08 -0500
Received: by mail-lb0-f181.google.com with SMTP id l4so9155621lbv.12
        for <git@vger.kernel.org>; Wed, 14 Jan 2015 09:34:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=XZHeeojUGVmXI2OfGo3a1EpTh8Cw3PuOtT8/ZgavarY=;
        b=eCM6JJjl0lYLY0gyeiHE51e7DFhTLDQxuhjuu9L2TnVHxMv4VHAKTGUV4hYb3Je9t5
         ZJuZLzNaQgCNaKdkSNLVK5+lRuhJ2euBeHM2GDUcqVi+e/qiaETa5pltHy0LUceM6Pw5
         AC+/5DgvczP7DHBGYCMRbhPJGmNqB4GKLGra0gkjFCiK1zQUIWjtwJlzaHSFd9q84fnk
         kxdgslH/kKgcLqpudxrSzeiHuxyVQ60ByXDffcMjK+Jc1l6HrlgA4SqRFzCkN5tsKtLf
         DIyyv+4Poe9eICgDfHF5ld8QJ9K6T9X/tLt5gTydtI51tQd5aKwwzO5HRMiPUL8Jujbp
         WVlw==
X-Received: by 10.152.1.2 with SMTP id 2mr5139521lai.89.1421256846079;
        Wed, 14 Jan 2015 09:34:06 -0800 (PST)
Received: from localhost.localdomain ([178.89.21.160])
        by mx.google.com with ESMTPSA id zs7sm6087654lbb.18.2015.01.14.09.34.03
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 14 Jan 2015 09:34:05 -0800 (PST)
X-Mailer: git-send-email 2.3.0.rc0.256.g0057d96
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262398>

This patch constists of two minor changes:

* line-wrap 'git init-db' synopsis

* last possible argument '[directory]' was missed

Signed-off-by: Alexander Kuleshov <kuleshovmail@gmail.com>
---
 Documentation/git-init-db.txt | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-init-db.txt b/Documentation/git-init-db.txt
index 648a6cd..1d94fe8 100644
--- a/Documentation/git-init-db.txt
+++ b/Documentation/git-init-db.txt
@@ -9,8 +9,9 @@ git-init-db - Creates an empty Git repository
 SYNOPSIS
 --------
 [verse]
-'git init-db' [-q | --quiet] [--bare] [--template=<template_directory>] [--separate-git-dir <git dir>] [--shared[=<permissions>]]
-
+'git init-db' [-q | --quiet] [--bare] [--template=<template_directory>]
+			  [--separate-git-dir <git dir>]
+			  [--shared[=<permissions>]] [directory]
 
 DESCRIPTION
 -----------
-- 
2.3.0.rc0.256.g0057d96
