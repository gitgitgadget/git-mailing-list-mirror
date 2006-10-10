From: Luben Tuikov <ltuikov@yahoo.com>
Subject: Re: [PATCH 2/2] gitweb: Show trailing slash when listing tree entry in tree listing
Date: Mon, 9 Oct 2006 23:21:26 -0700 (PDT)
Message-ID: <20061010062126.46664.qmail@web31810.mail.mud.yahoo.com>
References: <20061009205551.GO20017@pasky.or.cz>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Oct 10 08:21:47 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GXAza-0000oN-7p
	for gcvg-git@gmane.org; Tue, 10 Oct 2006 08:21:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964990AbWJJGV1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Oct 2006 02:21:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964993AbWJJGV1
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Oct 2006 02:21:27 -0400
Received: from web31810.mail.mud.yahoo.com ([68.142.207.73]:20321 "HELO
	web31810.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S964990AbWJJGV0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Oct 2006 02:21:26 -0400
Received: (qmail 46666 invoked by uid 60001); 10 Oct 2006 06:21:26 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=BwbJ6nDyUGsJCV1I2iIU/HW4xfSj0eLLijjUUIY7i6KFV2MoE2rDY7FAB/QWCoTF0sTDI7qkH27aJkDrgOJYJTcIHTlFENIqCJntEfVSvoLYmbese2R7AEi6uzW1QkWuS5FTernKgIvKRXyIhE1iy9xxg6oK6bM3hRrRdDNdcVo=  ;
Received: from [71.80.233.118] by web31810.mail.mud.yahoo.com via HTTP; Mon, 09 Oct 2006 23:21:26 PDT
To: Petr Baudis <pasky@suse.cz>, Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <20061009205551.GO20017@pasky.or.cz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28606>

--- Petr Baudis <pasky@suse.cz> wrote:
> I was looking into accesslogs of repo.or.cz for something and noticed
> that I see unusually large number of blame requests. That of course
> attracted my curiosity and I came to conclusion that what I'm seeing is
> not just my personal whim but we have serious usability problem here.
> 
> I'm unfortunately not sure when the update of repo.or.cz gitweb which
> dropped the blob/tree links happenned, so the following _is_ somewhat
> dubious, but I think it's quite telling anyway.
> 
> I have three samples (logfiles) available: #2 almost certainly when the
> blob link was still there, #1 covering the switch and some time before
> and after, and #0 certainly when the blob link was not there anymore,
> but unfortunately spanning only one or two days.
> 
> This is the count of actions invoked from the tree, commit and
> commitdiff view (using the referer information):
> 
>     blame  blob   total requests containing 'a='
> #2  1      18     264
> #1  31     23     399
> #0  4      6      50
> 
> The disparation between #2 and #1,#0 is quite apparent. If we want more
> exact results, I will let #0 accumulate data for a week and then revert
> the removal of the links and start another sample.

Oh, my, oh, my.

Anyone can come up with any "statistic" to convince anyone of
anything.  It's the American way! (to financial success)

I mean, I can even give you a mathematical series which I can add
in certain orders to give me any number I want...  Which is not at
all intutitive.

Anyway, the "confused" link clearly says "blame".  I'm not sure why
your people were trying to think and figure it out, as opposed to
simply clicking on the file name itself.  It is the most intuitive
thing to do as I mentioned in my previous email.

Did you do any demographics on your clickers?  What is their background?
Did you try to calculate how statistically correct your sample is
and if the clickers represent the general computer population out there?
What is your sampling error?

I can hardly accept this "statistic" as a proof to "reintroduce
the redundant links".

But I give up.

If you guys want the redundant links back in, so be it -- submit
a patch.

Then let's fortify gitweb, because we can.  Lets add links and more
redundancy to fortify the user interface so that all and any possibilities
are covered.  And as soon as a NEW git facility is introduced, then
we'll add 10 or 20 more links to gitweb for this just one, single
new facility.  Then with each new single facility if it is related to
any other, the number of links would grow exponentially.  Then after
such and such time has passed, let's look at the code.  Then let's
ask if someone has left maintaining the then gitweb jungle.  More
importantly, let's ask if someone has left _using_ it.  (That would
be the ripe time to start afresh with gitweb2.perl.)

As long as job is being done and the patches are flowing in, and
more and more code is introduced, albeit redundantly, we shouldn't
care what the people who use this every day want or care for.

Hey, let's add more links!

     Luben
P.S. I'll go and collect some statistics now.
