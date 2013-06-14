From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 1/5] stash doc: add a warning about using create
Date: Fri, 14 Jun 2013 16:02:00 +0530
Message-ID: <1371205924-8982-2-git-send-email-artagnon@gmail.com>
References: <1371205924-8982-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jun 14 12:30:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UnRHC-0000Kx-Dc
	for gcvg-git-2@plane.gmane.org; Fri, 14 Jun 2013 12:30:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752088Ab3FNKaV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Jun 2013 06:30:21 -0400
Received: from mail-pd0-f169.google.com ([209.85.192.169]:36390 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751972Ab3FNKaO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Jun 2013 06:30:14 -0400
Received: by mail-pd0-f169.google.com with SMTP id y10so448230pdj.0
        for <git@vger.kernel.org>; Fri, 14 Jun 2013 03:30:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=l+KIyu5fS2Sos/X+FIVWWR23fABcMd+Klfc0/hm7YNI=;
        b=Q33nqFkLcAU2kE+c+tdvRD8UjaMrP2lT0Dwc2XDlFkejmuPQEajPTB3oEwK4CUpLBK
         g4XWXH4UFZfOj4t93BZHymT3bwhnFBVabkB7/nkxAlg+MOq+rxJJA2nYYhZaLJhOGl5E
         RJQ6wxP3Qnp6npZmXhrWVi/4qhvAXiGHQAaishH8g/lmKI7yvAWizrNOQT85W6nv2GZt
         S6bv3Ou43yqEQzhXb8NFPr/3F5f6/oycYeHESGTAIaXaSp6of9jWvf65HAguvzgf3toG
         hrS0Qpntrx0SCTXDcO38bsdwUcvoQCumy7fWG4atBHZ3fI+7CTuvYU8tJJ9+zLusdXa3
         Xrpg==
X-Received: by 10.68.226.99 with SMTP id rr3mr1945027pbc.35.1371205813761;
        Fri, 14 Jun 2013 03:30:13 -0700 (PDT)
Received: from luneth.maa.corp.collab.net ([182.71.239.158])
        by mx.google.com with ESMTPSA id xj9sm1809871pbc.16.2013.06.14.03.30.11
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 14 Jun 2013 03:30:12 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1.383.g0d5ad6b
In-Reply-To: <1371205924-8982-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227804>

Add a note saying that the user probably wants "save" in the create
description.  While at it, document that it can optionally take a
message in the synopsis.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 Documentation/git-stash.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-stash.txt b/Documentation/git-stash.txt
index 711ffe1..83bb3db 100644
--- a/Documentation/git-stash.txt
+++ b/Documentation/git-stash.txt
@@ -16,7 +16,7 @@ SYNOPSIS
 'git stash' [save [--patch] [-k|--[no-]keep-index] [-q|--quiet]
 	     [-u|--include-untracked] [-a|--all] [<message>]]
 'git stash' clear
-'git stash' create
+'git stash' create [<message>]
 
 DESCRIPTION
 -----------
@@ -151,6 +151,7 @@ create::
 
 	Create a stash (which is a regular commit object) and return its
 	object name, without storing it anywhere in the ref namespace.
+	This is probably not what you want to use; see "save" above.
 
 
 DISCUSSION
-- 
1.8.3.1.383.g0d5ad6b
