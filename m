From: =?utf-8?Q?Santi_B=C3=A9jar?= <sbejar@gmail.com>
Subject: [PATCH] Documentation for the [remote] config
Date: Mon, 23 Oct 2006 18:42:14 +0200
Message-ID: <87pscjnfvd.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Mon Oct 23 18:43:49 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Gc2sb-0002iJ-K5
	for gcvg-git@gmane.org; Mon, 23 Oct 2006 18:42:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752002AbWJWQmV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 23 Oct 2006 12:42:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752003AbWJWQmU
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Oct 2006 12:42:20 -0400
Received: from ifae-s0.ifae.es ([192.101.162.68]:32699 "EHLO ifae-s0.ifae.es")
	by vger.kernel.org with ESMTP id S1752002AbWJWQmU (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 Oct 2006 12:42:20 -0400
Received: from bela (caronte.ifae.es [192.101.162.199])
	by ifae-s0.ifae.es (8.11.6/8.11.6) with ESMTP id k9NGgHN28946
	for <git@vger.kernel.org>; Mon, 23 Oct 2006 18:42:17 +0200
To: Git Mailing List <git@vger.kernel.org>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/22.0.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29845>



Signed-off-by: Santi B=C3=A9jar <sbejar@gmail.com>
---
 Documentation/config.txt |   12 ++++++++++++
 Documentation/urls.txt   |    8 ++++++++
 2 files changed, 20 insertions(+), 0 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 84e3891..ee51fe3 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -230,6 +230,18 @@ pull.octopus::
 pull.twohead::
 	The default merge strategy to use when pulling a single branch.
=20
+remote.<name>.url::
+	The URL of a remote repository.  See gitlink:git-fetch[1] or
+	gitlink:git-push[1].
+
+remote.<name>.fetch::
+	The default set of "refspec" for gitlink:git-fetch[1]. See
+	gitlink:git-fetch[1].
+
+remote.<name>.push::
+	The default set of "refspec" for gitlink:git-push[1]. See
+	gitlink:git-push[1].
+
 show.difftree::
 	The default gitlink:git-diff-tree[1] arguments to be used
 	for gitlink:git-show[1].
diff --git a/Documentation/urls.txt b/Documentation/urls.txt
index 26ecba5..670827c 100644
--- a/Documentation/urls.txt
+++ b/Documentation/urls.txt
@@ -51,6 +51,14 @@ lines are used for `git-push` and `git-f
 respectively.  Multiple `Push:` and `Pull:` lines may
 be specified for additional branch mappings.
=20
+Or, equivalently, in the `$GIT_DIR/config` (note the use
+of `fetch` instead of `Pull:`):
+
+[remote "<remote>"]
+	url =3D <url>
+	push =3D <refspec>
+	fetch =3D <refspec>
+
 The name of a file in `$GIT_DIR/branches` directory can be
 specified as an older notation short-hand; the named
 file should contain a single line, a URL in one of the
--=20
1.4.3.1.gf8f0bb
