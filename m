From: "Emilio G. Cota" <cota@braap.org>
Subject: [PATCH 2/2] Documentation/Makefile: add *.pdf to `clean' target
Date: Mon,  8 Aug 2011 04:33:05 -0400
Message-ID: <1312792385-19149-2-git-send-email-cota@braap.org>
References: <1312792385-19149-1-git-send-email-cota@braap.org>
Cc: git@vger.kernel.org, "Emilio G. Cota" <cota@braap.org>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Aug 08 11:04:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QqLkq-0001z1-HV
	for gcvg-git-2@lo.gmane.org; Mon, 08 Aug 2011 11:04:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751692Ab1HHJEH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Aug 2011 05:04:07 -0400
Received: from waldorf.bytemark.co.uk ([212.110.162.22]:47440 "EHLO
	waldorf.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750821Ab1HHJEF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Aug 2011 05:04:05 -0400
X-Greylist: delayed 1834 seconds by postgrey-1.27 at vger.kernel.org; Mon, 08 Aug 2011 05:04:05 EDT
Received: from gec.vm.bytemark.co.uk ([80.68.89.121])
	by waldorf.bytemark.co.uk with esmtp (Exim 4.69)
	(envelope-from <cota@braap.org>)
	id 1QqLKE-0000ZK-JS; Mon, 08 Aug 2011 09:36:42 +0100
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gec.vm.bytemark.co.uk (Postfix) with ESMTP id DD03C4C2F4;
	Mon,  8 Aug 2011 09:33:20 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at gec.vm.bytemark.co.uk
Received: from gec.vm.bytemark.co.uk ([127.0.0.1])
	by localhost (gec.vm.bytemark.co.uk [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XV5z5zQhhoeg; Mon,  8 Aug 2011 09:33:08 +0100 (BST)
Received: from localhost (dhcptemp44.cs.columbia.edu [128.59.17.244])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by gec.vm.bytemark.co.uk (Postfix) with ESMTPSA id 39B284C62A;
	Mon,  8 Aug 2011 09:33:08 +0100 (BST)
X-Mailer: git-send-email 1.7.6
In-Reply-To: <1312792385-19149-1-git-send-email-cota@braap.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178948>

From: "Emilio G. Cota" <cota@braap.org>

user-manual.pdf is not removed by `make clean'; fix it.

Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 Documentation/Makefile |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 36989b7..18c71d7 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -232,6 +232,7 @@ cmd-list.made: cmd-list.perl ../command-list.txt $(MAN1_TXT)
 clean:
 	$(RM) *.xml *.xml+ *.html *.html+ *.1 *.5 *.7
 	$(RM) *.texi *.texi+ *.texi++ git.info gitman.info
+	$(RM) *.pdf
 	$(RM) howto-index.txt howto/*.html doc.dep
 	$(RM) technical/api-*.html technical/api-index.txt
 	$(RM) $(cmds_txt) *.made
-- 
1.7.6
