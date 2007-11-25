From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGit PATCH 1/2] Push and pop don't have --to flags anymore
Date: Sun, 25 Nov 2007 21:35:32 +0100
Message-ID: <20071125203532.7640.91609.stgit@yoghurt>
References: <20071125203346.7640.80801.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 25 21:36:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IwODC-0007cK-Th
	for gcvg-git-2@gmane.org; Sun, 25 Nov 2007 21:36:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756336AbXKYUfi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 25 Nov 2007 15:35:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756341AbXKYUfi
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Nov 2007 15:35:38 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:1263 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756335AbXKYUfh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Nov 2007 15:35:37 -0500
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1IwOCT-0007Sg-00; Sun, 25 Nov 2007 20:35:33 +0000
In-Reply-To: <20071125203346.7640.80801.stgit@yoghurt>
User-Agent: StGIT/0.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65988>

Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>

---

 stgit/commands/goto.py |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)


diff --git a/stgit/commands/goto.py b/stgit/commands/goto.py
index 7f9d45d..84b840b 100644
--- a/stgit/commands/goto.py
+++ b/stgit/commands/goto.py
@@ -27,9 +27,8 @@ help =3D 'push or pop patches to the given one'
 usage =3D """%prog [options] <name>
=20
 Push/pop patches to/from the stack until the one given on the command
-line becomes current. This is a shortcut for the 'push --to' or 'pop
---to' commands. There is no '--undo' option for 'goto'. Use the 'push'
-command for this."""
+line becomes current. There is no '--undo' option for 'goto'. Use the
+'push --undo' command for this."""
=20
 directory =3D DirectoryGotoToplevel()
 options =3D [make_option('-k', '--keep',
