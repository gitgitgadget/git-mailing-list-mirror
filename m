From: Ben Greear <greearb@candelatech.com>
Subject: Re: question git & branches
Date: Mon, 29 Aug 2005 10:49:23 -0700
Organization: Candela Technologies
Message-ID: <43134AA3.2010308@candelatech.com>
References: <4312C24E.4000803@candelatech.com> <Pine.LNX.4.58.0508290754410.3243@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 29 19:51:22 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E9nlB-0003Wc-L4
	for gcvg-git@gmane.org; Mon, 29 Aug 2005 19:49:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751176AbVH2Rt1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 29 Aug 2005 13:49:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751179AbVH2Rt1
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Aug 2005 13:49:27 -0400
Received: from ns1.lanforge.com ([66.165.47.210]:8610 "EHLO www.lanforge.com")
	by vger.kernel.org with ESMTP id S1751176AbVH2Rt0 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 29 Aug 2005 13:49:26 -0400
Received: from [71.112.205.201] (pool-71-112-205-201.sttlwa.dsl-w.verizon.net [71.112.205.201])
	(authenticated bits=0)
	by www.lanforge.com (8.12.8/8.12.8) with ESMTP id j7THrao6026210;
	Mon, 29 Aug 2005 10:53:37 -0700
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.10) Gecko/20050719 Fedora/1.7.10-1.3.1
X-Accept-Language: en-us, en
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0508290754410.3243@g5.osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7910>

Linus Torvalds wrote:
> 
> On Mon, 29 Aug 2005, Ben Greear wrote:
> 
>>I think I'm missing something fundamental though...  I wanted to
>>change to the ben_dev_rfcnt branch to build a kernel without my
>>additional patch.  git branch ben_dev_rfcnt seems to change
>>it fine, but all of the changes for repository 'foo' are also
>>still here.
> 
> 
> "git branch" just creates the branch, it doesn't actually do anything
> else. Use "git checkout <branchname>" to switch to it.

I tried 'git checkout ben_dev_rfcnt'.  It took a few seconds and
had no errors.  But, the files created on my other branch still
exist in the code tree, and I still see my patch in the
existing files..  I would expect them to go away.

I don't think I've managed to commit anything to any branch yet...  Could that
be part of the problem?

I tried gitk -all, and get this error popup:

Gitk: error reading commits: bad arguments to git-rev-list.
(Note: arguments to gitk are passed to
git-rev-list
to allow selection of commits to be displayed.)

Thanks,
Ben

> You can do both with "bit checkout -b <branchname>" which both creates the 
> branch and switches to it.
> 
> (Both "git branch" and "git checkout -b <branchname>" that reate a new
> branch take an optional argument which says what point you want the branch
> to start at. It defaults to "current state", but you can create a branch
> at any point in the history by just explicitly stating the commit name
> that you want to start off with as the head of the branch)
> 
> Use "gitk --all" to visualize where the different branches are in the 
> history, and a plain "git branch" with no arguments to list the branches 
> and mark your currently active branch.
> 
> 				Linus
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com
