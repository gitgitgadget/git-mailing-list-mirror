From: Alexander Kuleshov <kuleshovmail@gmail.com>
Subject: [PATCH 3/3] Documentation/git-hash-object.txt: add verbose option for hash-object
Date: Mon,  2 Mar 2015 19:55:35 +0600
Message-ID: <1425304535-14484-1-git-send-email-kuleshovmail@gmail.com>
References: <1425304500-14117-1-git-send-email-kuleshovmail@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Alexander Kuleshov <kuleshovmail@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 02 14:56:03 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YSQpG-0005nR-PB
	for gcvg-git-2@plane.gmane.org; Mon, 02 Mar 2015 14:56:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754071AbbCBNz7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Mar 2015 08:55:59 -0500
Received: from mail-la0-f54.google.com ([209.85.215.54]:45519 "EHLO
	mail-la0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753997AbbCBNzl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Mar 2015 08:55:41 -0500
Received: by labge10 with SMTP id ge10so30329603lab.12
        for <git@vger.kernel.org>; Mon, 02 Mar 2015 05:55:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Kk5KuR4MWpsy0jRRFM+TmIuAxI0sEP+7yvcyu5J0Mgg=;
        b=ifyCXUIwrxROY/ljOxasjQmhsUvEFjMuwVkBQ3a9aPGCCXW75vUPeKcgui+MX5uMPk
         rHv+CsCiFKRJBAKdh+3wq5/rHMEqPDMVI7xC1dQU4FKBMUXK4p1ZHcAsDXrJcC8ZnnMK
         Z/kSSTNTH9EdxjdmLSfHF7jSmm8GXgRXtZHwDmwPgMDU2IX+7PJdLRZ/E/hUdThNLIzq
         fXYhBGZwksFzJNLC92k0it8qliBa99AtgdQRpf/HUebG8Rl/+RJjYzcn5HCjrVis34b+
         eriObRBPswx5p4nEaZLUzXELTpp2Kf/hlRtRqH0+l4Wob0kJ/93+ok3V6kazrFogVWZQ
         P+XA==
X-Received: by 10.152.87.134 with SMTP id ay6mr23767882lab.75.1425304539550;
        Mon, 02 Mar 2015 05:55:39 -0800 (PST)
Received: from localhost.localdomain ([147.30.48.224])
        by mx.google.com with ESMTPSA id uf3sm2547461lbc.44.2015.03.02.05.55.37
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 02 Mar 2015 05:55:38 -0800 (PST)
X-Mailer: git-send-email 2.3.1.167.g7f4ba4b.dirty
In-Reply-To: <1425304500-14117-1-git-send-email-kuleshovmail@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264597>

Signed-off-by: Alexander Kuleshov <kuleshovmail@gmail.com>
---
 Documentation/git-hash-object.txt | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-hash-object.txt b/Documentation/git-hash-object.txt
index 02c1f12..efec7c6 100644
--- a/Documentation/git-hash-object.txt
+++ b/Documentation/git-hash-object.txt
@@ -9,8 +9,8 @@ git-hash-object - Compute object ID and optionally creates a blob from a file
 SYNOPSIS
 --------
 [verse]
-'git hash-object' [-t <type>] [-w] [--path=<file>|--no-filters] [--stdin] [--] <file>...
-'git hash-object' [-t <type>] [-w] --stdin-paths [--no-filters] < <list-of-paths>
+'git hash-object' [-t <type>] [-w] [-v] [--path=<file>|--no-filters] [--stdin] [--] <file>...
+'git hash-object' [-t <type>] [-w] [-v] --stdin-paths [--no-filters] < <list-of-paths>
 
 DESCRIPTION
 -----------
@@ -31,6 +31,9 @@ OPTIONS
 -w::
 	Actually write the object into the object database.
 
+-v::
+	Prints file path near the hash.
+
 --stdin::
 	Read the object from standard input instead of from a file.
 
-- 
2.3.1.167.g7f4ba4b.dirty
