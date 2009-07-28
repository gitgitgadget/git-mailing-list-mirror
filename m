From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH] git-rerere.txt: Clarify ambiguity of the config variable
Date: Tue, 28 Jul 2009 16:42:15 +0200
Message-ID: <1248792135-3361-1-git-send-email-git@drmicha.warpmail.net>
References: <ygetz0x35ja.fsf@phenix.progiciels-bpi.ca>
Cc: pinard@iro.umontreal.ca (=?utf-8?Q?Fran=C3=A7ois?= Pinard),
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 28 16:42:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MVnt4-0003ab-Vv
	for gcvg-git-2@gmane.org; Tue, 28 Jul 2009 16:42:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752141AbZG1Omc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Jul 2009 10:42:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751928AbZG1Omc
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Jul 2009 10:42:32 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:44885 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751209AbZG1Omc (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 28 Jul 2009 10:42:32 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id 7AA923BD59F;
	Tue, 28 Jul 2009 10:42:31 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Tue, 28 Jul 2009 10:42:31 -0400
X-Sasl-enc: 7Akben4Pw5Td0hzl/mUbJtQxBUuKICsoqjuUPCiqoO3D 1248792150
Received: from localhost (p5DCC15F8.dip0.t-ipconnect.de [93.204.21.248])
	by mail.messagingengine.com (Postfix) with ESMTPSA id B850DD2F1;
	Tue, 28 Jul 2009 10:42:30 -0400 (EDT)
X-Mailer: git-send-email 1.6.4.rc3.201.gd9d59
In-Reply-To: <ygetz0x35ja.fsf@phenix.progiciels-bpi.ca>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124254>

Use the less ambiguous
"set variable foo in order to enable bar"
rather than
"set variable foo to enable bar" which may trick users into
assuming that "enable" is a good value for "foo".

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
I know there is no way to misunderstand this if one looks at the whole
sentence, but still I deem it worthwhile to make it easier on the reader.

Patch is against maint (git-rerere.txt does not have any more recent changes).

 Documentation/git-rerere.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-rerere.txt b/Documentation/git-rerere.txt
index a53c3cd..7dd515b 100644
--- a/Documentation/git-rerere.txt
+++ b/Documentation/git-rerere.txt
@@ -23,7 +23,7 @@ on the initial manual merge, and applying previously recorded
 hand resolutions to their corresponding automerge results.
 
 [NOTE]
-You need to set the configuration variable rerere.enabled to
+You need to set the configuration variable rerere.enabled in order to
 enable this command.
 
 
-- 
1.6.4.rc3.201.gd9d59
