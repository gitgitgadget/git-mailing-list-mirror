From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 1/5] git-completion.bash: lexical sorting for diff.statGraphWidth
Date: Mon, 29 Apr 2013 18:19:37 +0530
Message-ID: <1367239781-5232-2-git-send-email-artagnon@gmail.com>
References: <1367239781-5232-1-git-send-email-artagnon@gmail.com>
Cc: Felipe Contreras <felipe.contreras@mail.com>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 29 14:48:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UWnVB-00025p-NB
	for gcvg-git-2@plane.gmane.org; Mon, 29 Apr 2013 14:48:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758145Ab3D2MsO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Apr 2013 08:48:14 -0400
Received: from mail-pa0-f42.google.com ([209.85.220.42]:41729 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757295Ab3D2MsN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Apr 2013 08:48:13 -0400
Received: by mail-pa0-f42.google.com with SMTP id kl13so3661708pab.29
        for <git@vger.kernel.org>; Mon, 29 Apr 2013 05:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=w9KHBCRczvxg7K2BwpW7EE+H+sP5f83Eths/pHdPCPY=;
        b=h06XVCL7Q5TtNLX65OYE1sKxbSdYZk+oSKIp7PDC+9Cc5h6RYdFv/chQuyUSmnoWKQ
         cKlPpqpWvsyYlKBFRWMpvcNw/OJPcCwJ5VRc1TiAyyPyeKikU8WXQjEiYhnOOY+A4veW
         ZFRB8oQ2EHBPk9EWmeGOgCObnOFc4GuN77Ica7Yiq23epphu31PhFEYLZtuqWqmxlDsu
         u2VpphPYuCtg7TVl7TTt4HVBHCxme/nytBTfvCe0cb0dMyykIT4032PAD4Yg6jD/ORso
         ped0dlkDrhroDGQper3f0K6nFtL3hDcAKBsNfkU2Baubm+DSePFUov4HMo1PmYtBWRPQ
         9e5Q==
X-Received: by 10.68.50.193 with SMTP id e1mr72165001pbo.184.1367239692780;
        Mon, 29 Apr 2013 05:48:12 -0700 (PDT)
Received: from luneth.maa.corp.collab.net ([182.71.239.158])
        by mx.google.com with ESMTPSA id wi6sm23963106pbc.22.2013.04.29.05.48.10
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 29 Apr 2013 05:48:12 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.1.616.ga1e5536.dirty
In-Reply-To: <1367239781-5232-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222786>

df44483a (diff --stat: add config option to limit graph width,
2012-03-01) added the option diff.startGraphWidth to the list of
configuration variables in git-completion.bash, but failed to notice
that the list is sorted alphabetically.  Move it to its rightful place
in the list.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 contrib/completion/git-completion.bash | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index bc3fc9e..61ccb19 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2051,13 +2051,13 @@ _git_config ()
 		core.whitespace
 		core.worktree
 		diff.autorefreshindex
-		diff.statGraphWidth
 		diff.external
 		diff.ignoreSubmodules
 		diff.mnemonicprefix
 		diff.noprefix
 		diff.renameLimit
 		diff.renames
+		diff.statGraphWidth
 		diff.suppressBlankEmpty
 		diff.tool
 		diff.wordRegex
-- 
1.8.2.1.616.ga1e5536.dirty
