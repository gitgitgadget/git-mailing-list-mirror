From: Pascal Obry <pascal.obry@gmail.com>
Subject: [PATCH] Add interactive option in rebase command completion list.
Date: Sun,  6 Apr 2008 19:32:24 +0200
Message-ID: <1207503144-3008-1-git-send-email-pascal@obry.net>
Cc: Pascal Obry <pascal@obry.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 06 19:33:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JiYk1-00007m-HB
	for gcvg-git-2@gmane.org; Sun, 06 Apr 2008 19:33:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754883AbYDFRce (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Apr 2008 13:32:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754880AbYDFRcd
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Apr 2008 13:32:33 -0400
Received: from nf-out-0910.google.com ([64.233.182.191]:55964 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754585AbYDFRcd (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Apr 2008 13:32:33 -0400
Received: by nf-out-0910.google.com with SMTP id g13so367180nfb.21
        for <git@vger.kernel.org>; Sun, 06 Apr 2008 10:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:to:cc:subject:date:message-id:x-mailer:from;
        bh=fUErJt7Eau4E8yFx/ACSe2rXQeCFjxxWwGE5I0pAGbg=;
        b=TrhE2EQfJwCaffl27OYI2dSfKqJV9UePhK1DJk1b6TXk8BP2H2T8+a7xrifjD8Og9l+8CZbCdY0rL2hAl3qkW/DFzhQCAxjuMHghoiI4fTMUD30JBoPSdYPsRJjnpBdqAqRuquxd2JF91TomvjIpnoJWtz/hCatPd+1c0EMRuuI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=to:cc:subject:date:message-id:x-mailer:from;
        b=agYQZOkFMJ5vIWX3uBfNvoud7xESwb79XGCKdalalLA6dPGHXj0cRtTAnj+W9ImrSYpCIsSnHTcNRqDI1BoW3KKxYNXCv/2SeRAJhrZSgmBpvyNVs8toqYWzxdVopJcj73g0z9pkW5fPIya0KNB3oUlIQh47qKTha4tE3qmoa1c=
Received: by 10.78.139.14 with SMTP id m14mr1431204hud.93.1207503149852;
        Sun, 06 Apr 2008 10:32:29 -0700 (PDT)
Received: from pascal.obry@gmail.com ( [82.124.251.208])
        by mx.google.com with ESMTPS id b33sm11333059ika.5.2008.04.06.10.32.27
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 06 Apr 2008 10:32:29 -0700 (PDT)
Received: by pascal.obry@gmail.com (sSMTP sendmail emulation); Sun, 06 Apr 2008 19:32:24 +0200
X-Mailer: git-send-email 1.5.5.rc3.7.gba133
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78902>

Signed-off-by: Pascal Obry <pascal@obry.net>
---
 contrib/completion/git-completion.bash |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 791e30f..96a712b 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -865,7 +865,7 @@ _git_rebase ()
 		return
 		;;
 	--*)
-		__gitcomp "--onto --merge --strategy"
+		__gitcomp "--onto --merge --strategy --interactive"
 		return
 	esac
 	__gitcomp "$(__git_refs)"
-- 
1.5.5.rc3.7.gba133
