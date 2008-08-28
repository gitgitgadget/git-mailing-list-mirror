From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [kernel.org users] [RFD] On deprecating "git-foo" for builtins
Date: Thu, 28 Aug 2008 13:10:14 -0700
Message-ID: <7v63pkew9l.fsf@gitster.siamese.dyndns.org>
References: <20080826145719.GB5046@coredump.intra.peff.net>
 <1219764860.4471.13.camel@gaara.bos.redhat.com>
 <1219766398.7107.87.camel@pmac.infradead.org>
 <alpine.LFD.1.10.0808260959000.3363@nehalem.linux-foundation.org>
 <20080826180926.GA25711@isilmar.linta.de>
 <alpine.LFD.1.10.0808261114070.3363@nehalem.linux-foundation.org>
 <23DFA9EC-9523-4179-BA3C-ACBDB82953DF@cs.indiana.edu>
 <alpine.DEB.1.10.0808271126190.10784@gandalf.stny.rr.com>
 <20080827230903.GB11005@flint.arm.linux.org.uk>
 <48B5E90E.3000601@s5r6.in-berlin.de>
 <20080828191956.GA7906@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Stefan Richter <stefanr@s5r6.in-berlin.de>,
	Steven Rostedt <rostedt@goodmis.org>,
	Kristian =?utf-8?Q?H=C3=B8gsberg?= <krh@redhat.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Dominik Brodowski <linux@dominikbrodowski.net>,
	users@kernel.org, Jeff King <peff@peff.net>,
	Perry Wagle <wagle@cs.indiana.edu>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	David Woodhouse <dwmw2@infradead.org>, git@vger.kernel.org
To: Russell King <rmk@arm.linux.org.uk>
X-From: git-owner@vger.kernel.org Thu Aug 28 22:14:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYnqD-00035W-IM
	for gcvg-git-2@gmane.org; Thu, 28 Aug 2008 22:11:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753478AbYH1UKc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Aug 2008 16:10:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752913AbYH1UKc
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Aug 2008 16:10:32 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:60562 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752061AbYH1UKc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Aug 2008 16:10:32 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id BA82555A2C;
	Thu, 28 Aug 2008 16:10:30 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 3180E55A28; Thu, 28 Aug 2008 16:10:17 -0400 (EDT)
In-Reply-To: <20080828191956.GA7906@flint.arm.linux.org.uk> (Russell King's
 message of "Thu, 28 Aug 2008 20:19:56 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 5D29CEF0-753D-11DD-A020-9EE598D589B0-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94129>

Russell King <rmk@arm.linux.org.uk> writes:

> On Thu, Aug 28, 2008 at 01:53:50AM +0200, Stefan Richter wrote:
>> Russell King wrote:
>> >And no warnings before hand that the commands you were using were
>> >deprecated.
>> 
>> (a) They weren't deprecated, they were moved into a different directory.
>
> I think Junio will tell you differently on the "deprecation" bit.

The short answer is "no, not anymore".

I might have ;-), if you asked me a few days ago, and the topic of this
thread was exactly to decide the answer to that question, which was
concluded with $gmane/93793.

>> (b) There have been several announcements of the 1.6.0 prereleases and 
>> the 1.6.0 release crossposted.  Of course somebody forgot to tell you 
>> what you will learn from these release notes.  Unfair.
>
> Cross posting to high traffic mailing lists doesn't guarantee that
> it'll be read.  It's the wrong place to do it.
>
> Arguably, though, the lack of information to users on the system affected
> is not git maintainers fault.  It's the fault of the admins on that system
> not having read the release notes themselves, and warning their users (for
> whom git is a *critical* bit of software) that an upgrade is going to take
> place, and they should read such-and-such.
>
> Like a note in the system MOTD.

I've heard enough of "the changes in 1.6.0 was underadvertised and caused
users pain".  I am now aware that git has more mature and its userbase has
broadened beyond populations that read release notes (I rarely read
release notes to updates to vim or coreutils either, and that is showing
the maturity of the packages -- nothing to complain about and I am not
complaining).

But so far nobody gave "here is how I would have advertised it", until
you wrote above.  Thanks.

But that is not something _I_ could have done (and no, "I wouldn't have
accepted the change" is not an option at this point).  Are there things
that the maintainer could have done better?

I think it is fair to say that I have vetoed and am still vetoing many "UI
clean-ups" that propose to change things in a way that "should have been
this way for consistency's sake from day one, if there were no existing
user base".  During discussions to shoot down such proposals, I take
opinions from early adopters (that's you, kernel, wine and x.org people)
very seriously, perhaps to the point that outsiders would feel I am giving
them disproportionately large vetoing power.  Sadly, those "opinions from
eraly adopters" are less and less "real" but more "I'd imagine the early
adopters would say..." these days.  The process would work better if early
adopters do their part to help me by speaking up when it matters from time
to time.
