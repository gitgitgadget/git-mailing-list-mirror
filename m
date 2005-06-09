From: Dan Holmsand <holmsand@gmail.com>
Subject: Re: [ANNOUNCE] Cogito-0.11.2
Date: Thu, 09 Jun 2005 12:45:43 +0200
Message-ID: <42A81DD7.5070107@gmail.com>
References: <20050608230725.GR982@pasky.ji.cz> <42A780A7.3060608@gmail.com> <20050609083532.GE29665@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Petr Baudis <pasky@ucw.cz>
X-From: git-owner@vger.kernel.org Thu Jun 09 14:15:18 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DgLhM-0002Ls-PE
	for gcvg-git@gmane.org; Thu, 09 Jun 2005 13:59:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261618AbVFIMDf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 9 Jun 2005 08:03:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262362AbVFIMDf
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Jun 2005 08:03:35 -0400
Received: from main.gmane.org ([80.91.229.2]:4537 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S261618AbVFIMDL (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 9 Jun 2005 08:03:11 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1DgKzZ-0005hv-JZ
	for git@vger.kernel.org; Thu, 09 Jun 2005 13:14:33 +0200
Received: from 81-224-201-139-no45.tbcn.telia.com ([81.224.201.139])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 09 Jun 2005 13:14:33 +0200
Received: from holmsand by 81-224-201-139-no45.tbcn.telia.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 09 Jun 2005 13:14:33 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 81-224-201-139-no45.tbcn.telia.com
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050404)
X-Accept-Language: en-us, en
In-Reply-To: <20050609083532.GE29665@pasky.ji.cz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Petr Baudis wrote:
> Dear diary, on Thu, Jun 09, 2005 at 01:35:03AM CEST, I got a letter
> where Dan Holmsand <holmsand@gmail.com> told me that...
> 
>>Well, since I try to use the same output format as git-rev-list --pretty 
>>does (most of the time, it *is* just that...), I can actually already do
>>
>>   cg-log -r:cogito-0.11.1 | git-shortlog
>>
>>and get the same thing.
> 
> 
> I'll see how I like it, but currently I find myself use all of the
> commit header items a lot, so I'm not too keen to losing some of them,
> perhaps except the tree line. Ok, and it might be enough to have the
> parent lines only for the merge commits. Nothing against things like
> s/^author/Author:/.
> 

Oh, all the headers are still available, for sure, just not by default. 
"-v" or "--verbose" is the magic incantation.

The parent is also somewhat visible by default whenever it's not obvious 
who the parent is, as I keep git-diff-tree's "(from sha1)" thing.

/dan

