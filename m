From: Ben Greear <greearb@candelatech.com>
Subject: How to pull a single changeset from a child branch into a parent
 branch?
Date: Thu, 09 Feb 2006 20:03:54 -0800
Organization: Candela Technologies
Message-ID: <43EC10AA.1040800@candelatech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Fri Feb 10 05:04:04 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F7PVn-0002Vv-AN
	for gcvg-git@gmane.org; Fri, 10 Feb 2006 05:03:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751051AbWBJED5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 9 Feb 2006 23:03:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751052AbWBJED4
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Feb 2006 23:03:56 -0500
Received: from ns2.lanforge.com ([66.165.47.211]:20178 "EHLO ns2.lanforge.com")
	by vger.kernel.org with ESMTP id S1751044AbWBJED4 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 9 Feb 2006 23:03:56 -0500
Received: from [71.112.206.236] (pool-71-112-206-236.sttlwa.dsl-w.verizon.net [71.112.206.236])
	(authenticated bits=0)
	by ns2.lanforge.com (8.13.4/8.13.4) with ESMTP id k1A43s1f001338
	for <git@vger.kernel.org>; Thu, 9 Feb 2006 20:03:55 -0800
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.12) Gecko/20050922 Fedora/1.7.12-1.3.1
X-Accept-Language: en-us, en
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15862>

I have a linux-2.6 repo with two branches off of 2.6.13.

One branch (ben_v13) has just my own changes.
A second branch (work_v13) has the 2.6.13.5 patch, and I've also pulled
ben_v13 into it.

Now, I made a small change to work_v13, and I'd like to pull only
that changeset into ben_v13.  Is there a way to do that w/out
having to export and apply a patch?

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com
