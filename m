From: Johannes Sixt <j.sixt@viscovery.net>
Subject: [PATCH jh/notes] t3301-notes: insert a shbang line in ./fake_editor.sh
Date: Thu, 25 Feb 2010 11:39:50 +0100
Message-ID: <4B865376.9030209@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Johan Herland <johan@herland.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 25 11:40:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nkb8T-0006SM-O1
	for gcvg-git-2@lo.gmane.org; Thu, 25 Feb 2010 11:40:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759167Ab0BYKj4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Feb 2010 05:39:56 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:40422 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759138Ab0BYKjz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Feb 2010 05:39:55 -0500
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1Nkb8I-0007aw-L9; Thu, 25 Feb 2010 11:39:51 +0100
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 612C21660F;
	Thu, 25 Feb 2010 11:39:50 +0100 (CET)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
X-Enigmail-Version: 0.95.5
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141043>

From: Johannes Sixt <j6t@kdbg.org>

This is required on Windows because git-notes is now a built-in
rather than a shell script.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 t/t3301-notes.sh |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/t/t3301-notes.sh b/t/t3301-notes.sh
index 90178f9..37b9687 100755
--- a/t/t3301-notes.sh
+++ b/t/t3301-notes.sh
@@ -8,6 +8,7 @@ test_description='Test commit notes'
 . ./test-lib.sh

 cat > fake_editor.sh << \EOF
+#!/bin/sh
 echo "$MSG" > "$1"
 echo "$MSG" >& 2
 EOF
-- 
1.7.0.1285.g1a907.dirty
