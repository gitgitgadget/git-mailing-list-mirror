From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGit PATCH 6/8] Simplify debug level error checking
Date: Mon, 08 Oct 2007 01:17:47 +0200
Message-ID: <20071007231747.12626.26660.stgit@yoghurt>
References: <20071007231446.12626.14259.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 08 01:18:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IefOW-0003Sh-0P
	for gcvg-git-2@gmane.org; Mon, 08 Oct 2007 01:18:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756679AbXJGXRw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 7 Oct 2007 19:17:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756085AbXJGXRw
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Oct 2007 19:17:52 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:1375 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755979AbXJGXRv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Oct 2007 19:17:51 -0400
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1IefNc-0000Li-00; Mon, 08 Oct 2007 00:17:48 +0100
In-Reply-To: <20071007231446.12626.14259.stgit@yoghurt>
User-Agent: StGIT/0.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60245>

Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>

---

 stgit/main.py |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)


diff --git a/stgit/main.py b/stgit/main.py
index f54330d..19ba2bd 100644
--- a/stgit/main.py
+++ b/stgit/main.py
@@ -261,9 +261,7 @@ def main():
     from stgit.stack import Series
=20
     try:
-        debug_level =3D int(os.environ['STGIT_DEBUG_LEVEL'])
-    except KeyError:
-        debug_level =3D 0
+        debug_level =3D int(os.environ.get('STGIT_DEBUG_LEVEL', 0))
     except ValueError:
         out.error('Invalid STGIT_DEBUG_LEVEL environment variable')
         sys.exit(1)
