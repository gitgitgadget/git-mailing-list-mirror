From: "Sean" <seanlkml@sympatico.ca>
Subject: Re: [PATCH] [RFD] Add repoid identifier to commit
Date: Wed, 11 May 2005 20:45:39 -0400 (EDT)
Message-ID: <3185.10.10.10.24.1115858739.squirrel@linux1>
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
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 12 02:39:06 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DW1id-0000Cu-N5
	for gcvg-git@gmane.org; Thu, 12 May 2005 02:38:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261265AbVELApz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 May 2005 20:45:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261270AbVELApz
	(ORCPT <rfc822;git-outgoing>); Wed, 11 May 2005 20:45:55 -0400
Received: from simmts8.bellnexxia.net ([206.47.199.166]:10730 "EHLO
	simmts8-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S261265AbVELApo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 May 2005 20:45:44 -0400
Received: from linux1 ([69.156.111.46]) by simmts8-srv.bellnexxia.net
          (InterMail vM.5.01.06.10 201-253-122-130-110-20040306) with ESMTP
          id <20050512004540.QLFY26867.simmts8-srv.bellnexxia.net@linux1>;
          Wed, 11 May 2005 20:45:40 -0400
Received: from linux1 (linux1.attic.local [127.0.0.1])
	by linux1 (8.12.11/8.12.11) with ESMTP id j4C0jd0I005277;
	Wed, 11 May 2005 20:45:39 -0400
Received: from 10.10.10.24
        (SquirrelMail authenticated user sean)
        by linux1 with HTTP;
        Wed, 11 May 2005 20:45:39 -0400 (EDT)
In-Reply-To: <1115857838.22180.250.camel@tglx>
To: tglx@linutronix.de
User-Agent: SquirrelMail/1.4.4-2
X-Priority: 3 (Normal)
Importance: Normal
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Wed, May 11, 2005 8:30 pm, Thomas Gleixner said:
> On Wed, 2005-05-11 at 19:44 -0400, Sean wrote:
>> What problem are you trying to solve?
>
> The problem to explain the obvious facts to an agnostic

No the problem is you're seeing dragons.

> Aarg. Did you ever get in contact with QA departements ?

Can we please not _invent_ problems where there are none?  Can you show a
specific case today where repoid would make one ounce of difference in the
life of anyone?

> Assume you have:  bugfix - stable - devel repositories.

Why does this imaginary QA department use the same committer and author
for all of them?  And why is it you switch from imaginary problems of
dave, greg and russell to imaginary problems of a fictitious QA
department?

> You have to track down a problem in bugfix and the source of it.
> It does not matter whether the maintainer of "bugfix" pulled it from
> devel or from stable. It's his fault anyway.
>
> But we are not talking about faults and guiltiness. We want to identify
> the location and the context _where_ and _why_ this change was created.
>
> The current solution of git makes it impossible to retrieve this
> information in a consistent way.

Wrong.  When a commit is pulled from a repository, all the surrounding
context of every commit that came before it and after it on that branch is
pulled right along with it.

> So you have no quick solution to figure out what happened. Quite
> contrary, you have to dissect inconsistent information.
>
> See also the thread about "Stop git-rev-list at sha1 match".

Sorry, this one is entertaining enough <g>

>> The chain of command might be good to know in the same way that an
>> accurate signed-off-by chain is good to know.
>
> This sentence makes me guess, that you actually are working in a QA
> departement and therefor trying to maximize the amount of irrelevant
> information.

No, you seem to want it both ways.  Sometimes it's important to you to
know where an object came from and how it got there, and sometimes it's
not.  Interesting blind spot.

Sean


