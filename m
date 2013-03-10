From: Paul Campbell <pcampbell@kemitix.net>
Subject: [PATCH v2 18/23] contrib/subtree: Add missing commands to SYNOPSIS
Date: Sun, 10 Mar 2013 23:41:26 +0000
Message-ID: <1362958891-26941-19-git-send-email-pcampbell@kemitix.net>
References: <1362958891-26941-1-git-send-email-pcampbell@kemitix.net>
Cc: David Greene <greened@obbligato.org>,
	Herman van Rink <rink@initfour.nl>,
	Paul Campbell <pcampbell@kemitix.net>,
	"Avery Pennarun" <apenwarr@gmail.com>,
	"John Yani" <vanuan@gmail.com>
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Mar 11 00:45:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UEpw6-00055w-CT
	for gcvg-git-2@plane.gmane.org; Mon, 11 Mar 2013 00:45:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753462Ab3CJXpU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Mar 2013 19:45:20 -0400
Received: from mail-wi0-f177.google.com ([209.85.212.177]:38514 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751801Ab3CJXpS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Mar 2013 19:45:18 -0400
Received: by mail-wi0-f177.google.com with SMTP id hm14so610789wib.4
        for <git@vger.kernel.org>; Sun, 10 Mar 2013 16:45:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:x-gm-message-state;
        bh=lakNNHdGw2E6FFlK2m35smPwq+SUnqWgc8Ge+SXh4XE=;
        b=aWlAsoFa/nnSEsLRVn7M1vnPD4TfwIvPw1IXfVnnXkAr59XCQsOf3JqVybawYzaMd7
         ZhJe2n4999Jir3KdbYwQckB9uQLJwOfZGWyNZgdy25LPr0k+z0cbbTZganue9cHiduBv
         i2utw1XO7yZEK4W6Phy3EENCH2ywsyfQrthaBN2KxxQPBSLU/pewgiB40hj+11XlOSvv
         r90MiVGEYjZ+UuXFaf/6j0VYaX+iK3ZlcCd7K0B1cNOBK2zTw4QbjyCw2uU793DNjgCr
         aLpjm3YlPLQ85MUnKopVIiAkt+hlq+l0xrp3LR9a+U04yeoWKJmzPTAtJ1FEzgwy+3Aw
         3+ZA==
X-Received: by 10.180.84.8 with SMTP id u8mr9163248wiy.1.1362959117329;
        Sun, 10 Mar 2013 16:45:17 -0700 (PDT)
Received: from coyote.home (host-2-102-87-75.as13285.net. [2.102.87.75])
        by mx.google.com with ESMTPS id r7sm13757148wiz.2.2013.03.10.16.45.13
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sun, 10 Mar 2013 16:45:16 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.rc1
In-Reply-To: <1362958891-26941-1-git-send-email-pcampbell@kemitix.net>
X-Gm-Message-State: ALoCoQlFocIc0pv8H6yR5gIoupL6zbWxAM2XDmaWetXuBS4MzSpfbMPZifndaLlrYCRlthSBubXI
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217838>

From: Herman van Rink <rink@initfour.nl>

Add pull-all, push-all, from-submodule, prune and diff commands
to SYNOPSIS.

Add alternate parameter option for add command.

Use long-form option for specifying prefix.

Signed-off-by: Paul Campbell <pcampbell@kemitix.net>

Conflicts:
	contrib/subtree/git-subtree.txt
---
 contrib/subtree/git-subtree.txt | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/contrib/subtree/git-subtree.txt b/contrib/subtree/git-subtree.txt
index 48ba158..b485ab5 100644
--- a/contrib/subtree/git-subtree.txt
+++ b/contrib/subtree/git-subtree.txt
@@ -9,13 +9,16 @@ git-subtree - Merge subtrees together and split repository into subtrees
 SYNOPSIS
 --------
 [verse]
-'git subtree' add   -P <prefix> <refspec>
-'git subtree' add   -P <prefix> <repository> <refspec>
-'git subtree' pull  -P <prefix> <repository> <refspec...>
-'git subtree' push  -P <prefix> <repository> <refspec...>
-'git subtree' merge -P <prefix> <commit>
-'git subtree' split -P <prefix> [OPTIONS] [<commit>]
-
+'git subtree' add   --prefix=<prefix> <repository> <refspec>
+'git subtree' merge --prefix=<prefix> <commit>
+'git subtree' pull  --prefix=<prefix> [<repository> [<refspec>...]]
+'git subtree' pull-all
+'git subtree' push-all
+'git subtree' push  --prefix=<prefix> [<repository> [<refspec>...]]
+'git subtree' split --prefix=<prefix> <commit...>
+'git subtree' from-submodule --prefix=<prefix>
+'git subtree' prune
+'git subtree' diff  --prefix=<prefix> [<repository> [<refspec>...]]
 
 DESCRIPTION
 -----------
-- 
1.8.2.rc1
