From: Brandon Casey <drafnel@gmail.com>
Subject: [PATCH 2/4] git-stash.sh: fix typo in error message
Date: Fri, 26 Aug 2011 19:59:25 -0500
Message-ID: <1314406767-17832-2-git-send-email-drafnel@gmail.com>
References: <1314406767-17832-1-git-send-email-drafnel@gmail.com>
Cc: git@vger.kernel.org, hilco.wijbenga@gmail.com, david@porkrind.org,
	Brandon Casey <drafnel@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Aug 27 03:01:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qx7Go-000794-O2
	for gcvg-git-2@lo.gmane.org; Sat, 27 Aug 2011 03:01:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754633Ab1H0BBF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Aug 2011 21:01:05 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:34692 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754411Ab1H0BBD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Aug 2011 21:01:03 -0400
Received: by gya6 with SMTP id 6so3313241gya.19
        for <git@vger.kernel.org>; Fri, 26 Aug 2011 18:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=Xed3l/mm9lKEvTrdtKV62TlVl7uhBMoTNvayPYJSEGM=;
        b=BCMN4+9+iMw8ZCPPNibYkvxP2e+7/wxqvid9vDKshhDMkh1ZDebw7zPjzQIynEE3eK
         FwimdA9h+GppptoYhBFPMmoP+7uYtAuyDw3LpVel0dPAVR1t5EiCdyv7qEBmIdd7cKTP
         x2Z94P+nHlbnOxiMEq6JK++GqCLuo7VCVgKfg=
Received: by 10.236.176.33 with SMTP id a21mr10653674yhm.108.1314406863426;
        Fri, 26 Aug 2011 18:01:03 -0700 (PDT)
Received: from localhost.localdomain ([96.19.140.155])
        by mx.google.com with ESMTPS id j45sm2756593yhe.36.2011.08.26.18.01.02
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 26 Aug 2011 18:01:03 -0700 (PDT)
X-Mailer: git-send-email 1.7.6
In-Reply-To: <1314406767-17832-1-git-send-email-drafnel@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180213>


Signed-off-by: Brandon Casey <drafnel@gmail.com>
---
 git-stash.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-stash.sh b/git-stash.sh
index 31dec0a..9d65250 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -211,7 +211,7 @@ save_stash () {
 
 	if test -n "$patch_mode" && test -n "$untracked"
 	then
-	    die "Can't use --patch and ---include-untracked or --all at the same time"
+	    die "Can't use --patch and --include-untracked or --all at the same time"
 	fi
 
 	stash_msg="$*"
-- 
1.7.6
