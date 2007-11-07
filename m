From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Inconsistencies with git log
Date: Wed, 7 Nov 2007 17:15:14 -0500
Message-ID: <9e4733910711071415i1729e277u6be19b72cd682a85@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Nov 07 23:15:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IptBM-0002rC-RM
	for gcvg-git-2@gmane.org; Wed, 07 Nov 2007 23:15:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753696AbXKGWPR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Nov 2007 17:15:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756525AbXKGWPR
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Nov 2007 17:15:17 -0500
Received: from wa-out-1112.google.com ([209.85.146.176]:55646 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753068AbXKGWPP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Nov 2007 17:15:15 -0500
Received: by wa-out-1112.google.com with SMTP id v27so3003023wah
        for <git@vger.kernel.org>; Wed, 07 Nov 2007 14:15:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=AROQ+iNUYO25oU0u6Yvrcxj5FSBSlyHlecEDmUBxzGc=;
        b=ddJTf04rNPjMuanLyAiArEwnQYsdiP4BVuFt9xPdqi/iJaN8ySfGt8xnSSmH6cM6e+GPiebB27svT6rOcqcuTJmdEHkPFQ5c4BvStLUK/7JCuOroVsK3rDCj7BdhvzeyYCfL5DO7q1P56A1/ZO3+QvTkJvR42MIGT4ARDtDi2ko=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=oTip9ys2IY1H1Fbkb38WVeLBPpkSWJQGBNrklf1s9+3PYUo1c1K1bY9UOixzW0DGtHworkpPHqiShxjTlCL29kwAAq/x69IP8ShASSMSLCOTN+3UEdNbUB74abLRg8gZATYMdzuBaJasRSb3wbJlX98RhqKDyjXnW2X5rRrfF/Y=
Received: by 10.114.176.1 with SMTP id y1mr8068249wae.1194473714169;
        Wed, 07 Nov 2007 14:15:14 -0800 (PST)
Received: by 10.115.54.19 with HTTP; Wed, 7 Nov 2007 14:15:14 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63872>

In project root:
 git log arch/powerpc/platforms/52xx
works as expected

 cd arch/powerpc/platforms/52xx
 git log arch/powerpc/platforms/52xx
fatal: ambiguous argument 'arch/powerpc/platforms/52xx': unknown
revision or path not in the working tree.
Use '--' to separate paths from revisions

still in arch/powerpc/platforms/52xx
git log
get log for the whole project

Shouldn't git log give the the log for the tree under the current directory?

jonsmirl@terra:~/mpc5200b/arch/powerpc/platforms/52xx$ git --version
git version 1.5.3.4.1458.g3e72e

-- 
Jon Smirl
jonsmirl@gmail.com
