From: linux@horizon.com
Subject: Re: [zooko@zooko.com: [Revctrl] colliding md5 hashes of human-meaningful
Date: 13 Jun 2005 21:03:18 -0000
Message-ID: <20050613210318.18965.qmail@science.horizon.com>
References: <Pine.LNX.4.58.0506131305550.8487@ppc970.osdl.org>
Cc: git@vger.kernel.org, linux@horizon.com
X-From: git-owner@vger.kernel.org Mon Jun 13 23:02:32 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dhw3r-00070Q-A4
	for gcvg-git@gmane.org; Mon, 13 Jun 2005 23:01:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261386AbVFMVGA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 13 Jun 2005 17:06:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261392AbVFMVEK
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Jun 2005 17:04:10 -0400
Received: from science.horizon.com ([192.35.100.1]:65089 "HELO
	science.horizon.com") by vger.kernel.org with SMTP id S261386AbVFMVDW
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Jun 2005 17:03:22 -0400
Received: (qmail 18966 invoked by uid 1000); 13 Jun 2005 21:03:18 -0000
To: torvalds@osdl.org
In-Reply-To: <Pine.LNX.4.58.0506131305550.8487@ppc970.osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

> No, I just am not letting paranoia mean that I sit around shivering all 
> day long.

I'm sorry if I implied that.  I meant "paranoid" in the sense of
"imagining attack"; you were saying there is no way to attack git via
a collision attack on the underlying hash, and I objected.

I agree with you that:
- The attack is still wildly impractical, and
- Anything is better than the unauthenticated TCP we use these days!

>> The basic attack goes like this:
>> 
>> - I construct two .c files with identical hashes.

> Ok, I have a better plan.
>
> - you learn to fly by flapping your arms fast enough
> - you then learn to pee burning gasoline
> - then, you fly around New York, setting everybody you see on fire, until 
>   people make you emperor.
>
> Sounds like a good plan, no?

ROFL!  Oh my.  That's worthy of reprinting.  I was pleased with myself
for making fun of the "what if there's an accidental hash collision"
theory by assuming that kernel development would continue uninterrupted
until the sun went nova, but this is truly masterful scorn.

> But perhaps slightly impractical.

There are just few laws of physics it violates.

Not to mention that New York is still a trifle touchy about the combination
of flying and burning fossil fuels, and this poses problems for step 3.

> Now, let's go back to your plan. Why do you think your plan is any better 
> than mine?

I was trying to point out that a collision attack is possible.  That is,
*if* we assume that someone can has the ability to find a hash collision,
*then* they can use that to break git's authenticity guarantees.

I wasn't addressing the plausibility of the "if" part.  I agree that
requiring the hashed text to be plausible C source makes all current
attacks (including the MD5 ones) irrelevant, and reduces you to straight
brute force, which is quite implausible.

But it *is* a collsion attack, not a preimage attack, and it *is* at
least consistent with all known laws of physics.

I did *not* say, or mean to imply, that there was anything wrong with
git's hashing.
