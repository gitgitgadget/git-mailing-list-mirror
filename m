From: Jeff King <peff@peff.net>
Subject: [PATCH] fix typos and grammar in 1.7.1 draft release notes
Date: Wed, 7 Apr 2010 16:57:11 -0400
Message-ID: <20100407205711.GA27012@coredump.intra.peff.net>
References: <7vmxxfe20g.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 07 22:57:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NzcJd-0004LN-Kd
	for gcvg-git-2@lo.gmane.org; Wed, 07 Apr 2010 22:57:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752240Ab0DGU5b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Apr 2010 16:57:31 -0400
Received: from peff.net ([208.65.91.99]:60245 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751451Ab0DGU5b (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Apr 2010 16:57:31 -0400
Received: (qmail 10719 invoked by uid 107); 7 Apr 2010 20:57:30 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 07 Apr 2010 16:57:30 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 07 Apr 2010 16:57:11 -0400
Content-Disposition: inline
In-Reply-To: <7vmxxfe20g.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144284>


Signed-off-by: Jeff King <peff@peff.net>
---
I noticed a few typos, so I went through and proofread the whole thing.
I also caught all of the things Sverre noted, so you can disregard his
message.

I would also say 'the "--keep-cr" option' and "the -R option" instead of
omitting the "the", but that is perhaps a matter of preference and not
grammar. I didn't fix that in this patch.

 Documentation/RelNotes-1.7.1.txt |   20 ++++++++++----------
 1 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/Documentation/RelNotes-1.7.1.txt b/Documentation/RelNotes-1.7.1.txt
index 02f9257..58cf113 100644
--- a/Documentation/RelNotes-1.7.1.txt
+++ b/Documentation/RelNotes-1.7.1.txt
@@ -7,21 +7,22 @@ Updates since v1.7.0
  * Eric Raymond is the maintainer of updated CIAbot scripts, in contrib/.
 
  * Some commands (e.g. svn and http interfaces) that interactively ask
-   password can be told to use an external program given via GIT_ASKPASS.
+   for a password can be told to use an external program given via
+   GIT_ASKPASS.
 
  * Conflict markers that lead the common ancestor in diff3-style output
-   now has a label, which hopefully would help third-party tools that
+   now have a label, which hopefully would help third-party tools that
    expect one.
 
  * Comes with an updated bash-completion script.
 
  * "git am" learned "--keep-cr" option to handle inputs that are
-   mixture of changes to files with and without CRLF line endings.
+   a mixture of changes to files with and without CRLF line endings.
 
  * "git cvsimport" learned -R option to leave revision mapping between
    CVS revisions and resulting git commits.
 
- * "git diff --submodule" notices and descries dirty submodules.
+ * "git diff --submodule" notices and describes dirty submodules.
 
  * "git for-each-ref" learned %(symref), %(symref:short) and %(flag)
    tokens.
@@ -42,12 +43,11 @@ Updates since v1.7.0
  * "git log -p --first-parent -m" shows one-parent diff for merge
    commits, instead of showing combined diff.
 
- * "git merge-file" learned to use custom conflict marker size and also use
-   the "union merge" behaviour.
+ * "git merge-file" learned to use custom conflict marker size and also
+   to use the "union merge" behaviour.
 
- * "git notes" command has been rewritten in C and learned quite a
-   many commands and features to help you carry notes forward across
-   rebases and amends.
+ * "git notes" command has been rewritten in C and learned many commands
+   and features to help you carry notes forward across rebases and amends.
 
  * "git request-pull" identifies the commit the request is relative to in
    a more readable way.
@@ -56,7 +56,7 @@ Updates since v1.7.0
    near the tip while preserving your local changes in a way similar
    to how "git checkout branch" does.
 
- * "git status" notices and descries dirty submodules.
+ * "git status" notices and describes dirty submodules.
 
  * "git svn" should work better when interacting with repositories
    with CRLF line endings.
-- 
1.7.1.rc0.220.g92be4.dirty
