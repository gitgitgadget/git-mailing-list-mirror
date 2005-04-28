From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: kernel.org now has gitweb installed
Date: Thu, 28 Apr 2005 14:52:48 -0700
Message-ID: <42715B30.6010705@zytor.com>
References: <42703E79.8050808@zytor.com>	 <1114673723.12012.324.camel@baythorne.infradead.org>	 <20050428081005.GG8612@pasky.ji.cz>	 <1114676955.12012.346.camel@baythorne.infradead.org>	 <1114680199.12012.363.camel@baythorne.infradead.org>	 <Pine.LNX.4.58.0504281149330.18901@ppc970.osdl.org> <1114723214.2734.9.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@osdl.org>, Petr Baudis <pasky@ucw.cz>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Apr 28 23:49:03 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DRGrF-0006jB-7Y
	for gcvg-git@gmane.org; Thu, 28 Apr 2005 23:47:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262269AbVD1VxJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Apr 2005 17:53:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262272AbVD1VxJ
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Apr 2005 17:53:09 -0400
Received: from terminus.zytor.com ([209.128.68.124]:22429 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S262269AbVD1VxD
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Apr 2005 17:53:03 -0400
Received: from [172.27.0.18] (c-67-169-23-106.hsd1.ca.comcast.net [67.169.23.106])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.1/8.13.1) with ESMTP id j3SLqn4p024182
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 28 Apr 2005 14:52:49 -0700
User-Agent: Mozilla Thunderbird 1.0.2-1.3.2 (X11/20050324)
X-Accept-Language: en-us, en
To: David Woodhouse <dwmw2@infradead.org>
In-Reply-To: <1114723214.2734.9.camel@localhost.localdomain>
X-Spam-Status: No, score=-5.1 required=5.0 tests=ALL_TRUSTED,AWL,BAYES_00 
	autolearn=ham version=3.0.2
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

David Woodhouse wrote:
> 
> Hmm, that's true; albeit unfortunate. 
> 
> Still, using the date isn't any better. It'll give results which are
> about as random as just sorting by the sha1 of each parent.
> 
> Yes, the ordering of the parents in a merge is probably meaningless in
> the general case, but so is the date.
> 
> The best we could probably do, from a theoretical standpoint, is to look
> at the paths via each parent to a common ancestor, and look at how many
> of the commits on each path were done by the same committer. Even that
> isn't ideal, and it's probably fairly expensive -- but it's pointless to
> pretend we can infer anything from _either_ the dates or the ordering of
> the parents in a merge.
> 

I thought about this for a few seconds (I really should do that more 
often...) and realized what it is you want: you want a primary search 
criterion which is "when did event X become visible to me", where "me" 
in this case is the web tool.  That is not repository information, but 
it is perfectly possible for the webtool to be aware of what it has 
previously seen and when.

And yes, this ordering is clearly different for each observer.

	-hpa
