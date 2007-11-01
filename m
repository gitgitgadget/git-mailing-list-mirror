From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 0/3] gitweb: Simplify some gitweb URLs generation
Date: Thu,  1 Nov 2007 13:06:25 +0100
Message-ID: <1193918789-16421-1-git-send-email-jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 01 13:04:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1InYml-0008UE-9A
	for gcvg-git-2@gmane.org; Thu, 01 Nov 2007 13:04:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754988AbXKAMEH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Nov 2007 08:04:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755126AbXKAMEH
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Nov 2007 08:04:07 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:33802 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754413AbXKAMEB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Nov 2007 08:04:01 -0400
Received: by ug-out-1314.google.com with SMTP id z38so453890ugc
        for <git@vger.kernel.org>; Thu, 01 Nov 2007 05:03:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:received:received:from:to:subject:date:message-id:x-mailer;
        bh=xRppMSJBle6DLm//+a/Jm416pc7PCW/fp3zSaTQOXMM=;
        b=fwWWk7prta8PF4Az9ANTiIH2Nwd0l1+3QzBf19dMwaw6+zL3zh9qfGVc0B9hpPtb7L/kjk+eE7kgkk2FlU9bqOwkGhpYBj6eu/tuwlsxXXiDa2H1PWm8AO3z2kz3KqgaT10+Gnk2F1ewhzkUAOJJhFKIumqsfuJE0s84sIk8O7o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:message-id:x-mailer;
        b=Gfg3aS0fXcdjF848sTf0eJqnNvDHnczuXRunr/6M3goAxwOycl0nsLrM2bQG2uK3d0GpuDNQCsXqbyE3qMYRC3oUVc39vBPmIuyNypxkkHthrwZQ5F7azAIk7+yleS4cdEhBRTom6qS7SsRsGrNjn7Zg/2JeeZt5PlFwstjT+XI=
Received: by 10.67.19.17 with SMTP id w17mr3184123ugi.1193918639716;
        Thu, 01 Nov 2007 05:03:59 -0700 (PDT)
Received: from roke.D-201 ( [83.8.199.125])
        by mx.google.com with ESMTPS id j34sm2193061ugc.2007.11.01.05.03.57
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 01 Nov 2007 05:03:58 -0700 (PDT)
Received: from roke.D-201 (localhost.localdomain [127.0.0.1])
	by roke.D-201 (8.13.4/8.13.4) with ESMTP id lA1C6UuP016526
	for <git@vger.kernel.org>; Thu, 1 Nov 2007 13:06:31 +0100
Received: (from jnareb@localhost)
	by roke.D-201 (8.13.4/8.13.4/Submit) id lA1C6USG016525
	for git@vger.kernel.org; Thu, 1 Nov 2007 13:06:30 +0100
X-Mailer: git-send-email 1.5.3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62940>

This series of patches simplifies some gitweb URLs generation by
providing -replay option to href() subroutine, and then using this
feature in gitweb code.

Shortlog:
 gitweb: Easier adding/changing parameters to current URL
 gitweb: Use href(-replay=>1, page=>...) to generate pagination links
 gitweb: Use href(-replay=>1, action=>...) to generate alternate views

Diffstat:
 gitweb/gitweb.perl |   82 ++++++++++++++++++++++-----------------------------
 1 files changed, 35 insertions(+), 47 deletions(-)

-- 
Jakub Narebski
Poland
