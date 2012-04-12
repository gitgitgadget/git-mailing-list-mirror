From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 2/4] completion: trivial simplification
Date: Fri, 13 Apr 2012 02:50:01 +0300
Message-ID: <1334274603-3277-3-git-send-email-felipe.contreras@gmail.com>
References: <1334274603-3277-1-git-send-email-felipe.contreras@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>,
	Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>, Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 13 01:50:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SITmr-0005Bd-11
	for gcvg-git-2@plane.gmane.org; Fri, 13 Apr 2012 01:50:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758238Ab2DLXuf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Apr 2012 19:50:35 -0400
Received: from mail-lb0-f174.google.com ([209.85.217.174]:56331 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753197Ab2DLXud (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Apr 2012 19:50:33 -0400
Received: by mail-lb0-f174.google.com with SMTP id gm6so2046018lbb.19
        for <git@vger.kernel.org>; Thu, 12 Apr 2012 16:50:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=ae/deUHs1t1ZLFEBRYzjvB69gTAlwcLavHof/qGOd20=;
        b=hqa0qJwsrYAG1sdaDmOsn1mTSR9EP0t+g1Nkgu5vVsnrhThaTBVpGkin+eeT+adl3u
         92vlZE9hOVLUsLAg9GPDgGem2tdSfr42yNaWf/ishrwBzrHHYmYdN3i3Hnzbjq5IbA5o
         eUGbf0T1/q/aA6m9w0xXmxO/4WBGh/jRsyZxIPgJ4Ig78GHsm4IiTcw9FN5eghRU2ndi
         ZNj/p/w1ICC5IG+W/cvFOoTBpVQfeW5U/XkC8CB/MSqkidiQsdiCuhIvRIT9Ljmhfy2S
         aPkgN8jCWNrxnWEtew5XPbRSLh1c1Q9kLx5ZR3a+fSP6zUFK0+n9KkP/Lqm2YYN5KRr/
         lEzQ==
Received: by 10.152.104.109 with SMTP id gd13mr138906lab.9.1334274632541;
        Thu, 12 Apr 2012 16:50:32 -0700 (PDT)
Received: from localhost (84-231-136-182.elisa-mobile.fi. [84.231.136.182])
        by mx.google.com with ESMTPS id h8sm9598628lbx.8.2012.04.12.16.50.30
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 12 Apr 2012 16:50:31 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.1.g1f19b8.dirty
In-Reply-To: <1334274603-3277-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195392>

cword-1 is the previous word ($prev).

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.bash |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 13be9a7..9d36bb7 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1658,7 +1658,7 @@ _git_notes ()
 		__gitcomp '--ref'
 		;;
 	,*)
-		case "${words[cword-1]}" in
+		case "$prev" in
 		--ref)
 			__gitcomp_nl "$(__git_refs)"
 			;;
@@ -1684,7 +1684,7 @@ _git_notes ()
 	prune,*)
 		;;
 	*)
-		case "${words[cword-1]}" in
+		case "$prev" in
 		-m|-F)
 			;;
 		*)
-- 
1.7.10.1.g1f19b8.dirty
