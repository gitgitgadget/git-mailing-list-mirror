From: Jan =?UTF-8?B?S3LDvGdlcg==?= <jk@jk.gs>
Subject: [PATCH] Documentation: commit: explain the non-meaning of S-o-b
Date: Tue, 1 Dec 2009 23:25:20 +0100
Message-ID: <20091201232520.45579cbb@perceptron>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Git ML <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Dec 01 23:25:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NFbA2-0003Vw-T8
	for gcvg-git-2@lo.gmane.org; Tue, 01 Dec 2009 23:25:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753585AbZLAWZT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 1 Dec 2009 17:25:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752917AbZLAWZS
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Dec 2009 17:25:18 -0500
Received: from zoidberg.org ([88.198.6.61]:50605 "EHLO cthulhu.zoidberg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752430AbZLAWZS convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 1 Dec 2009 17:25:18 -0500
Received: from perceptron (xdsl-78-35-144-134.netcologne.de [::ffff:78.35.144.134])
  (IDENT: unknown, AUTH: LOGIN jast, TLS: TLSv1/SSLv3,128bits,AES128-SHA)
  by cthulhu.zoidberg.org with esmtp; Tue, 01 Dec 2009 23:25:22 +0100
  id 004D0364.4B1597D2.000022A1
X-Mailer: Claws Mail 3.7.3 (GTK+ 2.18.3; i486-pc-linux-gnu)
X-Obscure-Spam: http://music-jk.net/
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134261>

In the manpage for git commit, the option --signoff is mentioned but
there is no explanation of what it actually means. Add a brief hint tha=
t
S-o-b doesn't have a pre-defined meaning.

Signed-off-by: Jan Kr=C3=BCger <jk@jk.gs>
---
 Documentation/git-commit.txt |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.tx=
t
index d227cec..cae510b 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -100,7 +100,8 @@ OPTIONS
 -s::
 --signoff::
 	Add Signed-off-by line by the committer at the end of the commit
-	log message.
+	log message. This line has no inherent meaning; what it stands for
+	is up to whoever includes this commit in a repository.
=20
 -n::
 --no-verify::
--=20
1.6.5.3.171.ge36e
