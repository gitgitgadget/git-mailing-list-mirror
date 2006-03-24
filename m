From: Junio C Hamano <junkio@cox.net>
Subject: Re: Errors GITtifying GCC and Binutils
Date: Thu, 23 Mar 2006 16:15:02 -0800
Message-ID: <7vveu43dh5.fsf@assigned-by-dhcp.cox.net>
References: <20060322133337.GU20746@lug-owl.de>
	<Pine.LNX.4.64.0603221517210.26286@g5.osdl.org>
	<Pine.LNX.4.64.0603221607580.26286@g5.osdl.org>
	<44223B90.3040500@zytor.com>
	<1143128751.6850.35.camel@neko.keithp.com>
	<Pine.LNX.4.64.0603230758260.26286@g5.osdl.org>
	<BAYC1-PASMTP0912D2287AB923F3338969AEDE0@CEZ.ICE>
	<Pine.LNX.4.64.0603231134160.26286@g5.osdl.org>
	<20060323204825.GE30176@spearce.org>
	<20060323211151.GI26071@mythryan2.michonline.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 24 01:15:59 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FMZxQ-0001Qn-6Q
	for gcvg-git@gmane.org; Fri, 24 Mar 2006 01:15:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422652AbWCXAPI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 23 Mar 2006 19:15:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422924AbWCXAPH
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Mar 2006 19:15:07 -0500
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:56557 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S1422923AbWCXAPF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Mar 2006 19:15:05 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060324001503.ELYQ20875.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 23 Mar 2006 19:15:03 -0500
To: Ryan Anderson <ryan@michonline.com>
In-Reply-To: <20060323211151.GI26071@mythryan2.michonline.com> (Ryan
	Anderson's message of "Thu, 23 Mar 2006 16:11:51 -0500")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17889>

Ryan Anderson <ryan@michonline.com> writes:

> On Thu, Mar 23, 2006 at 03:48:25PM -0500, Shawn Pearce wrote:
>> 
>> But your definately right; once the blame/annotate war settles out
>> GIT will have pretty much everything one might need - except a good
>> distributed bug/issue tracking type system.  :-)
>
> Junio, where do we stand on this?

As far as I am concerned, you two are still on the starting
line.  Admittably, Fredrik took a bit more time to come to there
while you were still waiting there.  But since then I do not
think either of you moved much.

I have not seen anybody to come up with a test history, compare
what the two algorithms do on that test history, and argue why
one is more correct than the other.  I've been too busy to start
that myself, and honestly speaking I am not that interested in
the details myself in that area.

To me, the only reason annotate/blame exist in git is to support
the cvs server emulation, so obviously I want at least _one_ of
them working correctly to be usable by git-cvsserver, but beyond
that, which one to pick is not really what I am interested in.
When I am working in a git repository, I'd rather use
combination of whatchanged and pickaxe not annotate/blame myself
anyway.

I suspect there are people a lot more interested in having a
better annotate/blame, and I've been sort-of hoping somebody
would really start that blame/annotate war.
