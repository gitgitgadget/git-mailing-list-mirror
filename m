From: Pavel Roskin <proski@gnu.org>
Subject: [PATCH 2/2] Set datarootdir in config.mak.in
Date: Sat, 15 Jul 2006 01:29:21 -0400
Message-ID: <20060715052921.19165.66254.stgit@dv.roinet.com>
References: <20060715052919.19165.19665.stgit@dv.roinet.com>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
X-From: git-owner@vger.kernel.org Sat Jul 15 07:29:37 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G1ciY-0003sr-Oo
	for gcvg-git@gmane.org; Sat, 15 Jul 2006 07:29:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932447AbWGOF3Z (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 15 Jul 2006 01:29:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932457AbWGOF3Z
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Jul 2006 01:29:25 -0400
Received: from fencepost.gnu.org ([199.232.76.164]:2769 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S932447AbWGOF3Y
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Jul 2006 01:29:24 -0400
Received: from proski by fencepost.gnu.org with local (Exim 4.34)
	id 1G1ciQ-0007ON-UO
	for git@vger.kernel.org; Sat, 15 Jul 2006 01:29:23 -0400
Received: from [127.0.0.1] (helo=dv.roinet.com)
	by dv.roinet.com with esmtp (Exim 4.62)
	(envelope-from <proski@gnu.org>)
	id 1G1ciP-0004zL-WD
	for git@vger.kernel.org; Sat, 15 Jul 2006 01:29:22 -0400
To: git@vger.kernel.org
In-Reply-To: <20060715052919.19165.19665.stgit@dv.roinet.com>
User-Agent: StGIT/0.10
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23924>

From: Pavel Roskin <proski@gnu.org>

Autoconf 2.60 expresses datadir in terms of datarootdir.  If datarootdir
is not substituted, configure issues a warning and uses a compatibility
substitution for datadir.

Signed-off-by: Pavel Roskin <proski@gnu.org>
---

 config.mak.in |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/config.mak.in b/config.mak.in
index 89520eb..04f508a 100644
--- a/config.mak.in
+++ b/config.mak.in
@@ -10,6 +10,7 @@ prefix = @prefix@
 exec_prefix = @exec_prefix@
 bindir = @bindir@
 #gitexecdir = @libexecdir@/git-core/
+datarootdir = @datarootdir@
 template_dir = @datadir@/git-core/templates/
 GIT_PYTHON_DIR = @datadir@/git-core/python
 
