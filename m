From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGit PATCH] Make Run available in stack.py
Date: Wed, 26 Sep 2007 04:08:45 +0200
Message-ID: <20070926020722.1105.91287.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 26 04:09:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IaMKf-0003M8-Bf
	for gcvg-git-2@gmane.org; Wed, 26 Sep 2007 04:08:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753557AbXIZCIu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 25 Sep 2007 22:08:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752499AbXIZCIu
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Sep 2007 22:08:50 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:3825 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753557AbXIZCIt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Sep 2007 22:08:49 -0400
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1IaMKT-0006gv-00; Wed, 26 Sep 2007 03:08:45 +0100
User-Agent: StGIT/0.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59208>

Needed by shortlog(). Apparently, we have no test for this.

Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>

---

And I have no idea how I could have avoided triggering this for as
long as I have. I mean, I tested this by sending the patch to the
list!

 stgit/stack.py |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)


diff --git a/stgit/stack.py b/stgit/stack.py
index 746e59b..bd08b35 100644
--- a/stgit/stack.py
+++ b/stgit/stack.py
@@ -23,6 +23,7 @@ from email.Utils import formatdate
=20
 from stgit.utils import *
 from stgit.out import *
+from stgit.run import *
 from stgit import git, basedir, templates
 from stgit.config import config
 from shutil import copyfile
