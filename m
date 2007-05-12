From: Yann Dirson <ydirson@altern.org>
Subject: [StGIT PATCH v2] Document patch syntax.
Date: Sat, 12 May 2007 20:59:30 +0200
Message-ID: <20070512185919.26101.3956.stgit@gandelf.nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 12 21:01:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HmwqA-0000qV-TC
	for gcvg-git@gmane.org; Sat, 12 May 2007 21:01:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760061AbXELTAk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sat, 12 May 2007 15:00:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756912AbXELTAk
	(ORCPT <rfc822;git-outgoing>); Sat, 12 May 2007 15:00:40 -0400
Received: from smtp3-g19.free.fr ([212.27.42.29]:40296 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760061AbXELTAi (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 May 2007 15:00:38 -0400
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp3-g19.free.fr (Postfix) with ESMTP id 2B1425E52E;
	Sat, 12 May 2007 21:00:37 +0200 (CEST)
Received: from gandelf.nowhere.earth (localhost [127.0.0.1])
	by gandelf.nowhere.earth (Postfix) with ESMTP id B0B371F15F;
	Sat, 12 May 2007 20:59:30 +0200 (CEST)
User-Agent: StGIT/0.12
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47072>


Acked-by: Karl Hasselstr=F6m <kha@treskal.com>

Signed-off-by: Yann Dirson <ydirson@altern.org>
---

 Documentation/stg.txt |   25 +++++++++++++++++++++++++
 1 files changed, 25 insertions(+), 0 deletions(-)

diff --git a/Documentation/stg.txt b/Documentation/stg.txt
index af57c37..bc2a6fe 100644
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
+Patches in the stack are identified with a short name, which must be
+unique in the stack.
+
+Patches in the current stack are just refered to by their name.  Some
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
