From: Bill Lear <rael@zopyra.com>
Subject: Re: [PATCH] Lose perl dependency. (fwd)
Date: Sat, 20 Jan 2007 20:32:41 -0600
Message-ID: <17842.53449.35322.514320@lisa.zopyra.com>
References: <Pine.LNX.4.63.0701181149260.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<7vwt3h7dp6.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0701202240210.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<200701210137.41219.robin.rosenberg.lists@dewire.com>
	<Pine.LNX.4.63.0701210234350.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Robin Rosenberg <robin.rosenberg.lists@dewire.com>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 21 03:33:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H8SWG-0000Uy-Sf
	for gcvg-git@gmane.org; Sun, 21 Jan 2007 03:33:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751059AbXAUCdN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sat, 20 Jan 2007 21:33:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751141AbXAUCdN
	(ORCPT <rfc822;git-outgoing>); Sat, 20 Jan 2007 21:33:13 -0500
Received: from mail.zopyra.com ([65.68.225.25]:60010 "EHLO zopyra.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751059AbXAUCdM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 20 Jan 2007 21:33:12 -0500
Received: (from rael@localhost)
	by zopyra.com (8.11.6/8.11.6) id l0L2X9J12072;
	Sat, 20 Jan 2007 20:33:09 -0600
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0701210234350.22628@wbgn013.biozentrum.uni-wuerzburg.de>
X-Mailer: VM 7.18 under Emacs 21.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37303>

How about a '--order' switch?

   --order=3Dchrono[logical]
   --order=3Drev[erse][-chrono[logical]] (default)

The switches "--reverse" and "--noreverse" are certainly confusing in
the context of a default that is "reverse chronological order".

BTW, my mailer is defaulting to sending mail to the original poster,
CCing others, including the mailing list.  I'm used to simply replying
to the list.  Is this the proper convention here, to reply directly to
humans and CC the list?


Bill

On Sunday, January 21, 2007 at 02:39:59 (+0100) Johannes Schindelin wri=
tes:
>Hi,
>
>On Sun, 21 Jan 2007, Robin Rosenberg wrote:
>
>> l=F6rdag 20 januari 2007 23:04 skrev Johannes Schindelin:
>> > +--reverse::
>> > +
>> > +	Output the commits in reverse order.
>> > +
>>=20
>> The --reverse is really bad naming since the default *is* to list=20
>> commits in reverse order.
>
>Easy. In my worldview it is _not_ the reverse order. It is the most=20
>useful order, and thus straight-forward.
>
>> Name it "--chronological" or something to indicate that you do not w=
ant=20
>> the default reverse order.
>
>But it is not chronological. Take for example "git log --topo-order=20
>--reverse". See? Not chronological. Not even reverse chronological.
>
>> Some suggestions:
>> 	--chronological
>> 	--forward
>> 	--noreverse
>> 	--commit-order
>
>All of these have a high "Huh?" effect on me. "forward" is wrong,=20
>"noreverse" is confusing at best, and commit-order is anything but=20
>obvious. IOW those names don't solve a problem.
>
>Ciao,
>Dscho
