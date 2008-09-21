From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGit PATCH] Remove misleading "stg delete" documentation
Date: Sun, 21 Sep 2008 21:06:35 +0200
Message-ID: <20080921190635.4333.24979.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 21 21:07:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KhUHi-0001V4-9E
	for gcvg-git-2@gmane.org; Sun, 21 Sep 2008 21:07:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752822AbYIUTGp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 21 Sep 2008 15:06:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752419AbYIUTGo
	(ORCPT <rfc822;git-outgoing>); Sun, 21 Sep 2008 15:06:44 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:3153 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752281AbYIUTGn (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Sep 2008 15:06:43 -0400
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1KhUby-0003ZL-00; Sun, 21 Sep 2008 20:28:50 +0100
User-Agent: StGIT/0.14.3.236.g0c611
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96422>

With the recent arrival of the stack log, patch
deletion can now be undone.

Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>

---

 stgit/commands/delete.py |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)


diff --git a/stgit/commands/delete.py b/stgit/commands/delete.py
index 40cef3f..1b59cdd 100644
--- a/stgit/commands/delete.py
+++ b/stgit/commands/delete.py
@@ -25,9 +25,7 @@ help =3D 'Delete patches'
 kind =3D 'patch'
 usage =3D ['[options] <patch1> [<patch2>] [<patch3>..<patch4>]']
 description =3D """
-Delete the patches passed as arguments.
-
-Note that the 'delete' operation is irreversible."""
+Delete the patches passed as arguments."""
=20
 args =3D [argparse.patch_range(argparse.applied_patches,
                              argparse.unapplied_patches)]
