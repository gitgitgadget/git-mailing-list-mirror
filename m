From: Alexander Kuleshov <kuleshovmail@gmail.com>
Subject: [PATCH 2/2] Documentation: Remove -v/--verbose option from git remote show synopsis
Date: Thu,  8 Jan 2015 23:58:00 +0600
Message-ID: <1420739880-11655-1-git-send-email-kuleshovmail@gmail.com>
Cc: git@vger.kernel.org, Alexander Kuleshov <kuleshovmail@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 08 18:58:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y9HLt-00033r-AX
	for gcvg-git-2@plane.gmane.org; Thu, 08 Jan 2015 18:58:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932466AbbAHR6J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Jan 2015 12:58:09 -0500
Received: from mail-la0-f41.google.com ([209.85.215.41]:44622 "EHLO
	mail-la0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932438AbbAHR6G (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Jan 2015 12:58:06 -0500
Received: by mail-la0-f41.google.com with SMTP id hv19so10561403lab.0
        for <git@vger.kernel.org>; Thu, 08 Jan 2015 09:58:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=iTst78wclcsm8tbtM1I5sRYhjvxKppEQn96PB/snc8E=;
        b=JrrYKCIpikernukHlDrrys8GybBtF4Q1E4VGenmlmuGwpuv15txxZpO4rWWZk9ZCh3
         JNw03tjFFyavyInkbb2v/siCDw1iA1tghXiKjcOkZ5lhZpfw2DlUGtSF2XEMkXaHND2y
         q+cf7qZ+K8D/0MKHZsHuLV8jZ9txi5HQxvbO9wPXjsgxQHXk06nbdO8ZKbmq35A8XCP9
         jGZS3luYcSuJJiklO2cXuzLsVh/9BDGjmOS5FnYUNVxHP5tFBVgzHBp1pxxUIXAOFNP6
         R8/SYCNQSnVhziPJC+izOkXznznIAeWCtNZyVuYLSYevFAQ3ixKRK7AzvcxlrasvywxX
         T2HA==
X-Received: by 10.152.238.1 with SMTP id vg1mr16152856lac.83.1420739885036;
        Thu, 08 Jan 2015 09:58:05 -0800 (PST)
Received: from localhost.localdomain ([95.59.128.28])
        by mx.google.com with ESMTPSA id ki4sm1289353lac.1.2015.01.08.09.58.03
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 08 Jan 2015 09:58:04 -0800 (PST)
X-Mailer: git-send-email 2.2.1.364.g47473d1.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262202>

git remote show doesn't use -v/--verbose option

Signed-off-by: Alexander Kuleshov <kuleshovmail@gmail.com>
---
 Documentation/git-remote.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-remote.txt b/Documentation/git-remote.txt
index cb103c8..07eb668 100644
--- a/Documentation/git-remote.txt
+++ b/Documentation/git-remote.txt
@@ -18,7 +18,7 @@ SYNOPSIS
 'git remote set-url' [--push] <name> <newurl> [<oldurl>]
 'git remote set-url --add' [--push] <name> <newurl>
 'git remote set-url --delete' [--push] <name> <url>
-'git remote' [-v | --verbose] 'show' [-n] <name>...
+'git remote show' [-n] <name>...
 'git remote prune' [-n | --dry-run] <name>...
 'git remote' [-v | --verbose] 'update' [-p | --prune] [(<group> | <remote>)...]
 
-- 
2.2.1.364.g47473d1.dirty
