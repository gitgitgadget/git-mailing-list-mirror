From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGit PATCH 2/5] Wrap excessively long line
Date: Tue, 29 Jan 2008 04:03:31 +0100
Message-ID: <20080129030256.926.84384.stgit@yoghurt>
References: <20080129030059.926.29897.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 29 04:04:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JJglY-0004AU-LQ
	for gcvg-git-2@gmane.org; Tue, 29 Jan 2008 04:04:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754295AbYA2DDe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 Jan 2008 22:03:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754227AbYA2DDe
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Jan 2008 22:03:34 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:1920 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754158AbYA2DDd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jan 2008 22:03:33 -0500
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1JJgl0-0000X5-00; Tue, 29 Jan 2008 03:03:30 +0000
In-Reply-To: <20080129030059.926.29897.stgit@yoghurt>
User-Agent: StGIT/0.14.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71928>

Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>

---

I try to kill those whenever I can get away with it ...

 stgit/commands/common.py |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)


diff --git a/stgit/commands/common.py b/stgit/commands/common.py
index 7d9df02..7a7cb80 100644
--- a/stgit/commands/common.py
+++ b/stgit/commands/common.py
@@ -274,7 +274,8 @@ def name_email(address):
     if not str_list:
         str_list =3D re.findall('^(.*)\s*\((.*)\)\s*$', address)
         if not str_list:
-            raise CmdException, 'Incorrect "name <email>"/"email (name=
)" string: %s' % address
+            raise CmdException('Incorrect "name <email>"/"email (name)=
"'
+                               ' string: %s' % address)
         return ( str_list[0][1], str_list[0][0] )
=20
     return str_list[0]
