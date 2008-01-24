From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGit PATCH 1/4] Remove unused default values
Date: Thu, 24 Jan 2008 09:07:20 +0100
Message-ID: <20080124080714.25525.54243.stgit@yoghurt>
References: <20080124075935.25525.24416.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Catalin Marinas <catalin.marinas@gmail.com>,
	Yann Dirson <ydirson@altern.org>
To: Jon Smirl <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 24 09:08:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JHx7z-0005p1-6t
	for gcvg-git-2@gmane.org; Thu, 24 Jan 2008 09:08:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752952AbYAXIH1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 24 Jan 2008 03:07:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752948AbYAXIH0
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Jan 2008 03:07:26 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:4366 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752663AbYAXIHZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jan 2008 03:07:25 -0500
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1JHx7I-0005JM-00; Thu, 24 Jan 2008 08:07:20 +0000
In-Reply-To: <20080124075935.25525.24416.stgit@yoghurt>
User-Agent: StGIT/0.14.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71600>

This function was called from only one place, and the default values
weren't used there, so they're useless.

Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>

---

 stgit/commands/status.py |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)


diff --git a/stgit/commands/status.py b/stgit/commands/status.py
index 708dd16..02a5832 100644
--- a/stgit/commands/status.py
+++ b/stgit/commands/status.py
@@ -66,9 +66,8 @@ options =3D [make_option('-m', '--modified',
                        action =3D 'store_true')]
=20
=20
-def status(files =3D None, modified =3D False, new =3D False, deleted =
=3D False,
-           conflict =3D False, unknown =3D False, noexclude =3D False,
-           diff_flags =3D []):
+def status(files, modified, new, deleted, conflict, unknown, noexclude=
,
+           diff_flags):
     """Show the tree status
     """
     cache_files =3D git.tree_status(files,
