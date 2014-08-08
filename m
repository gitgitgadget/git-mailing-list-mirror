From: Linus Arver <linusarver@gmail.com>
Subject: [PATCH v2 6/7] Documentation: git-init: template directory: reword and cross-reference
Date: Fri,  8 Aug 2014 10:29:19 -0700
Message-ID: <1407518960-6203-7-git-send-email-linusarver@gmail.com>
References: <1407002817-29221-1-git-send-email-linusarver@gmail.com>
 <1407518960-6203-1-git-send-email-linusarver@gmail.com>
Cc: Steven Drake <sdrake@xnet.co.nz>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Johan Herland <johan@herland.net>,
	Linus Arver <linusarver@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 08 19:30:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XFo0D-00031k-Qz
	for gcvg-git-2@plane.gmane.org; Fri, 08 Aug 2014 19:30:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752187AbaHHRal (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Aug 2014 13:30:41 -0400
Received: from mail-yh0-f46.google.com ([209.85.213.46]:61356 "EHLO
	mail-yh0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750986AbaHHRaj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Aug 2014 13:30:39 -0400
Received: by mail-yh0-f46.google.com with SMTP id a41so4318740yho.33
        for <git@vger.kernel.org>; Fri, 08 Aug 2014 10:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gumeS/51CEvSTyURVvsjt8NNoT/tHwb5SOLzPoe7ZI4=;
        b=ZrJKWlOe972UuCfQ2+6Awaxs26+8pWSwx6sWY+EWHRly/biUpQqqExK71rnea7r8ai
         E4WS/AYz7FRQP/13nf8zZcNEHj6iLMYcGk1Gq3fvxd95wPI6fl5HdhUUDNHMDP5KE1vO
         PhlLvSqEd19BeCB/LlOZYhtfpG8ADv3ASPjhhltjjXuFGyhj+4A049lMuxj48yERW4mj
         gnMeGjrFDI0ez2JXZbe1bHoxz2txQ5mNNq8ziPJXE4w8k3vFjHAeCzZFNS+Hde1Si8yO
         VCfWRJ6dHCdcVk7JopcFcrQCl4fYTlT55Ro1e4Cuah3CxwNae3XT0lL76UD8BPgWvbLG
         Ispw==
X-Received: by 10.236.136.168 with SMTP id w28mr16365379yhi.132.1407519038899;
        Fri, 08 Aug 2014 10:30:38 -0700 (PDT)
Received: from k0.localdomain (107-223-14-32.lightspeed.sntcca.sbcglobal.net. [107.223.14.32])
        by mx.google.com with ESMTPSA id u47sm6776458yhm.35.2014.08.08.10.30.37
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 08 Aug 2014 10:30:38 -0700 (PDT)
X-Mailer: git-send-email 2.0.4
In-Reply-To: <1407518960-6203-1-git-send-email-linusarver@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255053>

Signed-off-by: Linus Arver <linusarver@gmail.com>
---
 Documentation/git-init.txt | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-init.txt b/Documentation/git-init.txt
index 21e5ad9..9f2c7d8 100644
--- a/Documentation/git-init.txt
+++ b/Documentation/git-init.txt
@@ -129,9 +129,8 @@ The template directory will be one of the following (in order):
 
  - the default template directory: `/usr/share/git-core/templates`.
 
-The default template directory includes some directory structure, some
-suggested "exclude patterns", and copies of sample "hook" files.
-The suggested patterns and hook files are all modifiable and extensible.
+The default template directory includes some directory structure, suggested
+"exclude patterns" (see linkgit:gitignore[5]), and sample hook files (see linkgit:githooks[5]).
 
 EXAMPLES
 --------
-- 
2.0.4
