From: John Ellson <john.ellson@comcast.net>
Subject: BUG: cg-clone accepts '_' in git_ssh: URI's, but cg-push does not.
Date: Tue, 05 Jul 2005 23:08:55 -0400
Message-ID: <pan.2005.07.06.03.08.55.724181@comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Wed Jul 06 16:44:42 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DqB8L-0001qx-QS
	for gcvg-git@gmane.org; Wed, 06 Jul 2005 16:44:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261919AbVGFOnI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 6 Jul 2005 10:43:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262239AbVGFOnH
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Jul 2005 10:43:07 -0400
Received: from main.gmane.org ([80.91.229.2]:59607 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S261919AbVGFOkl (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 6 Jul 2005 10:40:41 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1DqB4Y-0001BU-OG
	for git@vger.kernel.org; Wed, 06 Jul 2005 16:40:22 +0200
Received: from pcp0010076529pcs.eatntn01.nj.comcast.net ([69.142.241.85])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 06 Jul 2005 16:40:22 +0200
Received: from john.ellson by pcp0010076529pcs.eatntn01.nj.comcast.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 06 Jul 2005 16:40:22 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: pcp0010076529pcs.eatntn01.nj.comcast.net
User-Agent: Pan/0.14.2.91 (As She Crawled Across the Table)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

BUG: cg-clone accepts '_' in git+ssh: URI's, but cg-push does not.

I suggest '_' be added to the allowed character table in send-pack.c

John
