From: "Sean" <seanlkml@sympatico.ca>
Subject: Re: git-rev-list  in local commit order
Date: Sun, 15 May 2005 17:21:37 -0400 (EDT)
Message-ID: <1273.10.10.10.24.1116192097.squirrel@linux1>
References: <4127.10.10.10.24.1116107046.squirrel@linux1> 
    <1116186533.11872.152.camel@tglx> 
    <4971.10.10.10.24.1116187076.squirrel@linux1> 
    <1116189873.11872.171.camel@tglx> 
    <1102.10.10.10.24.1116189916.squirrel@linux1>
    <1116191636.11872.195.camel@tglx>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 15 23:22:07 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DXQYU-0000Am-Vt
	for gcvg-git@gmane.org; Sun, 15 May 2005 23:21:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261245AbVEOVVz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 May 2005 17:21:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261248AbVEOVVz
	(ORCPT <rfc822;git-outgoing>); Sun, 15 May 2005 17:21:55 -0400
Received: from simmts12.bellnexxia.net ([206.47.199.141]:55962 "EHLO
	simmts12-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S261245AbVEOVVi (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 May 2005 17:21:38 -0400
Received: from linux1 ([69.156.111.46]) by simmts12-srv.bellnexxia.net
          (InterMail vM.5.01.06.10 201-253-122-130-110-20040306) with ESMTP
          id <20050515212137.SHW19200.simmts12-srv.bellnexxia.net@linux1>;
          Sun, 15 May 2005 17:21:37 -0400
Received: from linux1 (linux1.attic.local [127.0.0.1])
	by linux1 (8.12.11/8.12.11) with ESMTP id j4FLLaP5008398;
	Sun, 15 May 2005 17:21:36 -0400
Received: from 10.10.10.24
        (SquirrelMail authenticated user sean)
        by linux1 with HTTP;
        Sun, 15 May 2005 17:21:37 -0400 (EDT)
In-Reply-To: <1116191636.11872.195.camel@tglx>
To: tglx@linutronix.de
User-Agent: SquirrelMail/1.4.4-2
X-Priority: 3 (Normal)
Importance: Normal
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sun, May 15, 2005 5:13 pm, Thomas Gleixner said:
> On Sun, 2005-05-15 at 16:45 -0400, Sean wrote:
>
>> You can continue the personal attacks or you can simply explain to the
>> list what you are trying to accomplish and why it is important and why
>> any
>> other proposal besides yours isn't worthy.
>
> I did never say, that my proposal is the world formula, but I have more
> than once explained, why time is the worst source of information.
>
> You keep beating on time as a reliable source of information and tell me
> that most people are completely happy with it. You must have access to a
> quite good opinion survey.
>
> Time of files or time in commit blobs is not a reliable information to
> keep track of
>  - workflows
>  - history
> Thats all I'm talking about and it is the concern of others too.
>
> In "git" repositories the only reliable source of information is the
> parent child relationship. This information is only partially reliable
> due to the head forward scenario. I think we agreed on this, right ?
> You have no other reliable source of information due to the fact that
> committer names are not unique.
>
>> I disagree that they're inherently error prone,
>> steps can be taken to make them as secure as you desire.
>
> You continue to propose stuff which is not viable. Can you enforce
> - NTP syncronisation
> - the correct usage of rsync options
> - timestamp aware backups
>
> No, you can't.
>
> Why did the mail people resort to "In-Reply-To", "Message-ID" and
> "References" ? Because time turned out to be an inreliable source of
> information. Please read the related discussions before you argue that
> time based solutions are sufficient.
>
> Time is illusion.

What you're missing is that time is only important in this case to deduce
the relative age of each commit LOCALLY.   The intention of this proposal
is not to allow time comparison of commits between repositories.  In fact,
you'll see if you look closely, that you don't need to do that in order to
solve the stated problem of sorting the commits by the time they were
merged LOCALLY.

Cheers,
Sean


