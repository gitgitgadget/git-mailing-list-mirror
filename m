From: "Sean" <seanlkml@sympatico.ca>
Subject: Re: [PATCH] [RFD] Add repoid identifier to commit
Date: Thu, 12 May 2005 06:18:40 -0400 (EDT)
Message-ID: <3203.10.10.10.24.1115893120.squirrel@linux1>
References: <1115847510.22180.108.camel@tglx> 
    <2780.10.10.10.24.1115848852.squirrel@linux1> 
    <1115849141.22180.123.camel@tglx> 
    <2807.10.10.10.24.1115850254.squirrel@linux1> 
    <1115850619.22180.133.camel@tglx> 
    <2853.10.10.10.24.1115850996.squirrel@linux1> 
    <1115851718.22180.153.camel@tglx> 
    <2883.10.10.10.24.1115852463.squirrel@linux1> 
    <1115854419.22180.196.camel@tglx> 
    <2997.10.10.10.24.1115855049.squirrel@linux1> 
    <1115857838.22180.250.camel@tglx> 
    <3185.10.10.10.24.1115858739.squirrel@linux1> 
    <1115859372.22180.266.camel@tglx> 
    <3259.10.10.10.24.1115859535.squirrel@linux1>
    <1115892451.16187.561.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: tglx@linutronix.de, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 12 12:11:25 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DWAes-0002Am-Iu
	for gcvg-git@gmane.org; Thu, 12 May 2005 12:11:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261398AbVELKSt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 May 2005 06:18:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261396AbVELKSt
	(ORCPT <rfc822;git-outgoing>); Thu, 12 May 2005 06:18:49 -0400
Received: from simmts7.bellnexxia.net ([206.47.199.165]:35740 "EHLO
	simmts7-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S261398AbVELKSl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 May 2005 06:18:41 -0400
Received: from linux1 ([69.156.111.46]) by simmts7-srv.bellnexxia.net
          (InterMail vM.5.01.06.10 201-253-122-130-110-20040306) with ESMTP
          id <20050512101840.RCTX23474.simmts7-srv.bellnexxia.net@linux1>;
          Thu, 12 May 2005 06:18:40 -0400
Received: from linux1 (linux1.attic.local [127.0.0.1])
	by linux1 (8.12.11/8.12.11) with ESMTP id j4CAIeep010693;
	Thu, 12 May 2005 06:18:40 -0400
Received: from 10.10.10.24
        (SquirrelMail authenticated user sean)
        by linux1 with HTTP;
        Thu, 12 May 2005 06:18:40 -0400 (EDT)
In-Reply-To: <1115892451.16187.561.camel@hades.cambridge.redhat.com>
To: "David Woodhouse" <dwmw2@infradead.org>
User-Agent: SquirrelMail/1.4.4-2
X-Priority: 3 (Normal)
Importance: Normal
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Thu, May 12, 2005 6:07 am, David Woodhouse said:
> On Wed, 2005-05-11 at 20:58 -0400, Sean wrote:
>> > Try to find out the history of kernel.org/.../dwmw2/audit-2.6 in
>> > correct order, using the available tools.
>> >
>> > Come back to me when you are done.
>>
>> Ask me any question that matters and i'll answer it with available
>> tools.
>
> The above question matters, so please answer it if you can. I'll make it
> clearer for you though...
>
> By 'correct order' Thomas means the order in which my old BK-export
> script used to generate the "changesets since last release" web page;
> the order in which the changes actually got merged into Linus'
> repository.
>
> If I looked at the page yesterday, and then I look at it again today, I
> want all the commits I hadn't seen already to be at the _top_.
> Regardless of the date on which they were _originally_ committed to some
> private tree elsewhere.
>
> There were a lot of complaints until I worked out how to get that
> ordering out of BitKeeper.
>

Does BK use a repo ID ?  If not, can you not apply the same process to
git?   Seems the fast forward heads might complicate things slightly....

Sean



