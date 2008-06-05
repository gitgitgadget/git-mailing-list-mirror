From: Kevin Ballard <kevin@rapleaf.com>
Subject: git-clone still broken wrt. unpacking working tree with http transport
Date: Thu, 5 Jun 2008 16:48:56 -0700
Message-ID: <0F5C1FC7-258E-44A4-9FE6-AB6696D0B5BE@rapleaf.com>
Mime-Version: 1.0 (Apple Message framework v924)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jun 06 02:12:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4PZ7-0006rF-8c
	for gcvg-git-2@gmane.org; Fri, 06 Jun 2008 02:12:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752214AbYFFAL1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Jun 2008 20:11:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753327AbYFFAL1
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Jun 2008 20:11:27 -0400
Received: from mail.rapleaf.com ([208.96.16.213]:41697 "EHLO mail.rapleaf.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752200AbYFFAL0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jun 2008 20:11:26 -0400
X-Greylist: delayed 1349 seconds by postgrey-1.27 at vger.kernel.org; Thu, 05 Jun 2008 20:11:26 EDT
Received: from mail.rapleaf.com (localhost.localdomain [127.0.0.1])
	by mail.rapleaf.com (Postfix) with ESMTP id 87EBE12502F3
	for <git@vger.kernel.org>; Thu,  5 Jun 2008 16:48:56 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; c=nofws; d=rapleaf.com; q=dns; s=m1; b=Mg38G
	016CL3Ecjur6WjaHofbv89G4232SZ0/bKDQM02XFYc1rGqgioBQvVh2jrwInDLEM
	z1Zx+vgboX+Cj21zpGRZcL5JojHy1GKDLceIUB+zjKUuxiV2mhVO66RZbimVQ6kM
	C6UAx2bTuYnVL/fg2AOAed6HQRQnHkwYgGfIF8=
Received: from [10.100.18.156] (unknown [10.100.18.156])
	by mail.rapleaf.com (Postfix) with ESMTP id 754471250050
	for <git@vger.kernel.org>; Thu,  5 Jun 2008 16:48:56 -0700 (PDT)
X-Mailer: Apple Mail (2.924)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84004>

The new builtin git-clone is still broken in that it doesn't unpack  
the working tree if the clone happened over http.

To test, just go ahead and clone <http://moonbase.rydia.net/software/optimized-locking/optimized-locking.git/ 
 >.

-Kevin Ballard

-- 
Kevin Ballard
kevin@rapleaf.com
