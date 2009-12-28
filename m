From: Jan =?UTF-8?B?S3LDvGdlcg==?= <jk@jk.gs>
Subject: [PATCH] Documentation: commit: explain the non-meaning of S-o-b
Date: Mon, 28 Dec 2009 19:40:01 +0100
Message-ID: <20091228194001.7b4c68f4@perceptron>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git ML <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 28 19:40:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NPKVz-0006nj-2r
	for gcvg-git-2@lo.gmane.org; Mon, 28 Dec 2009 19:40:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751042AbZL1SkH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 Dec 2009 13:40:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750995AbZL1SkH
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Dec 2009 13:40:07 -0500
Received: from zoidberg.org ([88.198.6.61]:39919 "EHLO cthulhu.zoidberg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750961AbZL1SkG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 28 Dec 2009 13:40:06 -0500
Received: from perceptron (xdsl-78-35-151-202.netcologne.de [::ffff:78.35.151.202])
  (AUTH: LOGIN jast, TLS: TLSv1/SSLv3,128bits,AES128-SHA)
  by cthulhu.zoidberg.org with esmtp; Mon, 28 Dec 2009 19:40:04 +0100
  id 004D04AB.4B38FB84.00004607
X-Mailer: Claws Mail 3.7.3 (GTK+ 2.18.3; i486-pc-linux-gnu)
X-Obscure-Spam: http://music-jk.net/
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135753>

In the manpage for git commit, the option --signoff is mentioned but
there is no explanation of what it actually means. Add a brief hint tha=
t
S-o-b doesn't have a pre-defined meaning.

Signed-off-by: Jan Kr=C3=BCger <jk@jk.gs>
---
Semi-resend. Nobody commented on this when I first sent it in early
December, so here it is again, with a slightly more verbose
explanation. The repetition is intentional.

 Documentation/git-commit.txt |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.tx=
t
index d227cec..cae510b 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -114,7 +114,10 @@ OPTIONS
 -s::
 --signoff::
 	Add Signed-off-by line by the committer at the end of the commit
-	log message.
+	log message. This line has no inherent meaning; it is up to the
+	potential recipient of the commit to decide what it stands for.
+	It is typically understood as an assurance by the committer that
+	the commit conforms to the receiving project's commit guidelines.
=20
 -n::
 --no-verify::
--=20
1.6.5.3.171.ge36e
