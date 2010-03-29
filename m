From: Erick Mattos <erick.mattos@gmail.com>
Subject: [PATCH] bash completion: add --orphan to 'git checkout'
Date: Mon, 29 Mar 2010 11:00:58 -0300
Message-ID: <1269871258-5979-1-git-send-email-erick.mattos@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Erick Mattos <erick.mattos@gmail.com>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Mar 29 16:07:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NwFd5-0006gJ-OZ
	for gcvg-git-2@lo.gmane.org; Mon, 29 Mar 2010 16:07:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752777Ab0C2OHj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Mar 2010 10:07:39 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:58090 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752358Ab0C2OHh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Mar 2010 10:07:37 -0400
Received: by pva18 with SMTP id 18so2482922pva.19
        for <git@vger.kernel.org>; Mon, 29 Mar 2010 07:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=XWBr5pZMmRhSohhBn5zQcGaHTpmNXsiVlOHLWPJpOhE=;
        b=aXMhVfGeZr/2fHLzwfYHKHzpvg7+8+D2x3ZWGGh6ad9hdadjbQXqol/Q/q5ZOFs69P
         zYzAf6ZVnalqctRXi9Jkn6OslcO7PP5AIVb4c3Pj3LdKRntIB9b4dljjHSedLWyOadlV
         bODirx23tBGE4kL35EXPi6MVxzR+FL9MeWy7Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=BJ1lbYj/pjFAATDs3apn9kAR43Zl01cBL9EOz8wM38NjUt1j47UECkLYEJEjLajyU6
         c/pfQokT/5JHWnp5O/EhKMzwhCAD7F/9Q60Wv4MxVWFe3TpNIFxqyNRI5atTvMsiifhQ
         mPGEIELx6vEf+gE0eKFdC0SITsGEzv/cHcWdk=
Received: by 10.114.105.4 with SMTP id d4mr3800883wac.45.1269871271464;
        Mon, 29 Mar 2010 07:01:11 -0700 (PDT)
Received: from localhost.localdomain ([187.15.105.210])
        by mx.google.com with ESMTPS id 5sm1022183yxg.64.2010.03.29.07.01.09
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 29 Mar 2010 07:01:10 -0700 (PDT)
X-Mailer: git-send-email 1.7.0.3.292.g2556a.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143476>

Updating git-completion.bash with new --orphan option to 'git checkout'.
---
 contrib/completion/git-completion.bash |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 733ac39..54e07f3 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -832,7 +832,7 @@ _git_checkout ()
 	--*)
 		__gitcomp "
 			--quiet --ours --theirs --track --no-track --merge
-			--conflict= --patch
+			--conflict= --orphan --patch
 			"
 		;;
 	*)
-- 
1.7.0.3.292.g2556a.dirty
