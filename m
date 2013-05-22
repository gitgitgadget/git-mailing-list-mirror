From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH] push: document --no-verify
Date: Wed, 22 May 2013 13:43:56 +0300
Message-ID: <20130522104356.GA5472@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@inf.ethz.ch>,
	Aaron Schrab <aaron@schrab.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 22 12:43:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uf6WO-0004pN-FR
	for gcvg-git-2@plane.gmane.org; Wed, 22 May 2013 12:43:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755970Ab3EVKns (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 May 2013 06:43:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:61482 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755098Ab3EVKns (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 May 2013 06:43:48 -0400
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r4MAhYL7007813
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Wed, 22 May 2013 06:43:34 -0400
Received: from redhat.com (vpn-202-164.tlv.redhat.com [10.35.202.164])
	by int-mx11.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with SMTP id r4MAhVPW025578;
	Wed, 22 May 2013 06:43:32 -0400
Content-Disposition: inline
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.24
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225145>

commit ec55559f937727bcb0fa8a3dfe6af68c188e968a added
--no-verify flag to git push, but didn't document it.
It's a useful flag when using pre-push hooks so
add the documentation.

Suggested-by: Thomas Rast <trast@inf.ethz.ch>
Cc: Aaron Schrab <aaron@schrab.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 Documentation/git-push.txt | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
index d514813..346b28a 100644
--- a/Documentation/git-push.txt
+++ b/Documentation/git-push.txt
@@ -11,7 +11,7 @@ SYNOPSIS
 [verse]
 'git push' [--all | --mirror | --tags] [--follow-tags] [-n | --dry-run] [--receive-pack=<git-receive-pack>]
 	   [--repo=<repository>] [-f | --force] [--prune] [-v | --verbose] [-u | --set-upstream]
-	   [<repository> [<refspec>...]]
+	   [--no-verify]  [<repository> [<refspec>...]]
 
 DESCRIPTION
 -----------
@@ -162,6 +162,11 @@ useful if you write an alias or script around 'git push'.
 	linkgit:git-pull[1] and other commands. For more information,
 	see 'branch.<name>.merge' in linkgit:git-config[1].
 
+-n::
+--no-verify::
+	This option bypasses the pre-commit and commit-msg hooks.
+	See also linkgit:githooks[5].
+
 --[no-]thin::
 	These options are passed to linkgit:git-send-pack[1]. A thin transfer
 	significantly reduces the amount of sent data when the sender and
-- 
MST
