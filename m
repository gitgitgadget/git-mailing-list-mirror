From: Sven Verdoolaege <skimo@kotnet.org>
Subject: t1001-read-tree-m-2way.sh failed
Date: Thu, 20 Apr 2006 15:01:21 +0200
Message-ID: <20060420130121.GO11428MdfPADPa@greensroom.kotnet.org>
Reply-To: skimo@liacs.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Thu Apr 20 15:01:51 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FWYn8-0007eh-Ch
	for gcvg-git@gmane.org; Thu, 20 Apr 2006 15:01:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750895AbWDTNB0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 20 Apr 2006 09:01:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750897AbWDTNB0
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Apr 2006 09:01:26 -0400
Received: from psmtp04.wxs.nl ([195.121.247.13]:42141 "EHLO psmtp04.wxs.nl")
	by vger.kernel.org with ESMTP id S1750892AbWDTNBZ (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 20 Apr 2006 09:01:25 -0400
Received: from greensroom.kotnet.org (ip54515aaa.direct-adsl.nl [84.81.90.170])
 by psmtp04.wxs.nl
 (iPlanet Messaging Server 5.2 HotFix 2.07 (built Jun 24 2005))
 with SMTP id <0IY000688UUAG7@psmtp04.wxs.nl> for git@vger.kernel.org; Thu,
 20 Apr 2006 15:01:22 +0200 (MEST)
Received: (qmail 14094 invoked by uid 500); Thu, 20 Apr 2006 13:01:22 +0000
To: git@vger.kernel.org
Content-disposition: inline
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18967>

*** t1001-read-tree-m-2way.sh ***
* FAIL 1: setup
        echo frotz >frotz &&
             echo nitfol >nitfol &&
             cat bozbar-old >bozbar &&
             echo rezrov >rezrov &&
             echo yomin >yomin &&
             git-update-index --add nitfol bozbar rezrov &&
             treeH=`git-write-tree` &&
             echo treeH $treeH &&
             git-ls-tree $treeH &&

             cat bozbar-new >bozbar &&
             git-update-index --add frotz bozbar --force-remove rezrov &&
             git-ls-files --stage >M.out &&
             treeM=`git-write-tree` &&
             echo treeM $treeM &&
             git-ls-tree $treeM &&
             git-diff-tree $treeH $treeM
*   ok 2: 1, 2, 3 - no carry forward
*   ok 3: 4 - carry forward local addition.
*   ok 4: 5 - carry forward local addition.
*   ok 5: 6 - local addition already has the same.
*   ok 6: 7 - local addition already has the same.
*   ok 7: 8 - conflicting addition.
*   ok 8: 9 - conflicting addition.
*   ok 9: 10 - path removed.
*   ok 10: 11 - dirty path removed.
*   ok 11: 12 - unmatching local changes being removed.
*   ok 12: 13 - unmatching local changes being removed.
*   ok 13: 14 - unchanged in two heads.
*   ok 14: 15 - unchanged in two heads.
*   ok 15: 16 - conflicting local change.
*   ok 16: 17 - conflicting local change.
*   ok 17: 18 - local change already having a good result.
*   ok 18: 19 - local change already having a good result, further modified.
*   ok 19: 20 - no local change, use new tree.
*   ok 20: 21 - no local change, dirty cache.
*   ok 21: 22 - local change cache updated.
*   ok 22: DF vs DF/DF case setup.
*   ok 23: DF vs DF/DF case test.
* failed 1 among 23 test(s)

skimo
