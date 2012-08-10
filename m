From: David Aguilar <davvid@gmail.com>
Subject: [PATCH] mergetool,difftool: Simplify --tool-help documentation
Date: Fri, 10 Aug 2012 00:39:23 -0700
Message-ID: <1344584363-5933-2-git-send-email-davvid@gmail.com>
References: <1344584363-5933-1-git-send-email-davvid@gmail.com>
Cc: Sebastian Schuberth <sschuberth@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 10 09:39:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Szjok-00010U-AR
	for gcvg-git-2@plane.gmane.org; Fri, 10 Aug 2012 09:39:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755653Ab2HJHj3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Aug 2012 03:39:29 -0400
Received: from mail-gg0-f174.google.com ([209.85.161.174]:52600 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754908Ab2HJHj2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Aug 2012 03:39:28 -0400
Received: by ggdk6 with SMTP id k6so1328150ggd.19
        for <git@vger.kernel.org>; Fri, 10 Aug 2012 00:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=xWWon+gbekcPNrrJg9o1WNwWb352CiU29YjxYgS4lZY=;
        b=PJOp42bSgFpXKwYpOppa2DvTP65wcume1yAGuELLqF783w0+axQI36N62AaimZLFTd
         qxwXgg8tFSYgOwiMR+qX4Un35Cq3d947uk7zgyqIgzLFmBDu5dmoHfOoKeOuTDiItgDq
         1fbNbvpHIK5cWIBUvPoTD9ZLa3iDPTmz4I0Sa1iLhIY9a+3J30o727pXApbjTS1S62Hm
         ttRK+519JgIDtY1KW7OoCwvvRU157+VPNAwesEEEuEYxubnVunfuVcQDdg2AypU0ZJZg
         WKRH9zAMmZIN/XOKxRci2LGNBtLssffBJ5Pz6I55ZNO46Olt7wwFHkcxw32mXF1x1tFU
         AldQ==
Received: by 10.66.78.195 with SMTP id d3mr4417384pax.17.1344584367650;
        Fri, 10 Aug 2012 00:39:27 -0700 (PDT)
Received: from lustrous.fas.fa.disney.com (208-106-56-2.static.sonic.net. [208.106.56.2])
        by mx.google.com with ESMTPS id tv6sm2834734pbc.24.2012.08.10.00.39.26
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 10 Aug 2012 00:39:27 -0700 (PDT)
X-Mailer: git-send-email 1.7.12.rc2.16.g034161a
In-Reply-To: <1344584363-5933-1-git-send-email-davvid@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203205>

Remove the entry for --tool-help in the documentation as it is
already mentioned in the documentation for --tool.

Signed-off-by: David Aguilar <davvid@gmail.com>
---
Incompatible with the previous patch, but if you prefer to
mention --tool-help in the docs for --tool only, then choose
this one.

 Documentation/git-difftool.txt | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/Documentation/git-difftool.txt b/Documentation/git-difftool.txt
index 313d54e..ee80b00 100644
--- a/Documentation/git-difftool.txt
+++ b/Documentation/git-difftool.txt
@@ -74,9 +74,6 @@ with custom merge tool commands and has the same value as `$MERGED`.
 	Specifying `--no-symlinks` instructs 'git difftool' to create
 	copies instead.  `--no-symlinks` is the default on Windows.
 
---tool-help::
-	Print a list of diff tools that may be used with `--tool`.
-
 -x <command>::
 --extcmd=<command>::
 	Specify a custom command for viewing diffs.
-- 
1.7.12.rc2.16.g034161a
