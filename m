From: Jan =?UTF-8?B?S3LDvGdlcg==?= <jk@jk.gs>
Subject: [PATCH] Documentation: mention environment variables
 GIT_CONFIG_NO(GLOBAL|SYSTEM)
Date: Sun, 3 Oct 2010 23:53:29 +0200
Message-ID: <20101003235329.6f4d2572@jk.gs>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Git ML <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Oct 03 23:53:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2WVA-00087U-MJ
	for gcvg-git-2@lo.gmane.org; Sun, 03 Oct 2010 23:53:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755196Ab0JCVxe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 3 Oct 2010 17:53:34 -0400
Received: from zoidberg.org ([88.198.6.61]:55564 "EHLO cthulhu.zoidberg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755374Ab0JCVxc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Oct 2010 17:53:32 -0400
Received: from jk.gs (xdsl-89-0-8-211.netcologne.de [::ffff:89.0.8.211])
  (AUTH: LOGIN jast, SSL: TLSv1/SSLv3,128bits,AES128-SHA)
  by cthulhu.zoidberg.org with esmtp; Sun, 03 Oct 2010 23:53:32 +0200
  id 0040021A.4CA8FB5C.0000534F
X-Mailer: Claws Mail 3.7.6 (GTK+ 2.20.1; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157934>

The environment variables GIT_CONFIG_NOGLOBAL and GIT_CONFIG_NOSYSTEM
which have the opposite effect of the --global and --system switches to
git-config are completely undocumented. This mentions them in the
'files' and 'environment' sections of the manpage for git-config where
GIT_CONFIG is already mentioned.

Signed-off-by: Jan Kr=C3=BCger <jk@jk.gs>
---
 Documentation/git-config.txt |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-config.txt b/Documentation/git-config.tx=
t
index 543dd64..c3ea29c 100644
--- a/Documentation/git-config.txt
+++ b/Documentation/git-config.txt
@@ -210,6 +210,9 @@ variables. The '--global' and the '--system' option=
s will limit the file used
 to the global or system-wide file respectively. The GIT_CONFIG environ=
ment
 variable has a similar effect, but you can specify any filename you wa=
nt.
=20
+You can also set the environment GIT_CONFIG_NOGLOBAL and GIT_CONFIG_NO=
SYSTEM
+to explicitly prevent git from falling back to global/system settings.
+
=20
 ENVIRONMENT
 -----------
@@ -219,6 +222,14 @@ GIT_CONFIG::
 	Using the "--global" option forces this to ~/.gitconfig. Using the
 	"--system" option forces this to $(prefix)/etc/gitconfig.
=20
+GIT_CONFIG_NOGLOBAL::
+	If set to true, do not use the global configuration file
+	in ~/.gitconfig.
+
+GIT_CONFIG_NOSYSTEM::
+	If set to true, do not use the system-wide configuration file in
+	/etc/gitconfig.
+
 See also <<FILES>>.
=20
=20
--=20
1.7.2.3.392.g02377.dirty
