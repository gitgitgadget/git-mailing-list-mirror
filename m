From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGit PATCH 2/2] Add missing switch to "stg uncommit" usage line
Date: Sun, 25 Nov 2007 21:35:38 +0100
Message-ID: <20071125203538.7640.98844.stgit@yoghurt>
References: <20071125203346.7640.80801.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 25 21:36:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IwODD-0007cK-I6
	for gcvg-git-2@gmane.org; Sun, 25 Nov 2007 21:36:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756341AbXKYUfv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 25 Nov 2007 15:35:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756335AbXKYUfv
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Nov 2007 15:35:51 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:1269 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755790AbXKYUfv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Nov 2007 15:35:51 -0500
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1IwOCZ-0007Su-00; Sun, 25 Nov 2007 20:35:39 +0000
In-Reply-To: <20071125203346.7640.80801.stgit@yoghurt>
User-Agent: StGIT/0.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65989>

Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>

---

 stgit/commands/uncommit.py |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)


diff --git a/stgit/commands/uncommit.py b/stgit/commands/uncommit.py
index 9a46c94..ba3448f 100644
--- a/stgit/commands/uncommit.py
+++ b/stgit/commands/uncommit.py
@@ -26,7 +26,7 @@ from stgit.out import *
 from stgit import stack, git
=20
 help =3D 'turn regular GIT commits into StGIT patches'
-usage =3D """%prog [<patchnames>] | -n NUM [<prefix>]] | -t <committis=
h>
+usage =3D """%prog [<patchnames>] | -n NUM [<prefix>]] | -t <committis=
h> [-x]
=20
 Take one or more git commits at the base of the current stack and turn
 them into StGIT patches. The new patches are created as applied patche=
s
