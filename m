From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 6/8] remote-helpers: trivial style fixes
Date: Wed, 28 Aug 2013 14:23:11 -0500
Message-ID: <1377717793-27170-7-git-send-email-felipe.contreras@gmail.com>
References: <1377717793-27170-1-git-send-email-felipe.contreras@gmail.com>
Cc: Antoine Pelisse <apelisse@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 28 21:28:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VElPt-0003jA-2I
	for gcvg-git-2@plane.gmane.org; Wed, 28 Aug 2013 21:28:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755091Ab3H1T20 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Aug 2013 15:28:26 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:41333 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755081Ab3H1T2Y (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Aug 2013 15:28:24 -0400
Received: by mail-ob0-f174.google.com with SMTP id wd6so7214931obb.33
        for <git@vger.kernel.org>; Wed, 28 Aug 2013 12:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=beKzcOnS38Im+X96b3EAORrLZq4t9AjuHrhAWCf1WMQ=;
        b=qngYzJB2e7r9F/F3YmpmPriCcwVbkMx4KJSGF93F2D1Nz+y+bGEP5/i9PjGporyxpI
         tDLw3h3YMak2hs33Xp/FGtfx6QFrq7fZdVXnFEZoz900IZ3A1CkSfSFcnLZzbYu/exhf
         bG7Vbx6PsylzwGh8FMLM5lbepsjOxM/Jend54eAdzOJIDUv23TjbntWwE93CiFMTzmDX
         hz1jJW2/b2xifiLrRHCNw6KzDCpMq8olmKlwFDM72yULI3X2zHuL6rHOaA0yo5x/hgJn
         PlRKTN4qlpZWTiylTtAF8IKU0rWzSYl8asCRzPYrvMdpfHV/OqXcPGG2VUmoUEKuTruL
         rtHw==
X-Received: by 10.60.42.168 with SMTP id p8mr1717626oel.73.1377718103656;
        Wed, 28 Aug 2013 12:28:23 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id it7sm27513723obb.11.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 28 Aug 2013 12:28:22 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-fc
In-Reply-To: <1377717793-27170-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233200>

In accordance with pep8.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/git-remote-bzr | 4 ++--
 contrib/remote-helpers/git-remote-hg  | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/contrib/remote-helpers/git-remote-bzr b/contrib/remote-helpers/git-remote-bzr
index a7d2ac9..e4fdfb0 100755
--- a/contrib/remote-helpers/git-remote-bzr
+++ b/contrib/remote-helpers/git-remote-bzr
@@ -488,7 +488,7 @@ class CustomTree():
             add_entry(fid, dirname, 'directory')
             return fid
 
-        def add_entry(fid, path, kind, mode = None):
+        def add_entry(fid, path, kind, mode=None):
             dirname, basename = os.path.split(path)
             parent_fid = get_parent(dirname, basename)
 
@@ -509,7 +509,7 @@ class CustomTree():
             self.files[path] = [change[0], None]
             changes.append(change)
 
-        def update_entry(fid, path, kind, mode = None):
+        def update_entry(fid, path, kind, mode=None):
             dirname, basename = os.path.split(path)
             parent_fid = get_parent(dirname, basename)
 
diff --git a/contrib/remote-helpers/git-remote-hg b/contrib/remote-helpers/git-remote-hg
index d2ff0e2..178a5a5 100755
--- a/contrib/remote-helpers/git-remote-hg
+++ b/contrib/remote-helpers/git-remote-hg
@@ -1079,7 +1079,7 @@ def do_export(parser):
             author, msg = parsed_tags.get(tag, (None, None))
             if mode == 'git':
                 if not msg:
-                    msg = 'Added tag %s for changeset %s' % (tag, node[:12]);
+                    msg = 'Added tag %s for changeset %s' % (tag, node[:12])
                 tagnode, branch = write_tag(parser.repo, tag, node, msg, author)
                 p_revs[tagnode] = 'refs/heads/branches/' + gitref(branch)
             else:
-- 
1.8.4-fc
