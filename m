From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH] completion: add missiong format-patch options
Date: Sat, 27 Apr 2013 15:17:44 -0500
Message-ID: <1367093864-9362-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 27 22:19:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UWBaS-00070s-IE
	for gcvg-git-2@plane.gmane.org; Sat, 27 Apr 2013 22:19:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754835Ab3D0UTE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Apr 2013 16:19:04 -0400
Received: from mail-oa0-f47.google.com ([209.85.219.47]:52727 "EHLO
	mail-oa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753325Ab3D0UTD (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Apr 2013 16:19:03 -0400
Received: by mail-oa0-f47.google.com with SMTP id n9so4933442oag.20
        for <git@vger.kernel.org>; Sat, 27 Apr 2013 13:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer;
        bh=J/GZd43qSg14AtGvR9EDYKN+0BVjIYcowfRmoPJPuyk=;
        b=M6hZtBuG3WN/8CL7RdY4e5gYiR8Hlf2UwypUvZoi0PlxkaOqnVUuce6mC8laR7CCX/
         eMRX0cFoykdmM6MZNJP09FZjFuMexYdBUgCmNcQJ1/+oUhCrAYKo/lNf51xNCgoDkiV8
         wVXfvpOaK1s/PTRaDknPQvdt5mz3Le/OPO9FtY1fyL2Bw0qVKCly2WPbj2J23sn7rldp
         2xLxn8SGePb1k8SefRVqnKsQ2m0jVS2sU+0ko8i4YdYZjgb0HdfU0KpQWm0UmTHS+PC5
         c/5MUf7xI+VzxcHFPN8eRAgRz/N80DSZAVLzaw9QuAy0Hu94iapcMbJqbzsbEiZRqtrA
         UYyw==
X-Received: by 10.182.231.197 with SMTP id ti5mr20874641obc.64.1367093941688;
        Sat, 27 Apr 2013 13:19:01 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id b2sm13364583oby.5.2013.04.27.13.19.00
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sat, 27 Apr 2013 13:19:00 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.1.1031.g2ee5873
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222693>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.bash | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index bc3fc9e..78aa4cc 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1314,11 +1314,12 @@ _git_fetch ()
 }
 
 __git_format_patch_options="
-	--stdout --attach --no-attach --thread --thread= --output-directory
+	--stdout --attach --no-attach --thread --thread= --no-thread
 	--numbered --start-number --numbered-files --keep-subject --signoff
 	--signature --no-signature --in-reply-to= --cc= --full-index --binary
 	--not --all --cover-letter --no-prefix --src-prefix= --dst-prefix=
 	--inline --suffix= --ignore-if-in-upstream --subject-prefix=
+	--output-directory --reroll-count --to= --cc= --quiet --notes
 "
 
 _git_format_patch ()
-- 
1.8.2.1.1031.g2ee5873
