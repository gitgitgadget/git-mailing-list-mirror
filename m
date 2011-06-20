From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH] gitweb: 'pickaxe' feature requires 'search' enabled
Date: Mon, 20 Jun 2011 23:40:07 +0200
Message-ID: <20110620213904.11650.60345.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 20 23:41:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QYmDa-0002i8-89
	for gcvg-git-2@lo.gmane.org; Mon, 20 Jun 2011 23:41:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754482Ab1FTVlJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Jun 2011 17:41:09 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:38935 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751919Ab1FTVlH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Jun 2011 17:41:07 -0400
Received: by wwe5 with SMTP id 5so2984458wwe.1
        for <git@vger.kernel.org>; Mon, 20 Jun 2011 14:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:subject:to:date:message-id:user-agent
         :mime-version:content-type:content-transfer-encoding;
        bh=w5vNJgipbcTFoxms+/e51W1tj4RHg1BWSZavcIFU6nY=;
        b=OX4q+sZODurHcy8QL5LxUZ1Ru0/uHwH6JRLLqituyL7Ofn+S1UbJ9BDuXZncMsI+Tr
         6pztTFOmR7zFw5xTq7iapuwTUV4xwbSRVlw+hhhzg6aeV2b5XfJHEgsHkkom/drCGr1R
         a4g89MxGhDF4A7h25k1pxKcz2f6xPUV6GE08E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:subject:to:date:message-id:user-agent:mime-version
         :content-type:content-transfer-encoding;
        b=Zkw8/jtKc9L4OpuAVy7Pes8kHUI4WV6gJh8zIvkdwrTgt/BeDpQRqWSRsn7eTeNhAi
         dgsB6pqQHCjOLs3OEPIf6uZ9sT8oh44Qbg1yBCMYVtTxlbGAOsBRhb3LdQ6boIahSDOC
         sx8nLZWxP43JhiBC0gj/lRy/aK3v08VOw3cFw=
Received: by 10.216.237.65 with SMTP id x43mr5352312weq.70.1308606066582;
        Mon, 20 Jun 2011 14:41:06 -0700 (PDT)
Received: from localhost.localdomain (abwl227.neoplus.adsl.tpnet.pl [83.8.235.227])
        by mx.google.com with ESMTPS id 74sm3140029wem.17.2011.06.20.14.41.04
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 20 Jun 2011 14:41:05 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id p5KLe7tv011700;
	Mon, 20 Jun 2011 23:40:18 +0200
User-Agent: StGIT/0.14.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176095>

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
This is something I noticed when working on improving gitweb search.

 gitweb/gitweb.perl |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index c9e6426..1a59781 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -342,6 +342,7 @@ our %feature = (
 	# Enable the pickaxe search, which will list the commits that modified
 	# a given string in a file. This can be practical and quite faster
 	# alternative to 'blame', but still potentially CPU-intensive.
+	# Note that you need to have 'search' feature enabled too.
 
 	# To enable system wide have in $GITWEB_CONFIG
 	# $feature{'pickaxe'}{'default'} = [1];
