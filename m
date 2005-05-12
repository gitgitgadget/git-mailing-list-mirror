From: "Sean" <seanlkml@sympatico.ca>
Subject: Re: [PATCH] [RFD] Add repoid identifier to commit
Date: Thu, 12 May 2005 07:48:41 -0400 (EDT)
Message-ID: <2247.10.10.10.24.1115898521.squirrel@linux1>
References: <1115847510.22180.108.camel@tglx> <428291CD.7010701@zytor.com> 
    <1115854733.22180.202.camel@tglx> <428297DB.8030905@zytor.com> 
    <1115858022.22180.256.camel@tglx>
    <7vekcdmd16.fsf@assigned-by-dhcp.cox.net> 
    <1115884637.22180.277.camel@tglx> 
    <1895.10.10.10.24.1115890333.squirrel@linux1> 
    <1115890792.22180.306.camel@tglx> 
    <3656.10.10.10.24.1115891188.squirrel@linux1> 
    <1115896713.22180.314.camel@tglx> 
    <3745.10.10.10.24.1115897090.squirrel@linux1>
    <1115898230.11872.8.camel@tglx>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "Junio C Hamano" <junkio@cox.net>,
	"H. Peter Anvin" <hpa@zytor.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 12 13:43:38 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DWC4O-0006P3-SW
	for gcvg-git@gmane.org; Thu, 12 May 2005 13:41:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261502AbVELLst (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 May 2005 07:48:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261505AbVELLst
	(ORCPT <rfc822;git-outgoing>); Thu, 12 May 2005 07:48:49 -0400
Received: from simmts12.bellnexxia.net ([206.47.199.141]:22505 "EHLO
	simmts12-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S261502AbVELLsm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 May 2005 07:48:42 -0400
Received: from linux1 ([69.156.111.46]) by simmts12-srv.bellnexxia.net
          (InterMail vM.5.01.06.10 201-253-122-130-110-20040306) with ESMTP
          id <20050512114841.VQHW19200.simmts12-srv.bellnexxia.net@linux1>;
          Thu, 12 May 2005 07:48:41 -0400
Received: from linux1 (linux1.attic.local [127.0.0.1])
	by linux1 (8.12.11/8.12.11) with ESMTP id j4CBmfQV011748;
	Thu, 12 May 2005 07:48:41 -0400
Received: from 10.10.10.24
        (SquirrelMail authenticated user sean)
        by linux1 with HTTP;
        Thu, 12 May 2005 07:48:41 -0400 (EDT)
In-Reply-To: <1115898230.11872.8.camel@tglx>
To: tglx@linutronix.de
User-Agent: SquirrelMail/1.4.4-2
X-Priority: 3 (Normal)
Importance: Normal
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Thu, May 12, 2005 7:43 am, Thomas Gleixner said:
> On Thu, 2005-05-12 at 07:24 -0400, Sean wrote:
>> Right, that's what a fast forward head is.  It replaces a sync / merge
>> and
>> the  trees become exactly syncronized via a shared head.   I have mixed
>> feelings about fast forward heads, but they don't hide _too_ much
>> information.
>
> The question is how hard it is to do a reconstruction. In the current
> state automatic reconstruction is simply not possible.

You keep evading the question.  What are you reconstructing, and why? 
What questions can you then answer with your reconstruction that you can't
answer  with what we already have today.   You HAVE to explain what the
VALUE of the end result is beyond what we already have today.

>> Is there any _useful_ question you can ask where the answer
>> is lost for all time because of this.
>
> I want to see the history of _any_ repository in the order of  changes
> in the specific repository. The fast forward heads without additional
> information simply do not allow this.

Then just download their repository with the -t switch of rsync or its
equal and preserve the timestamps on the files as they exist in the remote
repository.

> I want to see the history of a file in the correct order. The current
> solution ends up with useless file version diffs or annotates where
> changes are shown in random order and therefor worthless.
>

What is this correct order you're talking about?   The order is _given_
explicitly in the parent child relationships.  There is no other order of
any value, at least none you've been able to put forth.

Sean


