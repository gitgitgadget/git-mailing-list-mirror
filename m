From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH] stash: mention --patch in usage string.
Date: Sat,  2 Jan 2010 17:35:32 +0100
Message-ID: <1262450132-22048-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Jan 02 17:35:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NR6xB-0004qq-FA
	for gcvg-git-2@lo.gmane.org; Sat, 02 Jan 2010 17:35:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752796Ab0ABQfo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Jan 2010 11:35:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752764Ab0ABQfo
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Jan 2010 11:35:44 -0500
Received: from mx2.imag.fr ([129.88.30.17]:59978 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752757Ab0ABQfo (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Jan 2010 11:35:44 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id o02GYPPZ013745
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Sat, 2 Jan 2010 17:34:25 +0100
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1NR6ww-000812-GQ; Sat, 02 Jan 2010 17:35:34 +0100
Received: from moy by bauges.imag.fr with local (Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1NR6ww-0005kB-E5; Sat, 02 Jan 2010 17:35:34 +0100
X-Mailer: git-send-email 1.6.6.76.gd6b23.dirty
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Sat, 02 Jan 2010 17:34:28 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o02GYPPZ013745
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1263054868.28229@NRWIwWMwAwjKdvNveeqZVg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136030>


Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 git-stash.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-stash.sh b/git-stash.sh
index f796c2f..3a0685f 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -7,7 +7,7 @@ USAGE="list [<options>]
    or: $dashless drop [-q|--quiet] [<stash>]
    or: $dashless ( pop | apply ) [--index] [-q|--quiet] [<stash>]
    or: $dashless branch <branchname> [<stash>]
-   or: $dashless [save [-k|--keep-index] [-q|--quiet] [<message>]]
+   or: $dashless [save [--patch] [-k|--[no-]keep-index] [-q|--quiet] [<message>]]
    or: $dashless clear"
 
 SUBDIRECTORY_OK=Yes
-- 
1.6.6.76.gd6b23.dirty
