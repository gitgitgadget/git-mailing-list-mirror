From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 2/1] gitweb: Use fixed string for "next" link in commitdiff view
Date: Tue, 24 Oct 2006 11:27:47 -0700
Message-ID: <7viri9h8m4.fsf@assigned-by-dhcp.cox.net>
References: <200610230037.57183.jnareb@gmail.com>
	<7vd58k0wmx.fsf@assigned-by-dhcp.cox.net>
	<200610240008.08325.jnareb@gmail.com>
	<20061024114923.GD20017@pasky.or.cz>
	<7vu01thbvb.fsf@assigned-by-dhcp.cox.net>
	<20061024172627.GU18879@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 24 20:28:25 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GcR0C-0006wr-Fx
	for gcvg-git@gmane.org; Tue, 24 Oct 2006 20:27:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161146AbWJXS1t (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 Oct 2006 14:27:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161147AbWJXS1t
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Oct 2006 14:27:49 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:9166 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S1161146AbWJXS1s (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Oct 2006 14:27:48 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20061024182748.YIAN13992.fed1rmmtao11.cox.net@fed1rmimpo01.cox.net>;
          Tue, 24 Oct 2006 14:27:48 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id eJTX1V00R1kojtg0000000
	Tue, 24 Oct 2006 14:27:32 -0400
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20061024172627.GU18879@pasky.or.cz> (Petr Baudis's message of
	"Tue, 24 Oct 2006 19:26:27 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29998>

Petr Baudis <pasky@suse.cz> writes:

> On Tue, Oct 24, 2006 at 07:17:28PM CEST, Junio C Hamano wrote:
>> Petr Baudis <pasky@suse.cz> writes:
>> 
>> >> > Would it even be necessary to use any SHA-1 name in these cases,
>> >> > I wonder.  Would it make the page less useful if we replace all
>> >> > of the above _commit_ with a fixed string, say, "parent"?
>> >
>> > I really disagree here - what's the point of not using SHA-1? The extra
>> > string carries zero information in comparison with the previous state
>> > and I just can't see how it *improves* stuff. If you're walking in a
>> > maze and making marks on walls, it's still more useful if you have
>> > corridors named by "A", "B", "C", "D" on junctions if you sometimes want
>> > to walk back to the marked corridors.
>> 
>> I think people would recognize A B C D as names but not 40- or
>> 8- hexadecimal letters.
>
> 40-digit hex numbers is insane, I agree. But at least I personally tend
> to recognize 8-digit hex numbers when dancing around them intensively
> for a few minutes. Besides, it can be just "now I took the 8c5 way",
> which is much easier to train your neurons too than "now I took the
> fourth, uh, or was it the fifth parent? one, two, three, four, fifth...
> hmm, what's in the statusbar?".
>
> My point is that this does not improve the situation, and some people
> (me) think it makes it worse, so what's the point of the change?
>
>> I do not care much either way, actually, but I think it might
>> make more sense to use abbreviated object names.  On the other
>> hand it may be Ok to have full 40 letters depending on the
>> layout (e.g. the set of merge parents are shown on a single line
>> in which case it would not fit, etc.).
>
> Yes, I'm all for abbreviated names, but I'm against just writing
> "parent" everywhere.

Fully agreed.  Please make it so, if you so are inclined,
perhaps between you and Jakub?
