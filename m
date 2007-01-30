From: "Aneesh Kumar K.V" <aneesh.kumar@gmail.com>
Subject: [PATCH] Update git-cat-file documentation
Date: Tue, 30 Jan 2007 13:26:51 +0530
Message-ID: <45befa72.48e904b7.4b64.ffffd83b@mx.google.com>
References: <11701438112263-git-send-email-> <11701438241247-git-send-email-> <11701438362085-git-send-email->
Cc: junkio@cox.net
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 30 08:58:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HBnsq-0000RL-AZ
	for gcvg-git@gmane.org; Tue, 30 Jan 2007 08:58:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965442AbXA3H5k (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 30 Jan 2007 02:57:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965444AbXA3H5k
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Jan 2007 02:57:40 -0500
Received: from py-out-1112.google.com ([64.233.166.177]:22180 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965443AbXA3H5j (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Jan 2007 02:57:39 -0500
Received: by py-out-1112.google.com with SMTP id a29so949562pyi
        for <git@vger.kernel.org>; Mon, 29 Jan 2007 23:57:39 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:cc:subject:date:x-mailer:in-reply-to:references:message-id;
        b=YMqQSSA9TzbcraMSdbjKRQudLk3j8rEYMro3IALMTfWfM1K64a3lni6GktJLCqdXx28YgkYbUF/wTnYTPRenYDry7O46T+tWTb3Af/8ebtSrMawEUcQCZdTXa/1TwBhqvJZ+JdgY/wqnxizEzt4jTJ9QMLd4lFFg/N2mY2C7xTw=
Received: by 10.35.121.9 with SMTP id y9mr14533504pym.1170143858983;
        Mon, 29 Jan 2007 23:57:38 -0800 (PST)
Received: from localhost ( [59.92.165.143])
        by mx.google.com with ESMTP id n63sm7300570pyh.2007.01.29.23.57.34;
        Mon, 29 Jan 2007 23:57:38 -0800 (PST)
X-Mailer: git-send-email 1.5.0.rc2.75.gdbaa0-dirty
In-Reply-To: <11701438362085-git-send-email->
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38132>

From: Aneesh Kumar K.V <aneesh.kumar@gmail.com> - unquoted

Update git-cat-file documentation with references for different
ways of specifying <objects>

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@gmail.com>
---
 Documentation/git-cat-file.txt |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-cat-file.txt b/Documentation/git-cat-file.txt
index 7e90ce9..075c0d0 100644
--- a/Documentation/git-cat-file.txt
+++ b/Documentation/git-cat-file.txt
@@ -19,7 +19,9 @@ or '-s' is used to find the object size.
 OPTIONS
 -------
 <object>::
-	The sha1 identifier of the object.
+	The name of the object to show.
+	For a more complete list of ways to spell object names, see
+	"SPECIFYING REVISIONS" section in gitlink:git-rev-parse[1].
 
 -t::
 	Instead of the content, show the object type identified by
-- 
1.5.0.rc2.75.gdbaa0-dirty
