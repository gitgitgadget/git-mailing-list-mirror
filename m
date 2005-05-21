From: "Sean" <seanlkml@sympatico.ca>
Subject: Re: [PATCH] Fix use of wc in t0000-basic
Date: Fri, 20 May 2005 21:13:05 -0400 (EDT)
Message-ID: <4616.10.10.10.24.1116637985.squirrel@linux1>
References: <4600.10.10.10.24.1116637737.squirrel@linux1>
    <Pine.LNX.4.21.0505202109460.30848-100000@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "Linus Torvalds" <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 21 03:13:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DZIXt-00046X-2o
	for gcvg-git@gmane.org; Sat, 21 May 2005 03:12:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261615AbVEUBNd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 May 2005 21:13:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261560AbVEUBNd
	(ORCPT <rfc822;git-outgoing>); Fri, 20 May 2005 21:13:33 -0400
Received: from simmts5.bellnexxia.net ([206.47.199.163]:928 "EHLO
	simmts5-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S261615AbVEUBNN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 May 2005 21:13:13 -0400
Received: from linux1 ([69.156.111.46]) by simmts5-srv.bellnexxia.net
          (InterMail vM.5.01.06.10 201-253-122-130-110-20040306) with ESMTP
          id <20050521011305.TOZS11606.simmts5-srv.bellnexxia.net@linux1>;
          Fri, 20 May 2005 21:13:05 -0400
Received: from linux1 (linux1.attic.local [127.0.0.1])
	by linux1 (8.12.11/8.12.11) with ESMTP id j4L1D5WX012089;
	Fri, 20 May 2005 21:13:05 -0400
Received: from 10.10.10.24
        (SquirrelMail authenticated user sean)
        by linux1 with HTTP;
        Fri, 20 May 2005 21:13:05 -0400 (EDT)
In-Reply-To: <Pine.LNX.4.21.0505202109460.30848-100000@iabervon.org>
To: "Daniel Barkalow" <barkalow@iabervon.org>
User-Agent: SquirrelMail/1.4.4-2
X-Priority: 3 (Normal)
Importance: Normal
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Fri, May 20, 2005 9:10 pm, Daniel Barkalow said:
> On Fri, 20 May 2005, Sean wrote:
>
>> You can't do "wc -l filename" because some versionso of "wc" then
>> include
>> the filename in their output and confuse things.   That was the reason
>> to
>> use "cat" in the first place.
>
> You're reading my patch backwards.
>

Yes, i was.   But presumably someone was stripping the whitespace from wc
for a reason?   Either way the sed-only solution seems a little cleaner.

Sean


