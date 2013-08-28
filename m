From: Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH v2] documentation: clarify notes for clean.requireForce
Date: Wed, 28 Aug 2013 09:28:32 +0800
Message-ID: <0ac7e5f803a34f417e320df35aaec793a5b980c6.1377653235.git.worldhello.net@gmail.com>
References: <xmqqd2ozdrie.fsf@gitster.dls.corp.google.com>
Cc: Git List <git@vger.kernel.org>,
	Jiang Xin <worldhello.net@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 28 03:30:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VEUau-0006XQ-Ch
	for gcvg-git-2@plane.gmane.org; Wed, 28 Aug 2013 03:30:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752562Ab3H1Bao (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Aug 2013 21:30:44 -0400
Received: from mail-pd0-f170.google.com ([209.85.192.170]:45237 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752430Ab3H1Ban (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Aug 2013 21:30:43 -0400
Received: by mail-pd0-f170.google.com with SMTP id x10so5625822pdj.29
        for <git@vger.kernel.org>; Tue, 27 Aug 2013 18:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YbsObj7+2Mv1beOn7+7N7x8FTCNJpjJr3+k14/16Ihs=;
        b=js/gARsBYHLgnpsR1ObG1hIfLwmzztHgCmWdefF15YIutSw/vAqrLcZzK3mxI2jeW9
         IJyb3ZdE3qRjN2gJGNtZtMwFVKekOub7Ex1GNKl4TO+R5p8I1TaWr/oclpA4g2H9Y/rc
         Hi4INeY92aAZhhuZ5egsK+y2FwHro4CplVbiLtClnQZUNrmAS0zAV6ltnhcxJDHgPTVG
         sS/q0be7l163n4qjFX/0sUqhFF03zc/kqCAWIlud3Ly1rqrZXqhrqMh/xWO5B1CAy61U
         5snYq+YNS7U/ewdBjuXShn44rErN+cZq9vYZ3hnplJgUxVVf3kstavYRGc607ywgm6ef
         buZA==
X-Received: by 10.68.182.2 with SMTP id ea2mr296942pbc.186.1377653443522;
        Tue, 27 Aug 2013 18:30:43 -0700 (PDT)
Received: from localhost.localdomain ([114.248.144.150])
        by mx.google.com with ESMTPSA id mz5sm27589456pbc.18.1969.12.31.16.00.00
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 27 Aug 2013 18:30:42 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc2.29.g07b4019
In-Reply-To: <xmqqd2ozdrie.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233172>

Add "-i" (interactive clean option) to clarify the documentation for
"clean.requireForce" config variable.

Signed-off-by: Jiang Xin <worldhello.net@gmail.com>
---
 Documentation/config.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 8361380..7321a54 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -795,8 +795,8 @@ browser.<tool>.path::
 	working repository in gitweb (see linkgit:git-instaweb[1]).
 
 clean.requireForce::
-	A boolean to make git-clean do nothing unless given -f
-	or -n.   Defaults to true.
+	A boolean to make git-clean do nothing unless given -f,
+	-i or -n.   Defaults to true.
 
 color.branch::
 	A boolean to enable/disable color in the output of
-- 
1.8.3.rc2.29.g07b4019
