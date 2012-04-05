From: Martin Fick <mfick@codeaurora.org>
Subject: Interleaved remote branch update problems
Date: Thu, 5 Apr 2012 15:49:14 -0600
Organization: CAF
Message-ID: <201204051549.14397.mfick@codeaurora.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Apr 05 23:49:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SFuYT-00058G-Ie
	for gcvg-git-2@plane.gmane.org; Thu, 05 Apr 2012 23:49:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755527Ab2DEVtQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Apr 2012 17:49:16 -0400
Received: from wolverine02.qualcomm.com ([199.106.114.251]:27784 "EHLO
	wolverine02.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755489Ab2DEVtP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Apr 2012 17:49:15 -0400
X-IronPort-AV: E=McAfee;i="5400,1158,6671"; a="177027739"
Received: from pdmz-ns-mip.qualcomm.com (HELO mostmsg01.qualcomm.com) ([199.106.114.10])
  by wolverine02.qualcomm.com with ESMTP/TLS/ADH-AES256-SHA; 05 Apr 2012 14:49:15 -0700
Received: from mfick-lnx.localnet (pdmz-snip-v218.qualcomm.com [192.168.218.1])
	by mostmsg01.qualcomm.com (Postfix) with ESMTPA id 0E70810004AA
	for <git@vger.kernel.org>; Thu,  5 Apr 2012 14:49:15 -0700 (PDT)
User-Agent: KMail/1.13.5 (Linux/2.6.32-37-generic; KDE/4.4.5; x86_64; ; )
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194813>

I have noticed that git push --force does not reliably force 
a push to remote branches.  In particular, it will not 
update a remote branch if that branch has been updated since 
the beginning of the push.  Is this normal, is this 
expected?  It also fails to fast forward in a similar 
situation without the -f flag.  This seems counter intuitive 
from the perspective of a git push user.  Are there good 
reasons for this?

-Martin

(Using git 1.7.8 or 1.7.10-rc3)

-- 
Employee of Qualcomm Innovation Center, Inc. which is a 
member of Code Aurora Forum
