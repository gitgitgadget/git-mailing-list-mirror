From: Peter Williams <pwil3058@bigpond.net.au>
Subject: Re: Core and Not-So Core
Date: Wed, 11 May 2005 11:17:39 +1000
Message-ID: <42815D33.60905@bigpond.net.au>
References: <2cfc40320505100800426d38ca@mail.gmail.com>	 <20050510225235.GD26384@pasky.ji.cz> <2cfc403205051017505b57da72@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Petr Baudis <pasky@ucw.cz>, Git Mailing List <git@vger.kernel.org>,
	Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Wed May 11 03:10:44 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DVfjt-0004rD-R9
	for gcvg-git@gmane.org; Wed, 11 May 2005 03:10:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261863AbVEKBRp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 May 2005 21:17:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261869AbVEKBRp
	(ORCPT <rfc822;git-outgoing>); Tue, 10 May 2005 21:17:45 -0400
Received: from omta03sl.mx.bigpond.com ([144.140.92.155]:892 "EHLO
	omta03sl.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S261863AbVEKBRm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 May 2005 21:17:42 -0400
Received: from [192.168.0.4] (really [147.10.132.202])
          by omta03sl.mx.bigpond.com with ESMTP
          id <20050511011740.XYK20830.omta03sl.mx.bigpond.com@[192.168.0.4]>;
          Wed, 11 May 2005 01:17:40 +0000
User-Agent: Mozilla Thunderbird 1.0.2-1.3.2 (X11/20050324)
X-Accept-Language: en-us, en
To: jon@blackcubes.dyndns.org
In-Reply-To: <2cfc403205051017505b57da72@mail.gmail.com>
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta03sl.mx.bigpond.com from [147.10.132.202] using ID pwil3058@bigpond.net.au at Wed, 11 May 2005 01:17:40 +0000
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Jon Seymour wrote:
> On 5/11/05, Petr Baudis <pasky@ucw.cz> wrote:
> 
>>Dear diary, on Tue, May 10, 2005 at 05:00:33PM CEST, I got a letter
>>where Jon Seymour <jon.seymour@gmail.com> told me that...
>>
>>Yes. And that's how it should be - the directory cache is just that - a
>>_cache_. 
> 
> 
> No argument there.
> 
> 
>> So unlike the objects database which has well-defined format and is
>>supposed to be "public", you should view the directory cache as internal
>>git tools' structure. If you want to mess with it too, either use the
>>proper level of abstraction and call the git tools, or don't mess with
>>it at all. And you need to care about it only if you want the git tools
>>working on the same tree properly too - so in that case use the git
>>tools too.
> 
> 
> I agree in principle, though I'd like users to be able to easily
> switch between the Eclipse and git tools view of the workspace if they
> want to - who am I to say how a user should work? Eclipse does this
> kind of thing quite well with CVS precisely because it shares the
> workspace structures with the CVS command line tools rather than
> "re-inventing" the wheel.

I disagree here.  My experience is that Eclipse does not work well with 
command line use of CVS within one of its workspaces.  This is because 
Eclipse keeps too much "state" information internally instead of relying 
on CVS for all information about the state of the CVS playground.  This 
is one of the reasons that you can't attach Eclipse to an already 
checked out CVS playground.  The problem should be easily avoidable.

In spite of the above, Eclipse's SCM interface is the best that I've 
stumbled across and is the main reason that I use Eclipse.  I 
particularly like the ability to compare a file in the workspace with 
those in different versions, branches, etc.

So I'm looking forward to a git plug-in.

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
