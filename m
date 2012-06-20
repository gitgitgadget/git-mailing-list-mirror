From: Andreas Schwab <schwab@linux-m68k.org>
Subject: [PATCH] Fix formatting in git-config(1)
Date: Thu, 21 Jun 2012 00:49:19 +0200
Message-ID: <m2vcil4n0w.fsf@igel.home>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 21 00:50:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ShTje-0008LD-Li
	for gcvg-git-2@plane.gmane.org; Thu, 21 Jun 2012 00:50:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758373Ab2FTWtZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Jun 2012 18:49:25 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:42387 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758386Ab2FTWtW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jun 2012 18:49:22 -0400
Received: from frontend1.mail.m-online.net (unknown [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 3WHh745QVmz4LDfW
	for <git@vger.kernel.org>; Thu, 21 Jun 2012 00:49:20 +0200 (CEST)
Received: from igel.home (ppp-93-104-134-134.dynamic.mnet-online.de [93.104.134.134])
	by mail.mnet-online.de (Postfix) with ESMTPA id 3WHh741QPbz4KK5L
	for <git@vger.kernel.org>; Thu, 21 Jun 2012 00:49:20 +0200 (CEST)
Received: by igel.home (Postfix, from userid 501)
	id 93653CA2A3; Thu, 21 Jun 2012 00:49:19 +0200 (CEST)
X-Yow: Now KEN is having a MENTAL CRISIS because his "R.V." PAYMENTS are
 OVER-DUE!!
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.1 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200373>

Remove the open block markers from the status.showUntrackedFiles entry
as they cause all remaining entries to be indented one level too much.

Signed-off-by: Andreas Schwab <schwab@linux-m68k.org>
---
I haven't been able to make the paragraph after the nested list of the
entry indented the same as the first one.  That appears to be a bug in
asciidoc, unless I'm misunderstanding something.  What should have
worked, AFAICS, would be placing the last paragraph inside the open
block and remove the preceding continuation marker, but doesn't change
anything from the status quo.

Andreas.

 Documentation/config.txt | 2 --
 1 file changed, 2 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 915cb5a..182ca3d 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1946,11 +1946,9 @@ status.showUntrackedFiles::
 	systems. So, this variable controls how the commands displays
 	the untracked files. Possible values are:
 +
---
 * `no` - Show no untracked files.
 * `normal` - Show untracked files and directories.
 * `all` - Show also individual files in untracked directories.
---
 +
 If this variable is not specified, it defaults to 'normal'.
 This variable can be overridden with the -u|--untracked-files option
-- 
1.7.11


-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
