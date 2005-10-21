From: Ben Lau <benlau@ust.hk>
Subject: How to create a new branch based on a tag?
Date: Fri, 21 Oct 2005 22:57:59 +0800
Message-ID: <435901F7.9020509@ust.hk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Fri Oct 21 04:59:25 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ESn76-0005nJ-4o
	for gcvg-git@gmane.org; Fri, 21 Oct 2005 04:58:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964847AbVJUC51 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 20 Oct 2005 22:57:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964845AbVJUC51
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Oct 2005 22:57:27 -0400
Received: from mx3.ust.hk ([143.89.13.11]:35087 "EHLO mx3.ust.hk")
	by vger.kernel.org with ESMTP id S964847AbVJUC50 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 20 Oct 2005 22:57:26 -0400
Received: from [143.89.135.159] (atz113.rd.ust.hk [143.89.135.159])
	by mx3.ust.hk (8.12.11/8.12.11) with ESMTP id j9L2vMIN087857
	for <git@vger.kernel.org>; Fri, 21 Oct 2005 10:57:23 +0800 (HKT)
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10408>

Hi,

   I would like to create a branch of my own work based on a specific 
kernel version(i.e
v2.6.11). I tried with:

 > git-branch my2.6.11 v2.6.11
error: Object 5dc01c595e6c6ec9ccda4f6f69c131c0dd945f8c is a tree, not a 
commit
fatal: Needed a single revision

  As v2.6.11 is a tree object(tag), git-checkout and git-branch could 
not process it. The
only way I know is using git-read-tree to fetch v2.6.11 content into 
current index and start
a branch based on it. Is there any simpler method?

Thanks!
