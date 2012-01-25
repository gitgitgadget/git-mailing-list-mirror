From: Jeff King <peff@peff.net>
Subject: [PATCH] docs: minor grammar fixes for v1.7.9 release notes
Date: Wed, 25 Jan 2012 17:20:03 -0500
Message-ID: <20120125222002.GA6309@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 25 23:20:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RqBCR-0007LR-3d
	for gcvg-git-2@lo.gmane.org; Wed, 25 Jan 2012 23:20:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750919Ab2AYWUI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jan 2012 17:20:08 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:44698
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750757Ab2AYWUH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jan 2012 17:20:07 -0500
Received: (qmail 20608 invoked by uid 107); 25 Jan 2012 22:27:07 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 25 Jan 2012 17:27:07 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 25 Jan 2012 17:20:03 -0500
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189129>


Signed-off-by: Jeff King <peff@peff.net>
---
Easier to view with --color-words, of course.

I also looked through "git log --first-parent v1.7.8..master" to see if
anything had been missed. I think you hit the feature highlights pretty
well (I notice you mostly include features and not bug-fixes, which I
assume is to keep the list to a readable length).

 Documentation/RelNotes/1.7.9.txt |   13 +++++++------
 1 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/Documentation/RelNotes/1.7.9.txt b/Documentation/RelNotes/1.7.9.txt
index f1294b4..95320aa 100644
--- a/Documentation/RelNotes/1.7.9.txt
+++ b/Documentation/RelNotes/1.7.9.txt
@@ -12,19 +12,20 @@ Updates since v1.7.8
 
  * Git uses gettext to translate its most common interface messages
    into the user's language if translations are available and the
-   locale is appropriately set. Distributors can drop in new PO files
+   locale is appropriately set. Distributors can drop new PO files
    in po/ to add new translations.
 
- * The code to handle username/password for HTTP transaction used in
+ * The code to handle username/password for HTTP transactions used in
    "git push" & "git fetch" learned to talk "credential API" to
    external programs to cache or store them, to allow integration with
    platform native keychain mechanisms.
 
- * The prompted input in the terminal use our own getpass() replacement
-   when possible. HTTP transactions used to ask username without echoing
-   back what was typed, but with this change you will see it as you type.
+ * The input prompts in the terminal use our own getpass() replacement
+   when possible. HTTP transactions used to ask for the username without
+   echoing back what was typed, but with this change you will see it as
+   you type.
 
- * The internal of "revert/cherry-pick" has been tweaked to prepare
+ * The internals of "revert/cherry-pick" have been tweaked to prepare
    building more generic "sequencer" on top of the implementation that
    drives them.
 
-- 
1.7.9.rc2.293.gaae2
