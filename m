From: Meelis Roos <mroos@linux.ee>
Subject: git bisect: merge problem with deleted file
Date: Thu, 27 Jul 2006 22:37:35 +0300 (EEST)
Message-ID: <Pine.SOC.4.61.0607272235100.19826@math.ut.ee>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
X-From: git-owner@vger.kernel.org Thu Jul 27 21:37:51 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G6Bfw-0003Fv-VE
	for gcvg-git@gmane.org; Thu, 27 Jul 2006 21:37:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751035AbWG0Thi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 27 Jul 2006 15:37:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751046AbWG0Thi
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Jul 2006 15:37:38 -0400
Received: from math.ut.ee ([193.40.36.2]:11914 "EHLO math.ut.ee")
	by vger.kernel.org with ESMTP id S1750961AbWG0Thh (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 27 Jul 2006 15:37:37 -0400
Received: from math.ut.ee (localhost [IPv6:::1])
	by math.ut.ee (8.12.8+Sun/8.12.8/math-1.2) with ESMTP id k6RJbZcB020435
	for <git@vger.kernel.org>; Thu, 27 Jul 2006 22:37:35 +0300 (EEST)
Received: from localhost (mroos@localhost)
	by math.ut.ee (8.12.8+Sun/8.12.2/Submit) with ESMTP id k6RJbZKd020432
	for <git@vger.kernel.org>; Thu, 27 Jul 2006 22:37:35 +0300 (EEST)
X-Authentication-Warning: math.ut.ee: mroos owned process doing -bs
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24334>

mroos@nartsiss:~/compile/linux-2.6$ git bisect start
mroos@nartsiss:~/compile/linux-2.6$ git bisect good 9be2f7c38e0bd64e8a0f74ea68df1e73e2ddfcc3
mroos@nartsiss:~/compile/linux-2.6$ git bisect bad 9676489866a75fdd56b0d3e40ec7884298bb1338
Bisecting: 43 revisions left to test after this
fatal: Untracked working tree file 'Documentation/filesystems/devfs/ChangeLog' would be overwritten by merge.

Got this while trying to bisec Linus' linux-2.6 tree. I have 1 
uncommited change in the tree so this might influence the need for 
merging.

-- 
Meelis Roos (mroos@linux.ee)
