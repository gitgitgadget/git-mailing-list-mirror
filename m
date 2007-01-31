From: Junio C Hamano <junkio@cox.net>
Subject: Re: Difficulties in advertising a new branch to git newbies
Date: Wed, 31 Jan 2007 15:03:15 -0800
Message-ID: <7v1wlau7d8.fsf@assigned-by-dhcp.cox.net>
References: <87odognuhl.wl%cworth@cworth.org>
	<20070130231015.GB10075@coredump.intra.peff.net>
	<7vzm80vv1s.fsf@assigned-by-dhcp.cox.net>
	<20070131032248.GA17504@coredump.intra.peff.net>
	<Pine.LNX.4.64.0701310932320.3021@xanadu.home>
	<20070131170752.GA19527@coredump.intra.peff.net>
	<7vhcu7uewe.fsf@assigned-by-dhcp.cox.net>
	<20070131225121.GC20514@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Nicolas Pitre <nico@cam.org>,
	cworth@cworth.org, git@vger.kernel.org
To: Theodore Tso <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Thu Feb 01 00:03:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HCOU5-00086L-Sq
	for gcvg-git@gmane.org; Thu, 01 Feb 2007 00:03:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933284AbXAaXDS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 31 Jan 2007 18:03:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933297AbXAaXDS
	(ORCPT <rfc822;git-outgoing>); Wed, 31 Jan 2007 18:03:18 -0500
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:42616 "EHLO
	fed1rmmtao07.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933284AbXAaXDR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Jan 2007 18:03:17 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070131230316.JTLG3976.fed1rmmtao07.cox.net@fed1rmimpo02.cox.net>;
          Wed, 31 Jan 2007 18:03:16 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id Hz3G1W0041kojtg0000000; Wed, 31 Jan 2007 18:03:16 -0500
In-Reply-To: <20070131225121.GC20514@thunk.org> (Theodore Tso's message of
	"Wed, 31 Jan 2007 17:51:21 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38303>

Theodore Tso <tytso@mit.edu> writes:

> ...  Just because we don't have a name to that precise commit
> inside the git system doesn't necessary mean the user can't get back
> there.
> In fact, the user probably could via "history | grep 'git checkout'".

If you mean grep 'git checkout|git reset' perhaps.  After
checking out a specific commit (because the user was told about
the commit out-of-band, say, via e-mail), the user can still
visit other commits with e.g. "git reset --hard HEAD~20".

>> So "until you make commits" is not sufficient, which means that
>> covering all the way you can make commits isn't, either.
>
> My personal belief is that covering all the way you can make commits
> is where you want to be putting the check.  If I say something like
>
> git checkout f00b51b8
>
> There's nothing dangerous about that statement.

I do not think anybody is arguing that particular checkout is
dangerous.  The warning message is about the fact that your HEAD
is now detached, which might not have been what you intended
(and you will later get a real warning when you do a really
dangerous thing, which is "to come back and lose your point").
