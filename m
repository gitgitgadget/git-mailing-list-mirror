From: Lars Hjemli <hjemli@gmail.com>
Subject: [PATCH] gitmodules(5): remove leading period from synopsis
Date: Thu, 14 Jun 2007 00:01:10 +0200
Message-ID: <11817720703159-git-send-email-hjemli@gmail.com>
References: <7vd4zzg72i.fsf@assigned-by-dhcp.pobox.com>
Cc: Matthias Lederhofer <matled@gmx.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 13 23:58:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HyarT-0007mi-BD
	for gcvg-git@gmane.org; Wed, 13 Jun 2007 23:58:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753390AbXFMV6l (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 13 Jun 2007 17:58:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752911AbXFMV6l
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jun 2007 17:58:41 -0400
Received: from mail46.e.nsc.no ([193.213.115.46]:54510 "EHLO mail46.e.nsc.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751541AbXFMV6k (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jun 2007 17:58:40 -0400
Received: from localhost.localdomain (ti231210a341-1436.bb.online.no [85.166.49.158])
	by mail46.nsc.no (8.13.8/8.13.5) with ESMTP id l5DLwYfK026677;
	Wed, 13 Jun 2007 23:58:34 +0200 (MEST)
X-Mailer: git-send-email 1.5.2.1.914.gbd3a7
In-Reply-To: <7vd4zzg72i.fsf@assigned-by-dhcp.pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50135>

Asciidoc treats a line starting with a period followed by a title as a
blocktitle element. My introduction of gitmodules(5) unfortunatly broke
the documentation build process due to this processing, since it made
asciidoc generate an illegal (empty) synopsis element. Removing the leading
period fixes the problem and also makes gitmodules(5) use the same synopsis
notation as gitattributes(5).

Noticed-by: Matthias Lederhofer <matled@gmx.net>
Signed-off-by: Lars Hjemli <hjemli@gmail.com>
---

Sorry for the breakage, I'll try to get asciidoc working before submitting
any more patches to Documentation/.

 Documentation/gitmodules.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/gitmodules.txt b/Documentation/gitmodules.txt
index 7814b6a..035294e 100644
--- a/Documentation/gitmodules.txt
+++ b/Documentation/gitmodules.txt
@@ -7,7 +7,7 @@ gitmodules - defining submodule properties
 
 SYNOPSIS
 --------
-.gitmodules
+gitmodules
 
 
 DESCRIPTION
-- 
1.5.2.1.914.gbd3a7
