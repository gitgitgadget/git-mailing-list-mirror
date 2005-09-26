From: Brian Gerst <bgerst@didntduck.org>
Subject: Re: rsync deprecated but promoted?
Date: Mon, 26 Sep 2005 12:47:16 -0400
Message-ID: <43382614.6080907@didntduck.org>
References: <20050925163201.GA29198@tumblerings.org> <4d4586301dca616f42880612fae01492@cream.org> <20050926133204.GB21019@pasky.or.cz> <433808B2.3070508@didntduck.org> <20050926163604.GC21019@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Martin Coxall <quasi@cream.org>,
	Zack Brown <zbrown@tumblerings.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 26 18:49:19 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EJw7k-0007am-2B
	for gcvg-git@gmane.org; Mon, 26 Sep 2005 18:46:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932393AbVIZQqI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Sep 2005 12:46:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932418AbVIZQqI
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Sep 2005 12:46:08 -0400
Received: from quark.didntduck.org ([69.55.226.66]:36493 "EHLO
	quark.didntduck.org") by vger.kernel.org with ESMTP id S932357AbVIZQp6
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Sep 2005 12:45:58 -0400
Received: from [172.21.26.77] (ip-2.provia.com [208.224.1.2])
	(authenticated)
	by quark.didntduck.org (8.11.6/8.11.6) with ESMTP id j8QGjjI05731;
	Mon, 26 Sep 2005 12:45:45 -0400
User-Agent: Mozilla Thunderbird 1.0.6 (Windows/20050716)
X-Accept-Language: en-us, en
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20050926163604.GC21019@pasky.or.cz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9311>

Petr Baudis wrote:
> Dear diary, on Mon, Sep 26, 2005 at 04:41:54PM CEST, I got a letter
> where Brian Gerst <bgerst@didntduck.org> told me that...
> 
>>The other problem with HTTP vs. rsync is that the HTTP fetch will walk 
>>the entire tree down to the root to verify it has every object.  While 
>>this isn't a bad thing it's usually unnecessary when it's all in one big 
>>pack file.
> 
> 
> Is that really the case? I believe it will walk only to the original ref
> and assume everything before is complete. (Actually, it doesn't even
> seem to honor the --recover patch anymore, which isn't so nice
> especially in case some objects disappeared from your database and you
> would like to get them back. Happenned to me.)

I was talking about the initial pull.  It does stop at the previous head 
for updates.

--
				Brian Gerst
