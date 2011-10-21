From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH v2 1/2] submodule: whitespace fix
Date: Fri, 21 Oct 2011 21:49:35 +0800
Message-ID: <1319204976-5076-2-git-send-email-rctay89@gmail.com>
References: <1317978295-4796-2-git-send-email-rctay89@gmail.com>
 <1319204976-5076-1-git-send-email-rctay89@gmail.com>
Cc: "Junio C Hamano" <gitster@pobox.com>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Oct 21 15:49:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RHFTv-0004sj-5o
	for gcvg-git-2@lo.gmane.org; Fri, 21 Oct 2011 15:49:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754685Ab1JUNtu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Oct 2011 09:49:50 -0400
Received: from mail-qy0-f174.google.com ([209.85.216.174]:46011 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754493Ab1JUNtu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Oct 2011 09:49:50 -0400
Received: by qyk4 with SMTP id 4so591935qyk.19
        for <git@vger.kernel.org>; Fri, 21 Oct 2011 06:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=WjBUpNQ3m5qItWovBouAevvWIqmZp+nshKKDD471Nx8=;
        b=sgMlumbNQU8um4jwSElpSiU1CtTbwaFhgUReSF2tAPxI+e4CHDaHSZmO2MSEAkfIX6
         8LSIB2oATC2dvZOFsar3yDcyg5QAbu6fe5A5BtHYyxR43Y2xOYgWT0mUMSdFCD36oKRi
         w9zsKJ89L/Iy4ZH9CynKF62WvTSGTwgUPfuWQ=
Received: by 10.68.199.41 with SMTP id jh9mr5000626pbc.60.1319204989242;
        Fri, 21 Oct 2011 06:49:49 -0700 (PDT)
Received: from localhost (s80216.pc.nus.edu.sg. [137.132.36.216])
        by mx.google.com with ESMTPS id y4sm30785239pbe.4.2011.10.21.06.49.46
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 21 Oct 2011 06:49:48 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.msysgit.0.584.g2cbf
In-Reply-To: <1319204976-5076-1-git-send-email-rctay89@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184063>

Replace SPs with TAB.

Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
---
 git-submodule.sh |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 7576d14..8e9e5ea 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -104,9 +104,9 @@ module_name()
 	re=$(printf '%s\n' "$1" | sed -e 's/[].[^$\\*]/\\&/g')
 	name=$( git config -f .gitmodules --get-regexp '^submodule\..*\.path$' |
 		sed -n -e 's|^submodule\.\(.*\)\.path '"$re"'$|\1|p' )
-       test -z "$name" &&
-       die "$(eval_gettext "No submodule mapping found in .gitmodules for path '\$path'")"
-       echo "$name"
+	test -z "$name" &&
+	die "$(eval_gettext "No submodule mapping found in .gitmodules for path '\$path'")"
+	echo "$name"
 }
 
 #
-- 
1.7.6.msysgit.0.584.g2cbf
