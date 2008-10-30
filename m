From: "Jan =?UTF-8?B?S3LDvGdlcg==?=" <jk@jk.gs>
Subject: [PATCH] Documentation: clarify information about 'ident' attribute
Date: Thu, 30 Oct 2008 19:14:33 +0100
Message-ID: <20081030191433.710aff11@perceptron>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 30 19:21:40 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kvc9L-00009w-8x
	for gcvg-git-2@gmane.org; Thu, 30 Oct 2008 19:21:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755239AbYJ3SUU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 30 Oct 2008 14:20:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753764AbYJ3SUT
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Oct 2008 14:20:19 -0400
Received: from zoidberg.org ([213.133.99.5]:55578 "EHLO cthulhu.zoidberg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753299AbYJ3SUS convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 30 Oct 2008 14:20:18 -0400
Received: from perceptron (xdsl-87-78-167-87.netcologne.de [::ffff:87.78.167.87])
  (IDENT: unknown, AUTH: LOGIN jast, TLS: TLSv1/SSLv3,256bits,AES256-SHA)
  by cthulhu.zoidberg.org with esmtp; Thu, 30 Oct 2008 19:14:35 +0100
  id 001627C8.4909F98B.000007B4
X-Mailer: Claws Mail 3.3.1 (GTK+ 2.12.9; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99517>

The documentation spoke of the attribute being set "to" a path; this ca=
n
mistakenly be interpreted as "the attribute needs to have its value set=
 to
some kind of path". This clarifies things (and also calls the object ID=
 a
hash rather than a name because that might be confusing too).

Signed-off-by: Jan Kr=C3=BCger <jk@jk.gs>
---
Confused me and a few other people on IRC the other day.

 Documentation/gitattributes.txt |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/gitattributes.txt b/Documentation/gitattribu=
tes.txt
index 2694559..b39db6b 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -163,9 +163,9 @@ few exceptions.  Even though...
 `ident`
 ^^^^^^^
=20
-When the attribute `ident` is set to a path, git replaces
-`$Id$` in the blob object with `$Id:`, followed by
-40-character hexadecimal blob object name, followed by a dollar
+When the attribute `ident` is set for a path, git replaces
+`$Id$` in the blob object with `$Id:`, followed by the
+40-character hexadecimal blob object hash, followed by a dollar
 sign `$` upon checkout.  Any byte sequence that begins with
 `$Id:` and ends with `$` in the worktree file is replaced
 with `$Id$` upon check-in.
--=20
1.6.0.3.523.g304d0.dirty
