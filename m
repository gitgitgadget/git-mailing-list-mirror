From: David Aguilar <davvid@gmail.com>
Subject: [PATCH 4/4] git-diff.txt: Link to git-difftool
Date: Sat,  9 Jan 2010 20:02:43 -0800
Message-ID: <1263096163-15743-4-git-send-email-davvid@gmail.com>
References: <1263096163-15743-1-git-send-email-davvid@gmail.com>
Cc: git@vger.kernel.org, markus.heidelberg@web.de
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sun Jan 10 05:03:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NTp1d-0002Bl-2f
	for gcvg-git-2@lo.gmane.org; Sun, 10 Jan 2010 05:03:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751768Ab0AJEDQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Jan 2010 23:03:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751713Ab0AJEDQ
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Jan 2010 23:03:16 -0500
Received: from mail-yw0-f176.google.com ([209.85.211.176]:44885 "EHLO
	mail-yw0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751684Ab0AJEDP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Jan 2010 23:03:15 -0500
Received: by mail-yw0-f176.google.com with SMTP id 6so20613351ywh.4
        for <git@vger.kernel.org>; Sat, 09 Jan 2010 20:03:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=rBxdSfNEswYKCGFmYadflFzSWMK2AJHSP6zG3fd0jNc=;
        b=IdFY3oI4UGa7IW8gPB7NvA459qTqp0J9FhTAheXaz4iNP8tOzGJSkbJOhOTk/yqRD6
         WCdk+aKvh4gjbGwuE+7Ji6EmI9m3ugmKm0nuUa7ByZ4Txn+VchEq6Za8tjxPBjY8vftc
         cCOMpb20088A12p6xYfu7uc46hi5HCWlp8trQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=VyYDIgX09v2fHbBicUGdyoOmPhIzbU/myPfqtVT8ii/jl2UlF7Lpdwy76hcTpKWPEh
         +wjkZxedYFMrfVuX/ajsz0qmOaARvAlkvzry0FyYjhtjKPku2jwdW4ZnpoguIaaMykVV
         BYthwY0vPQ1bzEFqLJ/1NVQWOr6RWRZIwzkmc=
Received: by 10.100.56.12 with SMTP id e12mr8642260ana.106.1263096194972;
        Sat, 09 Jan 2010 20:03:14 -0800 (PST)
Received: from localhost (208-106-56-2.static.dsltransport.net [208.106.56.2])
        by mx.google.com with ESMTPS id 9sm9924509yxf.59.2010.01.09.20.03.10
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 09 Jan 2010 20:03:11 -0800 (PST)
X-Mailer: git-send-email 1.6.6.4.g20a38b.dirty
In-Reply-To: <1263096163-15743-1-git-send-email-davvid@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136554>

Signed-off-by: David Aguilar <davvid@gmail.com>
---
 Documentation/git-diff.txt |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-diff.txt b/Documentation/git-diff.txt
index 0ac7112..723a648 100644
--- a/Documentation/git-diff.txt
+++ b/Documentation/git-diff.txt
@@ -157,6 +157,10 @@ $ git diff -R                          <2>
 rewrites (very expensive).
 <2> Output diff in reverse.
 
+SEE ALSO
+--------
+linkgit:git-difftool[1]::
+	Show changes using common diff tools
 
 Author
 ------
-- 
1.6.6.4.g20a38b.dirty
