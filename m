From: Junio C Hamano <junkio@cox.net>
Subject: Re: An early draft of v1.5.0 release notes (2nd ed)
Date: Wed, 27 Dec 2006 21:54:23 -0800
Message-ID: <7vhcvg1s6o.fsf@assigned-by-dhcp.cox.net>
References: <7vvejx948y.fsf@assigned-by-dhcp.cox.net>
	<7vvejw3iaq.fsf@assigned-by-dhcp.cox.net>
	<20061228020305.GD16612@spearce.org>
	<7vmz583goc.fsf@assigned-by-dhcp.cox.net>
	<20061228022855.GF16612@spearce.org>
	<7vejqk3fom.fsf@assigned-by-dhcp.cox.net>
	<20061228024719.GG16612@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 28 06:54:41 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GzoDq-0007Wu-MC
	for gcvg-git@gmane.org; Thu, 28 Dec 2006 06:54:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964945AbWL1Fy2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Dec 2006 00:54:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964939AbWL1Fy2
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Dec 2006 00:54:28 -0500
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:41875 "EHLO
	fed1rmmtao07.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964932AbWL1Fy1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Dec 2006 00:54:27 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20061228055424.FAPN3976.fed1rmmtao07.cox.net@fed1rmimpo02.cox.net>;
          Thu, 28 Dec 2006 00:54:24 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 45ud1W0161kojtg0000000; Thu, 28 Dec 2006 00:54:38 -0500
To: Shawn Pearce <spearce@spearce.org>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35519>

Shawn Pearce <spearce@spearce.org> writes:

> Junio C Hamano <junkio@cox.net> wrote:
>> Shawn Pearce <spearce@spearce.org> writes:
>> 
>> > The section is really for those who are upgrading from ancient
>> > versions, but the title of the section implies (at least to me)
>> > that these changes aren't something important.
>> 
>> True.  How about "Something important you should already know
>> but just in case" ;-)?
>
> Sure, that's more fun then my proposed text and does summarize the
> section better.  Plus it reminds Git users that maybe they should
> track our releases a little bit more often than only on "major"
> version number increments.  :-)

That was a tongue-in-cheek comment.

I consider git is still young and I have the right to gripe at
the list if something that has been cooking in 'next' without
anybody complaining causes a real breakage immediately after it
gets pushed out to 'master'.  But for the rest of the world, git
has already matured enough that there is much less need to be on
the bleeding edge for the lack of something crucial in the last
released version.

And let's face it.  Nobody has enough time to keep track of the
changes to all tools he uses, it is not unusual to skip a
handful of minor versions, and it is a norm to get surprised
after an upgrade of any tool because there was a major change in
a couple of releases back that he skipped.  I do not have the
right to complain if the end users do not follow every minor
release or every issue of "What's in git.git" messages.  Not
anymore.

So I'd like the introductory section to have more positive
spin.  I tried rewording it and pushed it out to 'todo' branch.
