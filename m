From: "Sean" <seanlkml@sympatico.ca>
Subject: Re: [PATCH] [RFD] Add repoid identifier to commit
Date: Wed, 11 May 2005 19:01:03 -0400 (EDT)
Message-ID: <2883.10.10.10.24.1115852463.squirrel@linux1>
References: <1115847510.22180.108.camel@tglx> 
    <2780.10.10.10.24.1115848852.squirrel@linux1> 
    <1115849141.22180.123.camel@tglx> 
    <2807.10.10.10.24.1115850254.squirrel@linux1> 
    <1115850619.22180.133.camel@tglx> 
    <2853.10.10.10.24.1115850996.squirrel@linux1>
    <1115851718.22180.153.camel@tglx>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 12 01:04:04 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DW0FB-0005iQ-LQ
	for gcvg-git@gmane.org; Thu, 12 May 2005 01:03:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261746AbVEKXJM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 May 2005 19:09:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262066AbVEKXIH
	(ORCPT <rfc822;git-outgoing>); Wed, 11 May 2005 19:08:07 -0400
Received: from simmts7.bellnexxia.net ([206.47.199.165]:47051 "EHLO
	simmts7-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S262076AbVEKXBE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 May 2005 19:01:04 -0400
Received: from linux1 ([69.156.111.46]) by simmts7-srv.bellnexxia.net
          (InterMail vM.5.01.06.10 201-253-122-130-110-20040306) with ESMTP
          id <20050511230103.OAEB23474.simmts7-srv.bellnexxia.net@linux1>;
          Wed, 11 May 2005 19:01:03 -0400
Received: from linux1 (linux1.attic.local [127.0.0.1])
	by linux1 (8.12.11/8.12.11) with ESMTP id j4BN11oR003747;
	Wed, 11 May 2005 19:01:01 -0400
Received: from 10.10.10.24
        (SquirrelMail authenticated user sean)
        by linux1 with HTTP;
        Wed, 11 May 2005 19:01:03 -0400 (EDT)
In-Reply-To: <1115851718.22180.153.camel@tglx>
To: tglx@linutronix.de
User-Agent: SquirrelMail/1.4.4-2
X-Priority: 3 (Normal)
Importance: Normal
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Wed, May 11, 2005 6:48 pm, Thomas Gleixner said:

Hey Thomas,

> Maybe you have missed the point, where one Committer holds more than one
> repository. See davem/net-2.6 and davem/sparc-2.6. Not to talk of
> Russell King's and Greg's multiple repositories.
> The Author is irrelevant, because one Author sends patches to more than
> one maintainer. Author _cannot_ be a source of tracking information. If
> you want to do heuristic guesses on Author/Committer pairs, then you
> make the situation more complex than it is already.

Why would anyone care how many repositories Russell or Greg use?  Why does
anyone care if Dave used his repo A, B, or C?   Aren't I still just going
to contact him via his author email addy if I have an issue with an object
he has added to the stream?

And if I do care which repo he used, why don't I care about the case i've
outlined where the chain of command information is lost?

> As I said before it is completely irrelevant whether fast forward was
> pulled into C directly from A or from B.
>
> Whats the relevant content of getting the same thing from A or B ?

Exactly!!!  So what is relevant of getting the same thing from Dave's A or
B?  The only point would be to show chain of command, but you don't seem
interested in that.

> If you want to do this, you break the fast forward mechanism and
> reinvent the pull ping-pong which is avoided by the fast forwards.

Yes, I think there are other ways to avoid the ping pong too.

Sean


