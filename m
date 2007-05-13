From: Yann Dirson <ydirson@altern.org>
Subject: [StGIT PATCH v3] Document patch syntax.
Date: Sun, 13 May 2007 16:11:54 +0200
Message-ID: <20070513141144.20793.96515.stgit@gandelf.nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 13 16:13:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HnEp2-0002b8-93
	for gcvg-git@gmane.org; Sun, 13 May 2007 16:13:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756351AbXEMONH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 13 May 2007 10:13:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758563AbXEMONH
	(ORCPT <rfc822;git-outgoing>); Sun, 13 May 2007 10:13:07 -0400
Received: from smtp3-g19.free.fr ([212.27.42.29]:45647 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756351AbXEMONG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 May 2007 10:13:06 -0400
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp3-g19.free.fr (Postfix) with ESMTP id DDE8C605E7;
	Sun, 13 May 2007 16:13:03 +0200 (CEST)
Received: from gandelf.nowhere.earth (localhost [127.0.0.1])
	by gandelf.nowhere.earth (Postfix) with ESMTP id 923571F15F;
	Sun, 13 May 2007 16:11:54 +0200 (CEST)
User-Agent: StGIT/0.12
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47149>


Acked-by: Karl Hasselstr=C3=B6m <kha@treskal.com>

Signed-off-by: Yann Dirson <ydirson@altern.org>
---

 Documentation/stg.txt |   25 +++++++++++++++++++++++++
 1 files changed, 25 insertions(+), 0 deletions(-)

diff --git a/Documentation/stg.txt b/Documentation/stg.txt
index af57c37..4f9d18e 100644
--- a/Documentation/stg.txt
+++ b/Documentation/stg.txt
@@ -51,6 +51,31 @@ Development branch::
 In such a setup, not all commits on your branch need to be StGIT
 patches; there may be regular GIT commits below your stack base.
=20
+Patches
+~~~~~~~
+
+Many StGIT commands take references to StGIT patches as arguments.
+Patches in the stack are identified with short names, each of which
+must be unique in the stack.
+
+Patches in the current stack are just referred to by their name.  Some
+commands allow you to specify a patch in another stack of the reposito=
ry;
+this is done by suffixing the patch name with an '@' sign followed by =
the
+branch name (eg. 'thispatch@otherbranch').
+
+A number of positions in the stack related to the patch are also
+accessible through '//' suffixes.  For example, 'patch//top' is
+equivalent to 'patch', and 'patch//bottom' refers to the commit below
+'patch' (i.e. the patch below, or the stack base if this is the
+bottom-most patch).  Similarly '//top.old' and '//bottom.old'
+refer to the previous version of the patch (before the last
+stglink:push[] or stglink:refresh[] operation).  When referring to the
+current patch, its name can be omitted (eg. 'currentpatch//bottom.old'
+can be abbreviated as 'bottom.old').
+
+If you need to pass a given StGIT reference to a git command,
+stglink:id[] will convert it to a git commit id.
+
 OPTIONS
 -------
=20
