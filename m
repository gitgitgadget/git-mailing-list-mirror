From: Bob Portmann <bportmann@yahoo.com>
Subject: Re: git-log produces no output
Date: Fri, 21 Apr 2006 12:13:16 -0700 (PDT)
Message-ID: <20060421191316.48338.qmail@web60314.mail.yahoo.com>
References: <4d8e3fd30604211158w71e97efew9646203a5510f409@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Linus Torvalds <torvalds@osdl.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Apr 21 21:13:24 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FX14D-0008KF-2m
	for gcvg-git@gmane.org; Fri, 21 Apr 2006 21:13:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751263AbWDUTNS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 21 Apr 2006 15:13:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751264AbWDUTNS
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Apr 2006 15:13:18 -0400
Received: from web60314.mail.yahoo.com ([209.73.178.137]:50857 "HELO
	web60314.mail.yahoo.com") by vger.kernel.org with SMTP
	id S1751263AbWDUTNR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Apr 2006 15:13:17 -0400
Received: (qmail 48340 invoked by uid 60001); 21 Apr 2006 19:13:16 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=e5+2RQYx5hhpTTlYr7YMeS0OZRgagaFuSJgpv86mA58+Ini45XumDugr6Gumq1Rk7HXxDc1aejj9ETlgROsFcYu5WIKVxzBdmc33xbFd4rJ06UiRDQPALExn0QAb/179b1jPaU6jVmVCpO9SsnMdVNVpYN7T5x9/CaRQ4LcLMfI=  ;
Received: from [140.172.241.92] by web60314.mail.yahoo.com via HTTP; Fri, 21 Apr 2006 12:13:16 PDT
To: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
In-Reply-To: <4d8e3fd30604211158w71e97efew9646203a5510f409@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19026>

--- Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com> wrote:
> On 4/21/06, Bob Portmann <bportmann@yahoo.com> wrote:
> [...]
> > test-log> export PAGER='more -i'
> > test-log> git log
> > test-log>
> >
> > Adding the option -i (which should do nothing) has eliminated the
> > output.
> 
> Well, on my machine:
> paolo@Italia:~/gkernel$ more -i
> more: unknown option "-i"
> usage: more [-dflpcsu] [+linenum | +/pattern] name1 name2 ...

Well, then try an option that does work.  On my system less and more
are essentially the same and -i just causes it to ignore case on
searches.  The PAGER is automatically setup to 'less -XRse' on my
system (not sure why).  Changing it to 'more' makes git-log work, but
it should work with 'less -XRse' as well since that works with other
commands on the system (e.g. man) and git-whatchanged as well.

Bob
 
> Ciao,
> --
> Paolo
> http://paolociarrocchi.googlepages.com
> 


__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
