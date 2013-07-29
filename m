From: Ralf Thielow <ralf.thielow@gmail.com>
Subject: [PATCH] git-rebase: fix typo
Date: Mon, 29 Jul 2013 06:24:43 +0200
Message-ID: <1375071883-3017-1-git-send-email-ralf.thielow@gmail.com>
Cc: artagnon@gmail.com, Ralf Thielow <ralf.thielow@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 29 06:24:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V3f0u-0000ZG-KJ
	for gcvg-git-2@plane.gmane.org; Mon, 29 Jul 2013 06:24:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754245Ab3G2EYt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Jul 2013 00:24:49 -0400
Received: from mail-ee0-f53.google.com ([74.125.83.53]:35251 "EHLO
	mail-ee0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751610Ab3G2EYs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Jul 2013 00:24:48 -0400
Received: by mail-ee0-f53.google.com with SMTP id b15so453702eek.26
        for <git@vger.kernel.org>; Sun, 28 Jul 2013 21:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=KM4rCugkpax3D3d5xwGocbtR5c9MQgN71nfPhFJnbiM=;
        b=mXyrmhs+a5wp2ci7EqzkjNEjUFkTXktYKKATECIHq/93bY6KQElQk6S7xweO5tYxfg
         7hNBjIH1NuutlV9wVR+GLRze7N3HHyMCKoPaglakTyv61Cl0/9X0BLe8OaQYLk98w2rQ
         vFuUPLfB+AwOXt8skjGG2jvkTQ+v1Z4aHwmoz2I3cXBIN8Q5dI90iS76e4/nnOl9szBP
         k/WH0FzJt9lptRnOxrKmonfEFTbHBKmIkMVW8kpFl5gEx4rebdQodEfzoLiWJyw4069W
         lieBpCMSse5NcSGt++S8k1Z0cIE0Tm5Xiux5ugf5Opm1Vflql8LBtTx3jFfW/5NRHApV
         t4vQ==
X-Received: by 10.15.51.202 with SMTP id n50mr57014838eew.39.1375071887260;
        Sun, 28 Jul 2013 21:24:47 -0700 (PDT)
Received: from localhost (dslb-088-073-170-058.pools.arcor-ip.net. [88.73.170.58])
        by mx.google.com with ESMTPSA id n45sm99334645eew.1.2013.07.28.21.24.46
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 28 Jul 2013 21:24:46 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.1873.gfc589a4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231273>

Signed-off-by: Ralf Thielow <ralf.thielow@gmail.com>
---
 git-rebase.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-rebase.sh b/git-rebase.sh
index 0039ecf..8d7659a 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -159,7 +159,7 @@ finish_rebase () {
 			die "$(eval_gettext "Cannot store \$stash_sha1")"
 			gettext 'Applying autostash resulted in conflicts.
 Your changes are safe in the stash.
-You can run "git stash pop" or "git stash drop" it at any time.
+You can run "git stash pop" or "git stash drop" at any time.
 '
 		fi
 	fi
-- 
1.8.2.1873.gfc589a4
