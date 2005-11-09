From: Petr Baudis <pasky@suse.cz>
Subject: Re: Expected Behavior?
Date: Thu, 10 Nov 2005 00:12:48 +0100
Message-ID: <20051109231248.GL16061@pasky.or.cz>
References: <E1EZKOB-0002j5-VY@jdl.com> <7vwtjjllw4.fsf@assigned-by-dhcp.cox.net> <20051108210332.GB23265@c165.ib.student.liu.se> <20051109112452.GD30496@pasky.or.cz> <46a038f90511091504l7218df18k251bec75491891e9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Fredrik Kuivinen <freku045@student.liu.se>,
	Junio C Hamano <junkio@cox.net>,
	Jon Loeliger <jdl@freescale.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 10 00:15:18 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EZz7d-0002Dd-SC
	for gcvg-git@gmane.org; Thu, 10 Nov 2005 00:12:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751552AbVKIXMv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 9 Nov 2005 18:12:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751553AbVKIXMv
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Nov 2005 18:12:51 -0500
Received: from w241.dkm.cz ([62.24.88.241]:59571 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751550AbVKIXMu (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 9 Nov 2005 18:12:50 -0500
Received: (qmail 9365 invoked by uid 2001); 10 Nov 2005 00:12:48 +0100
To: Martin Langhoff <martin.langhoff@gmail.com>
Content-Disposition: inline
In-Reply-To: <46a038f90511091504l7218df18k251bec75491891e9@mail.gmail.com>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11435>

Dear diary, on Thu, Nov 10, 2005 at 12:04:11AM CET, I got a letter
where Martin Langhoff <martin.langhoff@gmail.com> said that...
> On 11/10/05, Petr Baudis <pasky@suse.cz> wrote:
> > The world would be so much better if there would be just a _single_
> > per-file automerger instead of three right now...
> 
> I don't quite agree with this. The multi-merger mechanism is something
> (relatively) unique and powerful in GIT.

I'm not talking about mechanism but about the recommended policy (if you
have something better, fine, use it - just keep _one_ default one
instead of three, since this doesn't have anything or much to do with
the actual merge strategy). Besides,

> Having fast+stupid, with fallback to slow+smart is an excellent
> strategy, and having the mechanism in place means that if someone is
> crazy enough to write a smarter merge script for a language or a
> particular project (say, to ease the transition to a new directory
> layout) it is entirely possible.

what mechanism are you talking about? All the scripts have it hardcoded
what to use, it seems - cg-Xmergefile, git-merge-one-file or some
subroutine...

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
