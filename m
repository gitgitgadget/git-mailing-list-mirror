From: Franck Bui-Huu <vagabon.xyz@gmail.com>
Subject: [PATCH] Add git-upload-archive to the main git man page
Date: Thu, 05 Oct 2006 10:42:16 +0200
Message-ID: <4524C568.2050507@innova-card.com>
Reply-To: Franck <vagabon.xyz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Oct 05 10:41:30 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GVOn8-00027s-53
	for gcvg-git@gmane.org; Thu, 05 Oct 2006 10:41:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751343AbWJEIlP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 5 Oct 2006 04:41:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751344AbWJEIlP
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Oct 2006 04:41:15 -0400
Received: from nf-out-0910.google.com ([64.233.182.188]:36244 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751343AbWJEIlO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Oct 2006 04:41:14 -0400
Received: by nf-out-0910.google.com with SMTP id o25so723321nfa
        for <git@vger.kernel.org>; Thu, 05 Oct 2006 01:41:12 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:reply-to:user-agent:mime-version:to:cc:subject:content-type:content-transfer-encoding:from;
        b=pi7nZyBUuKuX6igXuAHs+t+NrrQ31JnMFl5h+iN2q5Q8ylBCQzTpo1UlzCX3yeFqkikG3RYKmJzfvh3o2t51bkWmKyiuPklcizIzkIhGRapl4cKJQdU4SLDaVR/jj5Vmf84vz2MmzsyhTT15aJFe8t2PIpOL0xkYPg4jdLkY6HI=
Received: by 10.49.75.2 with SMTP id c2mr3566672nfl;
        Thu, 05 Oct 2006 01:41:12 -0700 (PDT)
Received: from ?192.168.0.24? ( [81.252.61.1])
        by mx.google.com with ESMTP id p72sm3385576nfc.2006.10.05.01.41.12;
        Thu, 05 Oct 2006 01:41:12 -0700 (PDT)
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28348>

From: Franck Bui-Huu <fbuihuu@gmail.com>

Signed-off-by: Franck Bui-Huu <fbuihuu@gmail.com>
---
 Documentation/git.txt |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/Documentation/git.txt b/Documentation/git.txt
index 2135b65..3af6fc6 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -243,6 +243,9 @@ gitlink:git-update-server-info[1]::
 	Updates auxiliary information on a dumb server to help
 	clients discover references and packs on it.
 
+gitlink:git-upload-archive[1]::
+	Invoked by 'git-archive' to send a generated archive.
+
 gitlink:git-upload-pack[1]::
 	Invoked by 'git-fetch-pack' to push
 	what are asked for.
-- 
1.4.2.3
