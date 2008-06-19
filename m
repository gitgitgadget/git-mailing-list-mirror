From: "Jan =?UTF-8?B?S3LDvGdlcg==?=" <jk@jk.gs>
Subject: [PATCH] Documentation: fix formatting in git-svn
Date: Fri, 20 Jun 2008 00:41:42 +0200
Message-ID: <20080620004142.6a4311a4@neuron>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git mailing list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 20 00:42:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K9Spy-00051m-Cn
	for gcvg-git-2@gmane.org; Fri, 20 Jun 2008 00:42:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752550AbYFSWln convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 19 Jun 2008 18:41:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753312AbYFSWln
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jun 2008 18:41:43 -0400
Received: from zoidberg.org ([213.133.99.5]:42517 "EHLO cthulhu.zoidberg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752249AbYFSWln convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 Jun 2008 18:41:43 -0400
Received: from neuron (xdsl-87-78-141-113.netcologne.de [::ffff:87.78.141.113])
  (IDENT: unknown, AUTH: LOGIN jast, SSL: TLSv1/SSLv3,256bits,AES256-SHA)
  by cthulhu.zoidberg.org with esmtp; Fri, 20 Jun 2008 00:41:42 +0200
  id 0016F154.485AE0A6.00002114
X-Mailer: Claws Mail 3.3.1 (GTK+ 2.12.9; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85554>

Due to a misplaced list block separator, general hints about the config
file options got indented at the same level as the description of the l=
ast
option, making it easy to miss them.

Signed-off-by: Jan Kr=C3=BCger <jk@jk.gs>
---
 Documentation/git-svn.txt |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
index f4cbd2f..97bed54 100644
--- a/Documentation/git-svn.txt
+++ b/Documentation/git-svn.txt
@@ -448,6 +448,8 @@ svn-remote.<name>.rewriteRoot::
 	the repository with a public http:// or svn:// URL in the
 	metadata so users of it will see the public URL.
=20
+--
+
 Since the noMetadata, rewriteRoot, useSvnsyncProps and useSvmProps
 options all affect the metadata generated and used by git-svn; they
 *must* be set in the configuration file before any history is imported
@@ -456,7 +458,6 @@ and these settings should never be changed once the=
y are set.
 Additionally, only one of these four options can be used per-svn-remot=
e
 section because they affect the 'git-svn-id:' metadata line.
=20
---
=20
 BASIC EXAMPLES
 --------------
--=20
1.5.5.1
