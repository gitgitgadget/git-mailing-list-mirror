From: David Lang <david.lang@digitalinsight.com>
Subject: Re: [PATCH] write-tree performance problems
Date: Tue, 19 Apr 2005 15:09:26 -0700 (PDT)
Message-ID: <Pine.LNX.4.62.0504191508060.26365@qynat.qvtvafvgr.pbz>
References: <200504191250.10286.mason@suse.com>
 <Pine.LNX.4.58.0504191017300.19286@ppc970.osdl.org><200504191412.00227.mason@suse.com>
 <Pine.LNX.4.58.0504191143220.19286@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Chris Mason <mason@suse.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 20 00:14:06 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DO0sQ-0003pA-4R
	for gcvg-git@gmane.org; Wed, 20 Apr 2005 00:07:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261683AbVDSWLb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 19 Apr 2005 18:11:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261687AbVDSWLb
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Apr 2005 18:11:31 -0400
Received: from warden2-p.diginsite.com ([209.195.52.120]:30092 "HELO
	warden2.diginsite.com") by vger.kernel.org with SMTP
	id S261683AbVDSWLZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Apr 2005 18:11:25 -0400
Received: from atlims01.diginsite.com by warden2.diginsite.com
          via smtpd (for vger.kernel.org [12.107.209.244]) with SMTP; Tue, 19 Apr 2005 15:06:18 -0700
Received: by atlexc02.diginsite.com with Internet Mail Service (5.5.2653.19)
	id <JC0C6VXX>; Tue, 19 Apr 2005 18:09:47 -0400
Received: from dlang.diginsite.com ([10.201.10.67]) by wlvexc00.digitalinsight.com with SMTP (Microsoft Exchange Internet Mail Service Version 5.5.2657.72)
	id JDHHAZWT; Tue, 19 Apr 2005 15:09:26 -0700
To: Linus Torvalds <torvalds@osdl.org>
X-X-Sender: dlang@dlang.diginsite.com
In-Reply-To: <Pine.LNX.4.58.0504191143220.19286@ppc970.osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Tue, 19 Apr 2005, Linus Torvalds wrote:

> On Tue, 19 Apr 2005, Chris Mason wrote:
>>
>> Very true, you can't replace quilt with git without ruining both of them.  But
>> it would be nice to take a quilt tree and turn it into a git tree for merging
>> purposes, or to make use of whatever visualization tools might exist someday.
>
> Fair enough. The thing is, going from quilt->git really is a pretty "big
> decision", since it's the decision that says "I will now really commit all
> this quilt changes forever and ever".
>
> Which is also why I think it's actually ok to take a minute to do 100
> quilt patches. This is not something you do on a whim. It's something
> you'd better think about. It's turning a very fluid environment into a
> unchangable, final thing.

what if you turned the forest of quilt patches into a forest of git trees? 
(essentially applying each patch against the baseline seperatly) would 
this make sense or be useful?

David Lang

-- 
There are two ways of constructing a software design. One way is to make it so simple that there are obviously no deficiencies. And the other way is to make it so complicated that there are no obvious deficiencies.
  -- C.A.R. Hoare
