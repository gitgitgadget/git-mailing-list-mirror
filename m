From: Charles Matthew Chen <charlesmchen@gmail.com>
Subject: [PATCH] Add --recursive flag to documentation of git submodule sync command.
Date: Fri, 13 Jun 2014 13:40:50 -0400
Message-ID: <CACQxx-Ej-gcHp4PM-E1CCt9x+i99_N-VaNOrRpo6YwkAuhe2UA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: hjemli@gmail.com, pasky@ucw.cz, Jens.Lehmann@web.de
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 13 19:40:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WvVTD-00058F-El
	for gcvg-git-2@plane.gmane.org; Fri, 13 Jun 2014 19:40:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753720AbaFMRkw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Jun 2014 13:40:52 -0400
Received: from mail-qc0-f170.google.com ([209.85.216.170]:34278 "EHLO
	mail-qc0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753225AbaFMRkv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jun 2014 13:40:51 -0400
Received: by mail-qc0-f170.google.com with SMTP id l6so4570590qcy.29
        for <git@vger.kernel.org>; Fri, 13 Jun 2014 10:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        bh=WdvsoV+mUxTbSPRb9KuY3nHIWyGjXnP0kzMN/TFBOvw=;
        b=zGKfh5Nc/42YjvvLCeWRwGirDJccvAgtmF7exQy292JzabLQnM0DZ08zx3rGbO3U1E
         CXB4Dy0LwIktyl1ktxCdAW6xuVEL42PT4t1HBQkXhtaQ3VKbNVkZ56Av/SFv7E290aw6
         rjQhQxijpespiixP5O+jAQX5xMGQ7B39QF6Xb9h0XHQC3qogI81B5iFyaDGTo9EcCpLa
         wC+u5pyu+bp7WvawT53YU5Dnn7G2LmfWi2xDTijHQq9QaI3XjqMG7/2vptN9+zpPiHYq
         bVngi2LXf03+1Jl7cskH/VCyUWkfOVEHdzldwnf8ylkk5kLVAODAnVN9w/0LvYNlH1or
         PI0w==
X-Received: by 10.140.33.200 with SMTP id j66mr5545957qgj.81.1402681250889;
 Fri, 13 Jun 2014 10:40:50 -0700 (PDT)
Received: by 10.140.102.51 with HTTP; Fri, 13 Jun 2014 10:40:50 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251619>

The "git submodule sync" command supports the --recursive flag, but
the documentation does not mention this.  That flag is useful, for
example when a remote is changed in a submodule of a submodule.

Signed-off-by: Matthew Chen <charlesmchen@gmail.com>
---
 Documentation/git-submodule.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index 89c4d3e..8e6af65 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -20,7 +20,7 @@ SYNOPSIS
 'git submodule' [--quiet] summary [--cached|--files] [(-n|--summary-limit) <n>]
       [commit] [--] [<path>...]
 'git submodule' [--quiet] foreach [--recursive] <command>
-'git submodule' [--quiet] sync [--] [<path>...]
+'git submodule' [--quiet] sync [--recursive] [--] [<path>...]


 DESCRIPTION
-- 
1.8.5.3
