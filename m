From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Bizarre missing changes (git bug?)
Date: Tue, 29 Jul 2008 17:32:33 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0807291716060.3334@nehalem.linux-foundation.org>
References: <8502DF7C-5303-49E8-8C67-F837343E2F0C@gmail.com>  <200807260512.40088.zippel@linux-m68k.org>  <alpine.LFD.1.10.0807261249430.4188@nehalem.linux-foundation.org>  <Pine.LNX.4.64.0807270049290.6791@localhost.localdomain> 
 <alpine.LFD.1.10.0807271144520.3486@nehalem.linux-foundation.org>  <Pine.LNX.4.64.0807272101470.6791@localhost.localdomain>  <alpine.LFD.1.10.0807271613440.3486@nehalem.linux-foundation.org>  <Pine.LNX.4.64.0807280141140.6791@localhost.localdomain> 
 <alpine.LFD.1.10.0807272148030.3486@nehalem.linux-foundation.org>  <Pine.LNX.4.64.0807281241180.6791@localhost.localdomain> <46a038f90807282015m7ce3da10h71dfee221c960332@mail.gmail.com> <Pine.LNX.4.64.0807291433430.6791@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Martin Langhoff <martin.langhoff@gmail.com>,
	Tim Harper <timcharper@gmail.com>, git@vger.kernel.org
To: Roman Zippel <zippel@linux-m68k.org>
X-From: git-owner@vger.kernel.org Wed Jul 30 02:36:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNzgL-0004dV-JD
	for gcvg-git-2@gmane.org; Wed, 30 Jul 2008 02:36:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753100AbYG3Afp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jul 2008 20:35:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753249AbYG3Afo
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Jul 2008 20:35:44 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:33376 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753024AbYG3Afo (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 29 Jul 2008 20:35:44 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m6U0ZW7j005742
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 29 Jul 2008 17:35:33 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m6U0ZWBG030316;
	Tue, 29 Jul 2008 17:35:32 -0700
In-Reply-To: <Pine.LNX.4.64.0807291433430.6791@localhost.localdomain>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Spam-Status: No, hits=-3.406 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90715>



On Wed, 30 Jul 2008, Roman Zippel wrote:
> 
> What the short simplified history is more pure laziness

No.

Roman, you're an idiot who doesn't even _understand_ what you are talking 
about. Sadly, you then _think_ you are so smart that you then refuse to 
even consider the fact that others disagree, so you don't even read what 
they write.

Go to my previous email in this thread. Do the example. Look at the 
simplified version. Ponder.

It's not "pure lazyness" when you get the simplified version. It's 
actually a MORE USEFUL RESULT! The simplified version shows the minimal 
explanation of how things ended up the way they are, and that is damn 
useful. What you want is extra _clutter_ most of the time.

It's really sad how you cannot get over your own prejudices here. 

So Roman. Go back, read my previous email in this thread. It's message ID 
is

	<alpine.LFD.1.10.0807291006070.3334@nehalem.linux-foundation.org>

in case it helps you find it.

Read it twice, or three times. Read it with the notion that maybe you 
didn't know best after all. Read it with the possibility that maybe there 
are smarter people than you, and people who have actually worked with git 
for several years.

And if you can't do that, at least stop cc'ing me with your idiocy.

To get to the meat of your email:

> The point I'm trying to make is that the compact history graph has the 
> potential to completely replace the simplified history. The only problem 
> is that it needs a bit of cached extra information, then it can be as fast 
> the short simplified history for the common case and it still can produce 
> as much information as the full simplified history, thus you can still 
> apply as much simplification as you want on top of it.

You're simply full of sh*t. You make two huge mistakes, and I'll spend 
another few minutes of my life trying to educate you one final more time, 
even though from every single indication I have so far, you are unable to 
learn simply because you think you already know the answer.

Your two mistakes are:

 - your "only" problem is fundamental.  It's unsolvable. Git history 
   simplification isn't per-file or even per-directory.  It's 
   per-any-random-set-of-pathnames. You can't "cache" the simplified 
   information, and it's not "a bit" of cached extra info. It's 
   fundamentally a metric truckload of info.

   With a cache, you can make the performance of a repeated query go fast, 
   but that's totally uninteresting.

 - But the other huge mistake you make is EVEN MORE STUPID, because it's 
   so ironic. That magical output you want, and claim is so perfect, and 
   point out "thus you can still apply as much simplification as you want 
   on top of it"? You know what? It already _exists_! It's exactly that 
   --full-history case.

   Can you not see that? That's exactly that --full-history --parents 
   cases. It gives you the full information. You can simplify it to what 
   you want, exactly because it did _not_ simplify things for you. I've 
   even told you so, multiple times, when I suggested you try to do that 
   simplification in "gitk".

In other words, git has the two cases you want: the "extreme simplified 
history" (that is nice to see what really _mattered_, with no extra 
unnecessary duplicate history that didn't actually affect the end result), 
and the "full" history (ooh, I know, we could make a command line called 
"--full-history" to get the latter, so that people who wanted to see it 
all and perhaps distill it to something else could do so).

And I've told you over and over what you should look at, and I've told you 
over and over that the default is actually the _useful_ case, and why. But 
you seem to refuse to listen. You just close your ears and repeat your 
mantra, even though people smarter than you have told you why it's done 
the way it's done. 

Stop stuffing your ears. Listen to what people tell you.

		Linus
