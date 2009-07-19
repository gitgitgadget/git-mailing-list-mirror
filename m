From: Stephen Boyd <bebarino@gmail.com>
Subject: [PATCH] completion: add dirstat and friends to diff options
Date: Sun, 19 Jul 2009 14:54:04 -0700
Message-ID: <1248040444-13787-1-git-send-email-bebarino@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sun Jul 19 23:54:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MSeKr-0001Yr-7M
	for gcvg-git-2@gmane.org; Sun, 19 Jul 2009 23:54:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751601AbZGSVyK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Jul 2009 17:54:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751576AbZGSVyJ
	(ORCPT <rfc822;git-outgoing>); Sun, 19 Jul 2009 17:54:09 -0400
Received: from mail-pz0-f184.google.com ([209.85.222.184]:45247 "EHLO
	mail-pz0-f184.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751537AbZGSVyI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Jul 2009 17:54:08 -0400
Received: by pzk14 with SMTP id 14so108005pzk.33
        for <git@vger.kernel.org>; Sun, 19 Jul 2009 14:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer;
        bh=ZFVtmIQSTycvSWr9/JeS4g3qgUeYO9JoQkQmZkYxSCc=;
        b=ekMH7AQmONUYIAOikCC/dWH17k061GxAQB5AmUq2ECnF7fbi3VFfCuWyfpUC3zaJss
         1enawpjtp/hfGyOrgIo2R0QZFK2BE8XQ7PapQQHtO0ERLpRoz0J1vsLTDc4V1Jb0Lato
         +hFuPGE/g1MLGmorT//J25yUI92CAbFskkDAc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=kENcr7paa+TZz0FAkqzGiTXCWGMsrs0JWXrIE+Q+6Hfli/mFwE7XBPKqnD6t8yT3ho
         4PY2wMDrRGUuCQ9cApBavDPQbyYjKMtoe8UPB7XEdAtlEK2fCwmJrhy3PJ1rkkn3qKQH
         2kXRnTigGBxmoQhPi/wxVa6G1YsttXI+4WPlM=
Received: by 10.115.108.13 with SMTP id k13mr4847097wam.33.1248040447991;
        Sun, 19 Jul 2009 14:54:07 -0700 (PDT)
Received: from earth (cpe-66-75-25-79.san.res.rr.com [66.75.25.79])
        by mx.google.com with ESMTPS id n9sm7623133wag.23.2009.07.19.14.54.05
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 19 Jul 2009 14:54:07 -0700 (PDT)
Received: by earth (sSMTP sendmail emulation); Sun, 19 Jul 2009 14:54:04 -0700
X-Mailer: git-send-email 1.6.4.rc1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123562>


Signed-off-by: Stephen Boyd <bebarino@gmail.com>
---
 contrib/completion/git-completion.bash |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 887731e..fd284bc 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -907,6 +907,8 @@ __git_diff_common_options="--stat --numstat --shortstat --summary
 			--inter-hunk-context=
 			--patience
 			--raw
+			--dirstat --dirstat= --dirstat-by-file
+			--dirstat-by-file= --cumulative
 "
 
 _git_diff ()
-- 
1.6.4.rc1
