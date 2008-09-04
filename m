From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH] Mention the fact that 'git annotate' is only for backward compatibility.
Date: Thu,  4 Sep 2008 14:00:52 +0200
Message-ID: <1220529652-24050-1-git-send-email-Matthieu.Moy@imag.fr>
References: <bd6139dc0809040216v40914e82h6a4032941cf65996@mail.gmail.com>
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: gitster@pobox.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 04 14:20:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KbDpI-0008A9-Cu
	for gcvg-git-2@gmane.org; Thu, 04 Sep 2008 14:20:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752449AbYIDMTd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Sep 2008 08:19:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752458AbYIDMTd
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Sep 2008 08:19:33 -0400
Received: from harmonie.imag.fr ([147.171.130.40]:53445 "EHLO harmonie.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752276AbYIDMTc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Sep 2008 08:19:32 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by harmonie.imag.fr (8.13.8/8.13.8) with ESMTP id m84CFoPH000501;
	Thu, 4 Sep 2008 14:16:03 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1KbDW9-0007zn-29; Thu, 04 Sep 2008 14:00:53 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1KbDW8-0006GI-VW; Thu, 04 Sep 2008 14:00:52 +0200
X-Mailer: git-send-email 1.6.0.7.g161c
In-Reply-To: <bd6139dc0809040216v40914e82h6a4032941cf65996@mail.gmail.com>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (harmonie.imag.fr [147.171.130.40]); Thu, 04 Sep 2008 14:16:03 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94927>


Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 Documentation/git-annotate.txt |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-annotate.txt b/Documentation/git-annotate.txt
index 8b6b56a..6e05825 100644
--- a/Documentation/git-annotate.txt
+++ b/Documentation/git-annotate.txt
@@ -14,6 +14,9 @@ DESCRIPTION
 Annotates each line in the given file with information from the commit
 which introduced the line. Optionally annotate from a given revision.
 
+This command exists for backward compatibility. For regular use, you
+should use linkgit:git-blame[1] instead.
+
 OPTIONS
 -------
 include::blame-options.txt[]
-- 
1.6.0.7.g161c
