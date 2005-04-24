From: Jon Seymour <jon.seymour@gmail.com>
Subject: Whales falling on houses - was: Hash collision count
Date: Mon, 25 Apr 2005 08:25:32 +1000
Message-ID: <2cfc40320504241525c4153c2@mail.gmail.com>
References: <426AAFC3.800@pobox.com>
	 <1114297231.10264.12.camel@maze.mythral.org>
	 <426AD835.5070404@pobox.com> <20050423234637.GS13222@pasky.ji.cz>
	 <426AE9ED.4060005@pobox.com> <20050424004039.GU13222@pasky.ji.cz>
	 <426AEBAE.1060402@pobox.com>
	 <68ff9fa6050424142416fbadcd@mail.gmail.com>
Reply-To: jon@zeta.org.au
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Jeff Garzik <jgarzik@pobox.com>, Petr Baudis <pasky@ucw.cz>,
	Ray Heasman <lists@mythral.org>,
	Git Mailing List <git@vger.kernel.org>,
	Linus Torvalds <torvalds@osdl.org>, Imre Simon <is@ime.usp.br>
X-From: git-owner@vger.kernel.org Mon Apr 25 00:21:17 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DPpTA-0006bn-Ex
	for gcvg-git@gmane.org; Mon, 25 Apr 2005 00:20:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262462AbVDXWZm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 24 Apr 2005 18:25:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262465AbVDXWZm
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Apr 2005 18:25:42 -0400
Received: from rproxy.gmail.com ([64.233.170.195]:29071 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262462AbVDXWZd convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Apr 2005 18:25:33 -0400
Received: by rproxy.gmail.com with SMTP id z35so1149691rne
        for <git@vger.kernel.org>; Sun, 24 Apr 2005 15:25:32 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=oG5jzhLwL0kRAxmmcVVLHcnBoXV19LVuaC7WlSWDhCBnYoTuzjPfZljUIwnSSX67KLiriV23CiVqJlVOYnyUQvWLaIYdtuIZ9i9JuAfKabnPL4B4T6x6s568IopxmnVn806u2OGqJPOTuEcg6Qb+2kyPeeCsCar+OlrPiTlTrho=
Received: by 10.38.150.79 with SMTP id x79mr5818398rnd;
        Sun, 24 Apr 2005 15:25:32 -0700 (PDT)
Received: by 10.38.104.32 with HTTP; Sun, 24 Apr 2005 15:25:32 -0700 (PDT)
To: Imre Simon <imres.g@gmail.com>
In-Reply-To: <68ff9fa6050424142416fbadcd@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

.> 
> 1. Take your favorite text file, at least 160 characters long.
> 2. Choose 160 positions in this file.
> 3. For each position choose your favorite mispelling of that character.
> 4. Produce all 2^160 text files, all of the same length, choosing for
> each position either the original or the alternate character
> 5. Add an arbitrary file of the same length, different from the above
> 
> Two of these files have the same sha1 hash. Or, for that matter, for
> any 160 bit  hash the same is true.

If you were to create those files at 10^9 files per second, it would
take you 10^38 years before you were in position to take step 5. I am
about to turn 38 this week. Would that I could live to 10^38.

It's absolute rubbish to say that the best solution from an
<double-quote>engineering</double-quote> point of view is to eliminate
the infinitessimal possibility of a collision. Engineering is all
about assessing risk and making suitable trade-offs. Every day of the
week, "real" engineers accept life-threatening risks that put
thousands of peoples lives in danger. They do it because we live in a
world where risk cannot be eliminated, merely reduced to an acceptable
level.

I can't understand that you are a prepared to drive a car or fly in a
Boeing or Airbus that has a demonstrated risk of killing you, yet you
want to insist on eliminating a risk that at most might create an
interesting Slashdot headline: "Jolt-crazed programmer finds SHA1
collision - but later dies when whale falls on house".

jon.
-- 
homepage: http://www.zeta.org.au/~jon/
blog: http://orwelliantremors.blogspot.com/
