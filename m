From: "Sean" <seanlkml@sympatico.ca>
Subject: Re: [PATCH] [RFD] Add repoid identifier to commit
Date: Thu, 12 May 2005 06:58:21 -0400 (EDT)
Message-ID: <1280.10.10.10.24.1115895501.squirrel@linux1>
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
    <3203.10.10.10.24.1115893120.squirrel@linux1>
    <1115894589.16187.570.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: tglx@linutronix.de, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 12 12:51:30 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DWBHJ-0007cV-Vl
	for gcvg-git@gmane.org; Thu, 12 May 2005 12:50:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261405AbVELK60 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 May 2005 06:58:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261430AbVELK60
	(ORCPT <rfc822;git-outgoing>); Thu, 12 May 2005 06:58:26 -0400
Received: from simmts8.bellnexxia.net ([206.47.199.166]:38788 "EHLO
	simmts8-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S261405AbVELK6W (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 May 2005 06:58:22 -0400
Received: from linux1 ([69.156.111.46]) by simmts8-srv.bellnexxia.net
          (InterMail vM.5.01.06.10 201-253-122-130-110-20040306) with ESMTP
          id <20050512105821.SNUX26867.simmts8-srv.bellnexxia.net@linux1>;
          Thu, 12 May 2005 06:58:21 -0400
Received: from linux1 (linux1.attic.local [127.0.0.1])
	by linux1 (8.12.11/8.12.11) with ESMTP id j4CAwLeR011123;
	Thu, 12 May 2005 06:58:21 -0400
Received: from 10.10.10.24
        (SquirrelMail authenticated user sean)
        by linux1 with HTTP;
        Thu, 12 May 2005 06:58:21 -0400 (EDT)
In-Reply-To: <1115894589.16187.570.camel@hades.cambridge.redhat.com>
To: "David Woodhouse" <dwmw2@infradead.org>
User-Agent: SquirrelMail/1.4.4-2
X-Priority: 3 (Normal)
Importance: Normal
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Thu, May 12, 2005 6:43 am, David Woodhouse said:
> On Thu, 2005-05-12 at 06:18 -0400, Sean wrote:
>> Does BK use a repo ID ?  If not, can you not apply the same process to
>> git?   Seems the fast forward heads might complicate things
>> slightly....
>
> BK doesn't fast-forward in quite the same way as git does. But we're not
> really supposed to be paying too much attention to how BK works.

lol, i just asked because you brought it up.

> Your claim is that you can do this with existing git tools. I await that
> demonstration.

Well i'm not going to write the code for you, but simply descend the
history ordered by local commit time as given by the file object and
you're done.

Sean.


