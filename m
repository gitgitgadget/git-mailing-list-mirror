From: jidanni@jidanni.org
Subject: [PATCH,v4] git-checkout(1): mention fate of extraneous files
Date: Tue, 20 Jan 2009 08:01:00 +0800
Message-ID: <878wp6voar.fsf_-_@jidanni.org>
References: <alpine.DEB.1.00.0901200040550.3586@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: bss@iguanasuicide.net, gitster@pobox.com, git@vger.kernel.org,
	markus.heidelberg@web.de
To: johannes.schindelin@gmx.de
X-From: git-owner@vger.kernel.org Tue Jan 20 01:03:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LP45P-0001Yc-ML
	for gcvg-git-2@gmane.org; Tue, 20 Jan 2009 01:03:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762664AbZATABI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Jan 2009 19:01:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762071AbZATABF
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Jan 2009 19:01:05 -0500
Received: from sd-green-bigip-66.dreamhost.com ([208.97.132.66]:56701 "EHLO
	homiemail-a4.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1761629AbZATABE (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 19 Jan 2009 19:01:04 -0500
Received: from jidanni.org (122-127-34-185.dynamic.hinet.net [122.127.34.185])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by homiemail-a4.dreamhost.com (Postfix) with ESMTP id A7BBD41535;
	Mon, 19 Jan 2009 16:01:02 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106414>

Signed-off-by: jidanni <jidanni@jidanni.org>
---
OK thanks Johannes.
I'm still worried that there is no exact statement on the fate of the
various different classes of files, but OK, moving this to only a SEE ALSO.

 Documentation/git-checkout.txt |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
index 9cd5151..6ffb783 100644
--- a/Documentation/git-checkout.txt
+++ b/Documentation/git-checkout.txt
@@ -246,6 +246,9 @@ $ edit frotz
 $ git add frotz
 ------------
 
+SEE ALSO
+--------
+linkgit:git-clean[1]
 
 Author
 ------
-- 
1.6.0.6
