From: Henri GEIST <geist.henri@laposte.net>
Subject: [PATCH/RFC] Documentation: Say that submodule clones use a separate
 gitdirs.
Date: Fri, 07 Mar 2014 08:53:54 +0100
Message-ID: <1394178834.7891.38.camel@Naugrim>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 07 08:54:08 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WLpbb-0006lb-Hv
	for gcvg-git-2@plane.gmane.org; Fri, 07 Mar 2014 08:54:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751663AbaCGHyB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Mar 2014 02:54:01 -0500
Received: from smtpout7.laposte.net ([193.253.67.232]:29468 "EHLO
	smtpout.laposte.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751552AbaCGHyB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Mar 2014 02:54:01 -0500
Received: from [192.168.1.104] ([109.164.199.213])
	by mwinf8513-out with ME
	id aXtu1n00A4ckmKR03XtuDz; Fri, 07 Mar 2014 08:53:56 +0100
X-Mailer: Evolution 3.4.4-3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243605>

Adding a note in the submodule documentation signaling that the
automatically cloned missing submodules are cloned with a separate
gitdir. And where it is put.

Signed-off-by: Henri GEIST <geist.henri@laposte.net>
---
 Documentation/git-submodule.txt |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index 21cb59a..ea837fd 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -64,6 +64,11 @@ using the 'status' subcommand and get a detailed overview of the
 difference between the index and checkouts using the 'summary'
 subcommand.
 
+*NOTE*: when submodule add or submodule update commands clone a missing
+submodule, the option --separate-git-dir is passed to the clone command
+and the gitdir of the submodule is placed outside of its working
+directory in the .git/module of the current repository.
+
 
 COMMANDS
 --------
-- 
1.7.9.3.369.gd715.dirty
