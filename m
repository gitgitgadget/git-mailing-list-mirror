From: Jeff Garzik <jgarzik@pobox.com>
Subject: Humble request of 'git' developers
Date: Sat, 23 Apr 2005 15:58:26 -0400
Message-ID: <426AA8E2.60403@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sat Apr 23 21:55:28 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DPQit-0002YH-Df
	for gcvg-git@gmane.org; Sat, 23 Apr 2005 21:55:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261750AbVDWT7M (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Apr 2005 15:59:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261755AbVDWT7M
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Apr 2005 15:59:12 -0400
Received: from 216-237-124-58.infortech.net ([216.237.124.58]:56484 "EHLO
	mail.dvmed.net") by vger.kernel.org with ESMTP id S261750AbVDWT6h
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Apr 2005 15:58:37 -0400
Received: from cpe-065-184-065-144.nc.res.rr.com ([65.184.65.144] helo=[10.10.10.88])
	by mail.dvmed.net with esmtpsa (Exim 4.50 #1 (Red Hat Linux))
	id 1DPQlv-0002ba-Ua
	for git@vger.kernel.org; Sat, 23 Apr 2005 19:58:37 +0000
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050328 Fedora/1.7.6-1.2.5
X-Accept-Language: en-us, en
To: git@vger.kernel.org
X-Spam-Score: 0.0 (/)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


Please stop filling up my /usr/local/bin :)

Just have one 'git' script, which looks in /usr/local/libexec/git for 
further scripts and backends programs like write-tree and diff-cache.

Also, please don't assume that "." is in PATH.  I think there is at 
least one invocation of commit-id with that assumption, in git-pasky-0.6.3.

	Jeff



