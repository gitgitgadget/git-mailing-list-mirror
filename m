From: "Sean" <seanlkml@sympatico.ca>
Subject: Re: [PATCH] [RFD] Add repoid identifier to commit
Date: Thu, 12 May 2005 07:24:50 -0400 (EDT)
Message-ID: <3745.10.10.10.24.1115897090.squirrel@linux1>
References: <1115847510.22180.108.camel@tglx> <428291CD.7010701@zytor.com> 
    <1115854733.22180.202.camel@tglx> <428297DB.8030905@zytor.com> 
    <1115858022.22180.256.camel@tglx>
    <7vekcdmd16.fsf@assigned-by-dhcp.cox.net> 
    <1115884637.22180.277.camel@tglx> 
    <1895.10.10.10.24.1115890333.squirrel@linux1> 
    <1115890792.22180.306.camel@tglx> 
    <3656.10.10.10.24.1115891188.squirrel@linux1>
    <1115896713.22180.314.camel@tglx>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "Junio C Hamano" <junkio@cox.net>,
	"H. Peter Anvin" <hpa@zytor.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 12 13:17:59 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DWBgt-0002uj-1a
	for gcvg-git@gmane.org; Thu, 12 May 2005 13:17:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261435AbVELLYy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 May 2005 07:24:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261443AbVELLYy
	(ORCPT <rfc822;git-outgoing>); Thu, 12 May 2005 07:24:54 -0400
Received: from simmts7.bellnexxia.net ([206.47.199.165]:35508 "EHLO
	simmts7-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S261435AbVELLYv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 May 2005 07:24:51 -0400
Received: from linux1 ([69.156.111.46]) by simmts7-srv.bellnexxia.net
          (InterMail vM.5.01.06.10 201-253-122-130-110-20040306) with ESMTP
          id <20050512112450.RKYW23474.simmts7-srv.bellnexxia.net@linux1>;
          Thu, 12 May 2005 07:24:50 -0400
Received: from linux1 (linux1.attic.local [127.0.0.1])
	by linux1 (8.12.11/8.12.11) with ESMTP id j4CBOoPk011372;
	Thu, 12 May 2005 07:24:50 -0400
Received: from 10.10.10.24
        (SquirrelMail authenticated user sean)
        by linux1 with HTTP;
        Thu, 12 May 2005 07:24:50 -0400 (EDT)
In-Reply-To: <1115896713.22180.314.camel@tglx>
To: tglx@linutronix.de
User-Agent: SquirrelMail/1.4.4-2
X-Priority: 3 (Normal)
Importance: Normal
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Thu, May 12, 2005 7:18 am, Thomas Gleixner said:
> On Thu, 2005-05-12 at 05:46 -0400, Sean wrote:
>> On Thu, May 12, 2005 5:39 am, Thomas Gleixner said:
>>
>> > Please do the complete test. Sync test2 with test1 and show me the
>> > picture there. It will be the same as you see in test1, which is wrong
>>
>> It will get the fast forward head from test1, and so it _should_ show
>> the
>> exact same thing!  The repositories are in sync, they should display the
>> exact same way.  What is the problem?
>
> What you see is a clone and not a sync / merge.
>

Right, that's what a fast forward head is.  It replaces a sync / merge and
the  trees become exactly syncronized via a shared head.   I have mixed
feelings about fast forward heads, but they don't hide _too_ much
information.  Is there any _useful_ question you can ask where the answer
is lost for all time because of this.

Sean


