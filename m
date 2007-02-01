From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] git-checkout: disable guides how to switch branches with ui.guide
Date: Thu, 01 Feb 2007 13:06:34 -0800
Message-ID: <7vabzxoaed.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0701311405430.3021@xanadu.home>
	<20070131231942.GB31145@coredump.intra.peff.net>
	<Pine.LNX.4.64.0701311907500.3021@xanadu.home>
	<20070201030030.GA1979@coredump.intra.peff.net>
	<7vd54ur26u.fsf@assigned-by-dhcp.cox.net>
	<7vlkjip7mu.fsf_-_@assigned-by-dhcp.cox.net>
	<20070201184403.GA6326@moooo.ath.cx>
	<7vabzxpq2t.fsf@assigned-by-dhcp.cox.net>
	<20070201205145.GA13439@moooo.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Matthias Lederhofer <matled@gmx.net>
X-From: git-owner@vger.kernel.org Thu Feb 01 22:06:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HCj8x-0007Fp-2O
	for gcvg-git@gmane.org; Thu, 01 Feb 2007 22:06:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423013AbXBAVGg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Feb 2007 16:06:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423016AbXBAVGg
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Feb 2007 16:06:36 -0500
Received: from fed1rmmtai14.cox.net ([68.230.241.45]:52828 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1423013AbXBAVGf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Feb 2007 16:06:35 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070201210634.PPWC4586.fed1rmmtao101.cox.net@fed1rmimpo01.cox.net>;
          Thu, 1 Feb 2007 16:06:34 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id JM6a1W00Y1kojtg0000000; Thu, 01 Feb 2007 16:06:34 -0500
In-Reply-To: <20070201205145.GA13439@moooo.ath.cx> (Matthias Lederhofer's
	message of "Thu, 1 Feb 2007 21:51:45 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38404>

Matthias Lederhofer <matled@gmx.net> writes:

> Junio C Hamano <junkio@cox.net> wrote:
>> The original hope was after a few times one would know to use
>> either -f or -b depending on what he wants, and would not run
>> plain vanilla branch switching "git checkout master".
> What is the point in detached heads if the user should start using -b
> after a few times?  I think detached heads are useful, so I will not
> use -b with it.

The error message you quoted is given when your head is detached
and you tried the regular "checkout an existing branch" -- which
will lose where your detached HEAD currently is.  You either say
"it's OK to lose it because I am done with it and I do not need
to keep it anymore" with "-f", or you say "I am done with this
detached state for now, but I know I need to revisit it later"
with "-b".

So if you will not use -b with it to discard a temporary state
that is detached HEAD, that is perfectly fine.  Detached head is
useful.
