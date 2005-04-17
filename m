From: Kenneth Johansson <ken@kenjo.org>
Subject: Re: Merge with git-pasky II.
Date: Mon, 18 Apr 2005 01:53:14 +0200
Message-ID: <4262F6EA.2010005@kenjo.org>
References: <E1DNI0G-0000bo-00@gondolin.me.apana.org.au> <Pine.LNX.4.58.0504171530150.7211@ppc970.osdl.org> <20050417232905.GA2721@gondor.apana.org.au> <20050417233441.GU1461@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@osdl.org>, mingo@elte.hu, simon@himi.org,
	david.lang@digitalinsight.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 18 01:50:35 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNJWt-0007PU-OM
	for gcvg-git@gmane.org; Mon, 18 Apr 2005 01:50:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261568AbVDQXyB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Apr 2005 19:54:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261572AbVDQXyB
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Apr 2005 19:54:01 -0400
Received: from main.gmane.org ([80.91.229.2]:2271 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S261568AbVDQXxw (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 17 Apr 2005 19:53:52 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1DNJWA-0007Lc-Pc
	for git@vger.kernel.org; Mon, 18 Apr 2005 01:49:35 +0200
Received: from 1-1-4-20a.ras.sth.bostream.se ([82.182.72.90])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 18 Apr 2005 01:49:34 +0200
Received: from ken by 1-1-4-20a.ras.sth.bostream.se with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 18 Apr 2005 01:49:34 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 1-1-4-20a.ras.sth.bostream.se
User-Agent: Mozilla Thunderbird 1.0 (Macintosh/20041206)
X-Accept-Language: en-us, en
In-Reply-To: <20050417233441.GU1461@pasky.ji.cz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Petr Baudis wrote:
> Dear diary, on Mon, Apr 18, 2005 at 01:29:05AM CEST, I got a letter
> where Herbert Xu <herbert@gondor.apana.org.au> told me that...
> 
>>I get the feeling that it isn't that bad.  For example, if we did it
>>at the points where the blobs actually entered the tree, then the cost
>>is always proportional to the change size (the number of new blobs).
> 
> 
> No. The collision check is done in the opposite cache - when you want to
> write a blob and there is already a file of the same hash in the tree.
> So either the blob is already in the database, or you have a collision.
> 
> Therefore, the cost is proportional to the size of what stays unchanged.
> 

?? now I'm confused. Surly the only cost involved is to never write over 
a file that already exist in the cache and that is already done NOW as 
far as I read the code. So there is NO extra cost in detecting an collision.





