From: A Large Angry SCM <gitzilla@gmail.com>
Subject: [PATCH] Docs for git-show-rev-cache.
Date: Wed, 07 Sep 2005 17:19:48 -0400
Message-ID: <431F5974.6080306@gmail.com>
Reply-To: gitzilla@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Wed Sep 07 23:25:29 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ED7Kk-0002ch-6E
	for gcvg-git@gmane.org; Wed, 07 Sep 2005 23:19:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932412AbVIGVTv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 7 Sep 2005 17:19:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932425AbVIGVTv
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Sep 2005 17:19:51 -0400
Received: from wproxy.gmail.com ([64.233.184.201]:49449 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932412AbVIGVTv (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 7 Sep 2005 17:19:51 -0400
Received: by wproxy.gmail.com with SMTP id 57so1193411wri
        for <git@vger.kernel.org>; Wed, 07 Sep 2005 14:19:50 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:disposition-notification-to:date:from:reply-to:user-agent:x-accept-language:mime-version:to:subject:content-type:content-transfer-encoding;
        b=nJ+qQ9dgsAEuLu5aGsLtLz61hoDIELeW9fZ9Gta9D/Mah4iTmJcWybWDjdNlabsM9iVdeVZVEpmjhQqg1zjk/LY5vlEn7UNzVcuEZmjza/et5cAgFASWfkNuFT+wM3fyhH5VPOs0tJGlR193dXQk6h6sMZ4Fk2461LbTuQWBWDQ=
Received: by 10.54.33.17 with SMTP id g17mr5446038wrg;
        Wed, 07 Sep 2005 14:19:50 -0700 (PDT)
Received: from ?10.0.0.6? ( [70.89.97.98])
        by mx.gmail.com with ESMTP id d75sm888951wra.2005.09.07.14.19.49;
        Wed, 07 Sep 2005 14:19:50 -0700 (PDT)
User-Agent: Mozilla Thunderbird 1.0 (X11/20041207)
X-Accept-Language: en-us, en
To: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8179>


Signed-off-by: A Large Angry SCM <gitzilla@gmail.com>


---

 Documentation/git-show-rev-cache.txt |   19 +++++++++----------
 1 files changed, 9 insertions(+), 10 deletions(-)

818a8f421dfa978aa4df7103e34aeadf1ba971f5
diff --git a/Documentation/git-show-rev-cache.txt b/Documentation/git-show-rev-cache.txt
--- a/Documentation/git-show-rev-cache.txt
+++ b/Documentation/git-show-rev-cache.txt
@@ -3,26 +3,25 @@ git-show-rev-cache(1)
 
 NAME
 ----
-git-show-rev-cache - Some git command not yet documented.
-
+git-show-rev-cache - Show the contents of a rev-cache file.
 
 SYNOPSIS
 --------
-'git-show-rev-cache' [ --option ] <args>...
+'git-show-rev-cache' <rev-cache-file>
 
 DESCRIPTION
 -----------
-Does something not yet documented.
+Show the contents of <rev-cache-file>.
 
+A rev-cache file describes the commit ancestry reachable from references
+supplied as input to get-build-rev-cache. This file is in an
+append-only binary format to make the server side friendly to rsync
+mirroring scheme.
 
 OPTIONS
 -------
---option::
-	Some option not yet documented.
-
-<args>...::
-	Some argument not yet documented.
-
+<rev-cache-file>::
+	Rev-cache file to display.
 
 Author
 ------
