From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH] diff-cache path restriction fix.
Date: Wed, 25 May 2005 11:06:16 +0200
Message-ID: <20050525090616.GB27025@elte.hu>
References: <7vu0ksrv1v.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0505241757280.2307@ppc970.osdl.org> <7vekbwru6x.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0505241814220.2307@ppc970.osdl.org> <7v3bscqdlr.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0505242002340.2307@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 25 11:07:51 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Darpf-0006E3-Df
	for gcvg-git@gmane.org; Wed, 25 May 2005 11:05:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261834AbVEYJHT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 25 May 2005 05:07:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261825AbVEYJHT
	(ORCPT <rfc822;git-outgoing>); Wed, 25 May 2005 05:07:19 -0400
Received: from mx2.elte.hu ([157.181.151.9]:16545 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261834AbVEYJHF (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 25 May 2005 05:07:05 -0400
Received: from chiara.elte.hu (chiara.elte.hu [157.181.150.200])
	by mx2.elte.hu (Postfix) with ESMTP id 8E80831D338;
	Wed, 25 May 2005 11:04:14 +0200 (CEST)
Received: by chiara.elte.hu (Postfix, from userid 17806)
	id 385C51FC2; Wed, 25 May 2005 11:06:28 +0200 (CEST)
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0505242002340.2307@ppc970.osdl.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


* Linus Torvalds <torvalds@osdl.org> wrote:

> On Tue, 24 May 2005, Junio C Hamano wrote:
> >
> > LT> Also, what language do you actually speak?
> > 
> > Japanese.
> 
> It is possible it is cultural. I certainly find it harder to read the 
> "unexpected" way.

i'm quite sure it's related to ambiguity. The main problem for the human 
brain when reading code is ambiguity of expression - ambiguity triggers 
'logic' areas of the brain, instead of the 'visual automation' portions
of the brain.  Like it or not, most of the code reading we do is all
automatism, if we had to _think_ about the visual structure of the code
we'd be much less effective.

The moment we fall out of automation (you go to the bathroom in the 
morning but the toothpaste is empty, or you are in the shop and the 
coffee area got moved to another place), we feel unease. Thinking during 
normally routine activities means problems, it means distraction, it 
meant larger reaction times in the jungle for millions of years, and 
that's why the built-in unease.  Thinking generates unease _especially_ 
if you dont expect it and dont want it - even if you happen to be Albert 
Einstein or Linus Torvalds ;) [And it's way too easy to let the 
autopilot drive all the time - there are people who stop thinking in 
their childhood and autopilot through life.]

Coding styles are mostly there to reduce the syntactic ambiguities of 
computer languages (and hence reducing parsing complexity), and thus to 
make it easier for the human brain to parse them - and thus to give more 
brain capacity for the real thinking.

the other interesting question is, why do most coders pick the 'x < 1' 
variant? I'm quite sure that's due to most of us having learned coding 
via operators. It's "x := 1" and "x /= 2", where the mirror image is not 
valid - and we extend that expectation to ambiguous operators too. It's 
the more complex entitity (the variable) that we think about first, and 
then comes the less complex entity. But if someone has a strong math 
background (Junio?) then the "1 < x < 5" syntax could be the natural 
thing he got used to.

so as long as the actual expressions are used in an unambiguous way, 
it's fine and it's part of the coding style and it's all a matter of 
getting used to it. Junio's method is just as unambiguous. How quickly
you can adopt to another coding style is directly related to how
practiced you are at it, but it also depends on your fundamental
abstraction abilities. The overwhelming majority of coders dont "switch"
a coding style that easily, but e.g. people who maintain a large number
of packages or use lots of languages are very good at it. You have the
luxory to be able to read your own coding style all day so it's pretty
natural to feel unease if something else comes along :)

	Ingo
