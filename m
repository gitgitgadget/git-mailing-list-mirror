From: "David S. Miller" <davem@davemloft.net>
Subject: git testsuite failures
Date: Wed, 22 Jun 2005 12:18:35 -0700 (PDT)
Message-ID: <20050622.121835.78708158.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Wed Jun 22 21:15:21 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DlAgr-00064O-OS
	for gcvg-git@gmane.org; Wed, 22 Jun 2005 21:15:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261458AbVFVTSy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 22 Jun 2005 15:18:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261542AbVFVTSy
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Jun 2005 15:18:54 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:63716
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S261458AbVFVTSm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jun 2005 15:18:42 -0400
Received: from localhost ([127.0.0.1] ident=davem)
	by sunset.davemloft.net with esmtp (Exim 4.50)
	id 1DlAk8-0002Xw-6e
	for git@vger.kernel.org; Wed, 22 Jun 2005 12:18:36 -0700
To: git@vger.kernel.org
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


There are test cases failing in the testsuite over the
past few days, is this expected?

*** t6001-rev-list-merge-order.sh ***
 ...
* FAIL 3: simple merge order check_output simple-merge-order git-rev-list --merge-order --show-breaks HEAD
* FAIL 4: two diamonds merge order (g6) check_output two-diamonds-merge-order-g6 git-rev-list --merge-order --show-breaks g4
 ...
* FAIL 8: cross-epoch, head at l5, prune at l1 check_output cross-epoch-head-at-l5-prune-at-l1 git-rev-list --merge-order l5 ^l1
* FAIL 9: duplicated head arguments check_output duplicated-head-arguments git-rev-list --merge-order l5 l5 ^l1
 ...
* FAIL 20: max-count 10 - merge order check_output max-count-10-merge-order git-rev-list --merge-order --show-breaks --max-count=10 l5
 ...
* FAIL 23: --max-age=c3, --merge-order check_output max-age-c3-merge-order git-rev-list --merge-order --max-age=51148811 l5
 ...
