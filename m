From: Ben Greear <greearb@candelatech.com>
Subject: question git & branches
Date: Mon, 29 Aug 2005 01:07:42 -0700
Organization: Candela Technologies
Message-ID: <4312C24E.4000803@candelatech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Mon Aug 29 10:09:16 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E9egF-0002mH-31
	for gcvg-git@gmane.org; Mon, 29 Aug 2005 10:07:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751222AbVH2IHo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 29 Aug 2005 04:07:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751229AbVH2IHo
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Aug 2005 04:07:44 -0400
Received: from ns1.lanforge.com ([66.165.47.210]:36769 "EHLO www.lanforge.com")
	by vger.kernel.org with ESMTP id S1751222AbVH2IHn (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 29 Aug 2005 04:07:43 -0400
Received: from [71.112.205.201] (pool-71-112-205-201.sttlwa.dsl-w.verizon.net [71.112.205.201])
	(authenticated bits=0)
	by www.lanforge.com (8.12.8/8.12.8) with ESMTP id j7T8Bqo6018281
	for <git@vger.kernel.org>; Mon, 29 Aug 2005 01:11:53 -0700
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.10) Gecko/20050719 Fedora/1.7.10-1.3.1
X-Accept-Language: en-us, en
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7894>

Hello!

I've been trying out git and have some questions...

I installed the latest snapshot of git, pulled down the
kernel (2.6.13-rc7), and started hacking.  What fun...got myself
a git patch and was happy.

Then, decided I wanted to branch off my changes from the
main tree so I could maintain the patch-set separate for
this particular feature.

I created a new branch 'ben_dev_rfcnt'.

Now, I also have another patch that I wanted to pull into git.

Before merging this, I created another branch 'foo'.

I changed to this branch foo and imported my patch and resolved the
conflicts, etc.

I think I'm missing something fundamental though...  I wanted to
change to the ben_dev_rfcnt branch to build a kernel without my
additional patch.  git branch ben_dev_rfcnt seems to change
it fine, but all of the changes for repository 'foo' are also
still here.

Am I completely missing how branches work, or just missing a few
commands?

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com
