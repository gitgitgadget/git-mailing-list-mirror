From: Alexander Kuleshov <kuleshovmail@gmail.com>
Subject: [PATCH] hash-object: add -t and --no-filters options to the hash-object synopsis
Date: Wed, 21 Jan 2015 00:17:25 +0600
Message-ID: <1421777845-14880-1-git-send-email-kuleshovmail@gmail.com>
Cc: git@vger.kernel.org, Alexander Kuleshov <kuleshovmail@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 20 19:17:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YDdMv-0002BF-4T
	for gcvg-git-2@plane.gmane.org; Tue, 20 Jan 2015 19:17:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751930AbbATSRd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Jan 2015 13:17:33 -0500
Received: from mail-la0-f52.google.com ([209.85.215.52]:46811 "EHLO
	mail-la0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751506AbbATSRc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Jan 2015 13:17:32 -0500
Received: by mail-la0-f52.google.com with SMTP id hs14so35850703lab.11
        for <git@vger.kernel.org>; Tue, 20 Jan 2015 10:17:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=XrL8NW4LXhNUlYF1nfA/rIElJhguXuefWknmphVtHK4=;
        b=poHcEHNIKxHBRF4skFi8JSoQtXxa8X2j98BVS97vdGWWgQtbcGMjpuAsqohP1am7fX
         imXr59Op0HTMxjfrD1NHC1Met0tSacrUgN/ugXnhluhn8jvJx8uLle8fD+eAfMct+fPJ
         vWtI2+1NSkF+xbEjQoMInAJS58ghZFFNeHDsv9Y1/b+8eTXXk6L3Cdu8J6rkdTr+ikha
         iPTTxgKA1k8g2un6jti9X1b5Bq1uNF/Rg9FyIGFgyd5xntR7tFoiWhFitfPmZkbL+iHL
         dwpLVXFNUS6onWqVQgF5mCSti0pXl2LP4MCyhvjQgw14sATRH6kOXYmFvI26r+9/caWv
         bOBQ==
X-Received: by 10.112.85.11 with SMTP id d11mr40015855lbz.100.1421777850704;
        Tue, 20 Jan 2015 10:17:30 -0800 (PST)
Received: from localhost.localdomain ([5.251.238.70])
        by mx.google.com with ESMTPSA id qr10sm4189837lbb.30.2015.01.20.10.17.28
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 20 Jan 2015 10:17:29 -0800 (PST)
X-Mailer: git-send-email 2.3.0.rc0.286.ga3dc223.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262680>

Signed-off-by: Alexander Kuleshov <kuleshovmail@gmail.com>
---
 builtin/hash-object.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/hash-object.c b/builtin/hash-object.c
index 207b90c..a8100a7 100644
--- a/builtin/hash-object.c
+++ b/builtin/hash-object.c
@@ -80,7 +80,7 @@ int cmd_hash_object(int argc, const char **argv, const char *prefix)
 {
 	static const char * const hash_object_usage[] = {
 		N_("git hash-object [-t <type>] [-w] [--path=<file> | --no-filters] [--stdin] [--] <file>..."),
-		N_("git hash-object  --stdin-paths < <list-of-paths>"),
+		N_("git hash-object [-t <type>] [-w] --stdin-paths [--no-filters] < <list-of-paths>"),
 		NULL
 	};
 	const char *type = blob_type;
-- 
2.3.0.rc0.286.ga3dc223.dirty
