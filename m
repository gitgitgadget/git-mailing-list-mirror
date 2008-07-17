From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGit PATCH 3/5] Show full command in subprocess profiling
Date: Thu, 17 Jul 2008 22:42:38 +0200
Message-ID: <20080717204238.23407.47439.stgit@yoghurt>
References: <20080717204133.23407.34264.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 17 22:44:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJaKW-00084y-ME
	for gcvg-git-2@gmane.org; Thu, 17 Jul 2008 22:44:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932176AbYGQUmn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 17 Jul 2008 16:42:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932213AbYGQUmm
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Jul 2008 16:42:42 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:1860 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932147AbYGQUmm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jul 2008 16:42:42 -0400
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1KJaJD-0008HB-00; Thu, 17 Jul 2008 21:42:39 +0100
In-Reply-To: <20080717204133.23407.34264.stgit@yoghurt>
User-Agent: StGIT/0.14.3.197.gba718
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88917>

Showing just the executable name isn't so useful now that it's always
"git".

Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>

---

 stgit/run.py |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)


diff --git a/stgit/run.py b/stgit/run.py
index 9d50e43..befd3c1 100644
--- a/stgit/run.py
+++ b/stgit/run.py
@@ -65,7 +65,7 @@ class Run:
                     if k not in os.environ or os.environ[k] !=3D self.=
__env[k]:
                         _logfile.info('%s: %s' % (k, self.__env[k]))
         elif _log_mode =3D=3D 'profile':
-            _logfile.start('Running subprocess %s' % self.__cmd[0])
+            _logfile.start('Running subprocess %s' % self.__cmd)
             self.__starttime =3D datetime.datetime.now()
     def __log_end(self, retcode):
         if _log_mode =3D=3D 'debug':
