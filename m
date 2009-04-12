From: David Aguilar <davvid@gmail.com>
Subject: [PATCH 1/2] mergetool--lib: Fix misspelled mergetool.keepBackup
Date: Sat, 11 Apr 2009 20:41:55 -0700
Message-ID: <1239507716-6766-1-git-send-email-davvid@gmail.com>
Cc: git@vger.kernel.org, markus.heidelberg@web.de,
	charles@hashpling.org, Ferry Huberts <ferry.huberts@pelagic.nl>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sun Apr 12 05:43:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lsqbo-0004pK-2c
	for gcvg-git-2@gmane.org; Sun, 12 Apr 2009 05:43:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756250AbZDLDmN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 Apr 2009 23:42:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756020AbZDLDmN
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Apr 2009 23:42:13 -0400
Received: from wa-out-1112.google.com ([209.85.146.183]:30281 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755804AbZDLDmM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Apr 2009 23:42:12 -0400
Received: by wa-out-1112.google.com with SMTP id j5so826569wah.21
        for <git@vger.kernel.org>; Sat, 11 Apr 2009 20:42:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=KZcxYdz5UZaiZikN1zWvJ4BnXmyq9lCbckbbb7F7bWw=;
        b=dhoUjbmDKDEBfV+WdWMnM9R/B1OSpSZ1K9doMaxCRxL6kKNCpyVk7TDDDLxpx07ZLQ
         HXR2ogtivk6U8bGQopDtuQInkiifefPP+wyPWDVsY74luWSMwB1YHv2oamv2PIKQZQeP
         QSsBlREM8fyv2GmDIN9awQ6F406OnoIE+i9+4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=X8PMM2MUmvTUQ2IB5vhVVYk4BlGogy3ag3LjmCb4hsL+Lk8AyO8TmeGFmDJqPIlYhT
         4pNd4cdSrguL361BFozb5wZxVAFpuEV8ubHswL3zOsEbWYedBbIhdhRS6+qjECgWz0aU
         eSNlnILH8lL4+GhYX5DGeMOHBpy/u7+8K8pis=
Received: by 10.115.49.11 with SMTP id b11mr2577319wak.114.1239507732192;
        Sat, 11 Apr 2009 20:42:12 -0700 (PDT)
Received: from localhost (208-106-56-2.static.dsltransport.net [208.106.56.2])
        by mx.google.com with ESMTPS id n9sm3615868wag.11.2009.04.11.20.42.11
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 11 Apr 2009 20:42:11 -0700 (PDT)
X-Mailer: git-send-email 1.6.2.2.471.g6da14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116367>

From: Ferry Huberts <ferry.huberts@pelagic.nl>

In several places mergetool.keepBackup was misspelled as merge.keepBackup.

Signed-off-by: Ferry Huberts <ferry.huberts@pelagic.nl>
---

This is Ferry's patch with Junio's suggested commit message.
Based on pu.

 git-mergetool.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-mergetool.sh b/git-mergetool.sh
index efa31a2..2e3e02b 100755
--- a/git-mergetool.sh
+++ b/git-mergetool.sh
@@ -257,7 +257,7 @@ prompt_after_failed_merge() {
 merge_tool=$(get_merge_tool "$merge_tool") || exit
 merge_tool_cmd="$(get_merge_tool_cmd "$merge_tool")"
 merge_tool_path="$(get_merge_tool_path "$merge_tool")" || exit
-merge_keep_backup="$(git config --bool merge.keepBackup || echo true)"
+merge_keep_backup="$(git config --bool mergetool.keepBackup || echo true)"
 merge_keep_temporaries="$(git config --bool mergetool.keepTemporaries || echo false)"
 merge_tool_trust_exit_code="$(git config --bool mergetool."$merge_tool".trustExitCode || echo false)"
 
-- 
1.6.2.2.471.g6da14
