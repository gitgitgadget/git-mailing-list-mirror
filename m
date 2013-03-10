From: Paul Campbell <pcampbell@kemitix.net>
Subject: [PATCH v2 22/23] contrib/subtree: Parameters repository/branch for push/pull are optional
Date: Sun, 10 Mar 2013 23:41:30 +0000
Message-ID: <1362958891-26941-23-git-send-email-pcampbell@kemitix.net>
References: <1362958891-26941-1-git-send-email-pcampbell@kemitix.net>
Cc: David Greene <greened@obbligato.org>,
	Paul Campbell <pcampbell@kemitix.net>,
	"Matt Hoffman" <matt.hoffman@quantumretail.com>,
	"Avery Pennarun" <apenwarr@gmail.com>,
	"Herman van Rink" <rink@initfour.nl>,
	"Wayne Walter" <wayne@tickzoom.com>
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Mar 11 00:46:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UEpwN-0005Ly-B9
	for gcvg-git-2@plane.gmane.org; Mon, 11 Mar 2013 00:46:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753422Ab3CJXpj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Mar 2013 19:45:39 -0400
Received: from mail-wi0-f179.google.com ([209.85.212.179]:34312 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753249Ab3CJXph (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Mar 2013 19:45:37 -0400
Received: by mail-wi0-f179.google.com with SMTP id ez12so611514wid.0
        for <git@vger.kernel.org>; Sun, 10 Mar 2013 16:45:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:x-gm-message-state;
        bh=ToiaWcnakWfF/fRoGMrVMJM/fXy9ZLV3ZfnBsZQQhHQ=;
        b=C9sUrqMGygwpktwMBTn09s5U/WplvbpZTaW/UcSJtOHrQ0YNnuITophDzr1+hR6o+O
         qE9HdtmtqLs4bPAEZO1A/a+kORUdGzbl4nd7mIoLpWlYHin0eBAxT3PijcNPT5SXMApl
         Vk1miW7S6HzKLjf+IH0sollPeLIoyoKL+uzZfAHM49P28vmNPVhlgvpEvwkEJbqCOI/P
         EMTrOJu3XssuNu1nr7gbJfBnrYoPz8LV2YPXcO+ZfoSVZEkZCO27p0tiAq0IsNW3+Evz
         R3bRuQBi7TbpjPZ/M5SLyI2R9F5ZDZhHYO6p3gHaPYyrN6+S+8hHXOqerj/Su3OV4k7F
         EjZQ==
X-Received: by 10.180.183.177 with SMTP id en17mr2446137wic.2.1362959135970;
        Sun, 10 Mar 2013 16:45:35 -0700 (PDT)
Received: from coyote.home (host-2-102-87-75.as13285.net. [2.102.87.75])
        by mx.google.com with ESMTPS id r7sm13757148wiz.2.2013.03.10.16.45.32
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sun, 10 Mar 2013 16:45:34 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.rc1
In-Reply-To: <1362958891-26941-1-git-send-email-pcampbell@kemitix.net>
X-Gm-Message-State: ALoCoQk/K75yV3o7O6WnYJ7NWkuSaX2JixvqViS5rBRyMjmntn6M6wfCO+sgK0+MzbltFyzqArRT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217843>

Signed-off-by: Paul Campbell <pcampbell@kemitix.net>
---
 contrib/subtree/git-subtree.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
index 263ea9f..aaee6ae 100755
--- a/contrib/subtree/git-subtree.sh
+++ b/contrib/subtree/git-subtree.sh
@@ -11,10 +11,10 @@ OPTS_SPEC="\
 git subtree add   --prefix=<prefix> <commit>
 git subtree add   --prefix=<prefix> <repository> <commit>
 git subtree merge --prefix=<prefix> <commit>
-git subtree pull  --prefix=<prefix> <repository> <refspec...>
+git subtree pull  --prefix=<prefix> [<repository> [<refspec>...]]
 git subtree pull-all
 git subtree push-all
-git subtree push  --prefix=<prefix> <repository> <refspec...>
+git subtree push  --prefix=<prefix> [<repository> [<refspec>...]]
 git subtree list
 git subtree split --prefix=<prefix> <commit...>
 git subtree diff  --prefix=<prefix> [<repository> [<refspec>...]]
-- 
1.8.2.rc1
