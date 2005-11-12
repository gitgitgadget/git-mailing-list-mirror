From: Junio C Hamano <junkio@cox.net>
Subject: Re: Comments on recursive merge..
Date: Fri, 11 Nov 2005 16:42:37 -0800
Message-ID: <7v8xvuk876.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0511070837530.3193@g5.osdl.org>
	<20051107225807.GA10937@c165.ib.student.liu.se>
	<7vll00ov2l.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0511071629270.3247@g5.osdl.org>
	<7v4q6ilt3m.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0511111437410.3228@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 12 01:44:05 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EajTe-0001yN-LE
	for gcvg-git@gmane.org; Sat, 12 Nov 2005 01:42:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750802AbVKLAmk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 11 Nov 2005 19:42:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750813AbVKLAmk
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Nov 2005 19:42:40 -0500
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:42211 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S1750802AbVKLAmj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Nov 2005 19:42:39 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051112004139.WPMT11356.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 11 Nov 2005 19:41:39 -0500
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0511111437410.3228@g5.osdl.org> (Linus Torvalds's
	message of "Fri, 11 Nov 2005 14:53:56 -0800 (PST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11651>

Linus Torvalds <torvalds@osdl.org> writes:

> I actually don't think that is surprisingly high, and would actually have 
> expected it to be closer to 50%.
>
> On the other hand, the merges that end up being pure fast-forwards aren't 
> counted as merges at all (since they don't show up as commits), so maybe 
> that's what skews my preception of a big percentage of merges as being 
> really trivial.

That is what I meant by "it does not show just what you saw".
It shows the whole community experience by everybody who has
commit there.  Being _the_ integration point, I imagine that
most of the pure fast-forwards you saw were real merges for
somebody else, and that merge being fast/safe/convenient
counts, not for you but for your subsystem people.

>>    All three of these points together is a fine demonstration
>>    that you designed git really right.
>
> Well, it's self-re-inforcing. It was designed for the kernel
> usage patterns, so using the kernel to confirm that it's the
> "right design" is a bit self-serving.

That is true.  My point was that it's not like git was done
right only for _you_, sacrificing subsystem people.  The sample
4k commits show that the assumption of the usage pattern git is
optimized for actually holds (commits being small, merges being
mostly trivial) for kernel people other than you.

It is yet to be seen if the same assumption holds for other
projects.
