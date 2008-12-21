From: "Boyd Stephen Smith Jr." <bss@iguanasuicide.net>
Subject: [PATCH] Have manpage reference new documentation on reverting merges.
Date: Sat, 20 Dec 2008 18:32:48 -0600
Message-ID: <200812201832.48992.bss@iguanasuicide.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org, Nanako Shiraishi <nanako3@lavabit.com>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Dec 21 01:34:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LECGZ-0002pF-Vk
	for gcvg-git-2@gmane.org; Sun, 21 Dec 2008 01:33:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751216AbYLUAch (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Dec 2008 19:32:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751260AbYLUAch
	(ORCPT <rfc822;git-outgoing>); Sat, 20 Dec 2008 19:32:37 -0500
Received: from rei.iguanasuicide.net ([209.20.91.252]:37689 "EHLO
	rei.iguanasuicide.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751056AbYLUAch (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Dec 2008 19:32:37 -0500
Received: from ip72-204-50-125.fv.ks.cox.net ([72.204.50.125] helo=[10.0.0.123])
	by rei.iguanasuicide.net with esmtpsa (TLS-1.0:DHE_DSS_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <bss@iguanasuicide.net>)
	id 1LECFH-0000RL-9L; Sun, 21 Dec 2008 00:32:35 +0000
X-Eric-Conspiracy: There is no conspiracy.
Content-Disposition: inline
X-Virus-Scanned: clamav@iguanasuicide.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103676>

Signed-off-by: Boyd Stephen Smith Jr <bss@iguanasuicide.net>
---
An example addition to the manpage for revert that references Nanako
Shiraishi's new documentation.

 Documentation/git-revert.txt |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-revert.txt b/Documentation/git-revert.txt
index caa0729..ea36bdf 100644
--- a/Documentation/git-revert.txt
+++ b/Documentation/git-revert.txt
@@ -45,6 +45,10 @@ OPTIONS
 	the mainline and allows revert to reverse the change
 	relative to the specified parent.
 
+	Reverting a merge commit does not completely "undo" the effect of the
+	merge and it may make future merges more difficult.  For more details,
+	please read Documentation/howto/revert-a-faulty-merge.txt.
+
 --no-edit::
 	With this option, 'git-revert' will not start the commit
 	message editor.
-- 
1.5.6
-- 
Boyd Stephen Smith Jr.                     ,= ,-_-. =. 
bss@iguanasuicide.net                     ((_/)o o(\_))
ICQ: 514984 YM/AIM: DaTwinkDaddy           `-'(. .)`-' 
http://iguanasuicide.net/                      \_/     
