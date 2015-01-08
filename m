From: Alexander Kuleshov <kuleshovmail@gmail.com>
Subject: [PATCH 1/2] remote: Remove -v/--verbose option from git remote show synopsis
Date: Thu,  8 Jan 2015 23:57:43 +0600
Message-ID: <1420739863-11602-1-git-send-email-kuleshovmail@gmail.com>
Cc: git@vger.kernel.org, Alexander Kuleshov <kuleshovmail@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 08 18:58:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y9HLR-0000nl-HH
	for gcvg-git-2@plane.gmane.org; Thu, 08 Jan 2015 18:58:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932436AbbAHR6A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Jan 2015 12:58:00 -0500
Received: from mail-lb0-f182.google.com ([209.85.217.182]:57164 "EHLO
	mail-lb0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932432AbbAHR56 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Jan 2015 12:57:58 -0500
Received: by mail-lb0-f182.google.com with SMTP id u10so4190699lbd.13
        for <git@vger.kernel.org>; Thu, 08 Jan 2015 09:57:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=s/7Y8Tcz2a5vZ8gWOIZSBP6rese6MDzHp2TETMuPXQA=;
        b=D+0eBO0Q3ygu7MUn0fGnRLfy17vQ69Xjk7ci11ccXpoogBDvsaNRIofHVJorvsoAqg
         qWwo2mlA7GuUSzh9eApovnfCAb23KjCAnRraTwENQeQfN+0fuUW7nxoxScXEApvY/TSt
         ROxwSMJYqhtn/bgJvVAQWTK3TL4Fa+GwMUhKdhRd0Vlx04b7yQWrDBYxkqd459phbM3H
         QkI3qGHMJtIul97zr2KZuguE8WGgO2JpdC6E+aSp0tUyol7yJIuMh+jjtWzSFs79BAMk
         W+977cTdZrepePJxb2ZGQmAnF0z7WJKckC9PDqeCId5gRbZEHUu5ntQdpzrqepW7SmWm
         A2VQ==
X-Received: by 10.112.8.69 with SMTP id p5mr15939996lba.97.1420739877061;
        Thu, 08 Jan 2015 09:57:57 -0800 (PST)
Received: from localhost.localdomain ([95.59.128.28])
        by mx.google.com with ESMTPSA id vl1sm1291168lbb.21.2015.01.08.09.57.54
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 08 Jan 2015 09:57:56 -0800 (PST)
X-Mailer: git-send-email 2.2.1.364.g47473d1.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262203>

git remote show doesn't use -v/--verbose option

Signed-off-by: Alexander Kuleshov <kuleshovmail@gmail.com>
---
 builtin/remote.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/remote.c b/builtin/remote.c
index 46ecfd9..978c645 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -14,7 +14,7 @@ static const char * const builtin_remote_usage[] = {
 	N_("git remote rename <old> <new>"),
 	N_("git remote remove <name>"),
 	N_("git remote set-head <name> (-a | --auto | -d | --delete |<branch>)"),
-	N_("git remote [-v | --verbose] show [-n] <name>"),
+	N_("git remote show [-n] <name>"),
 	N_("git remote prune [-n | --dry-run] <name>"),
 	N_("git remote [-v | --verbose] update [-p | --prune] [(<group> | <remote>)...]"),
 	N_("git remote set-branches [--add] <name> <branch>..."),
-- 
2.2.1.364.g47473d1.dirty
