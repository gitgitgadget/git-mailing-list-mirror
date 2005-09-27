From: A Large Angry SCM <gitzilla@gmail.com>
Subject: Re: hared GIT repos (was Re: rsync deprecated but promoted?)
Date: Tue, 27 Sep 2005 11:36:20 -0700
Message-ID: <43399124.8020706@gmail.com>
References: <20050925163201.GA29198@tumblerings.org> <4d4586301dca616f42880612fae01492@cream.org> <20050926133204.GB21019@pasky.or.cz> <pan.2005.09.27.06.35.35.834134@smurf.noris.de>
Reply-To: gitzilla@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 27 20:37:49 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EKKJX-0004qX-Rl
	for gcvg-git@gmane.org; Tue, 27 Sep 2005 20:36:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965033AbVI0SgZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Sep 2005 14:36:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965036AbVI0SgZ
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Sep 2005 14:36:25 -0400
Received: from zproxy.gmail.com ([64.233.162.198]:29857 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S965033AbVI0SgY (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 27 Sep 2005 14:36:24 -0400
Received: by zproxy.gmail.com with SMTP id i11so259973nzi
        for <git@vger.kernel.org>; Tue, 27 Sep 2005 11:36:23 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:disposition-notification-to:date:from:reply-to:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=gvI/eHZ03x2BW9HNWXOsqcEsen8ZqD1noZRiAhO1gx5qONU0jRqEpLRYSS53XS7id4MGLCB8Os7W+e4fRFKv5x60YnvQPpuhPk5M3XJITDKa/UaVNazRPO6Kw+yvVohY3K/5+tYphexeEtGuP31nEqu/vl+qNPaj8DZ0c/h1+AA=
Received: by 10.36.89.11 with SMTP id m11mr2880224nzb;
        Tue, 27 Sep 2005 11:36:23 -0700 (PDT)
Received: from ?10.0.0.6? ( [66.251.101.178])
        by mx.gmail.com with ESMTP id 19sm2424822nzp.2005.09.27.11.36.21;
        Tue, 27 Sep 2005 11:36:23 -0700 (PDT)
User-Agent: Mozilla Thunderbird 1.0 (X11/20041207)
X-Accept-Language: en-us, en
To: Matthias Urlichs <smurf@smurf.noris.de>
In-Reply-To: <pan.2005.09.27.06.35.35.834134@smurf.noris.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9414>

Matthias Urlichs wrote:
> Hi, Petr Baudis wrote:
> 
>>The thing is, rsync is bad - it will happily put
>>duplicate, redundant, and especially unwanted data to your repository,
>>especially when the shared GIT repositories happen.
> 
> Speaking of which -- is anybody working on that one?
> 
> I find myself in need of a multiuser shared repository that cannot
> be corrupted (i.e. I want to prevent the users from removing objects,
> and replacing a ref with something that is not a child of the sha1 that's
> already there should also be prevented).
> 

Yes. Actually just the protocol spec so far. Although, progress has been 
interrupted by the process of moving to the SoCal area from Fla.
