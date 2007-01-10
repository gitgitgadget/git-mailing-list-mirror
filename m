From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Detached HEAD (experimental)
Date: Tue, 09 Jan 2007 16:10:12 -0800
Message-ID: <7vd55nivx7.fsf@assigned-by-dhcp.cox.net>
References: <7vac11yirf.fsf@assigned-by-dhcp.cox.net>
	<87ps9xgkjo.wl%cworth@cworth.org>
	<7virfprquo.fsf@assigned-by-dhcp.cox.net>
	<87odphgfzz.wl%cworth@cworth.org>
	<7vbql9ydd7.fsf@assigned-by-dhcp.cox.net>
	<20070108131735.GA2647@coredump.intra.peff.net>
	<7vzm8tt5kf.fsf@assigned-by-dhcp.cox.net>
	<20070109142130.GA10633@coredump.intra.peff.net>
	<7virffkick.fsf@assigned-by-dhcp.cox.net>
	<20070109213117.GB25012@fieldses.org>
	<7vy7obj07k.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0701091539050.3594@woody.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "J. Bruce Fields" <bfields@fieldses.org>,
	Jeff King <peff@peff.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 10 01:10:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H4R2p-00046t-Ip
	for gcvg-git@gmane.org; Wed, 10 Jan 2007 01:10:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932565AbXAJAKP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 9 Jan 2007 19:10:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932570AbXAJAKP
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Jan 2007 19:10:15 -0500
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:43399 "EHLO
	fed1rmmtao03.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932565AbXAJAKN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jan 2007 19:10:13 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070110001012.VTDX29122.fed1rmmtao03.cox.net@fed1rmimpo01.cox.net>;
          Tue, 9 Jan 2007 19:10:12 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 9C9N1W0091kojtg0000000; Tue, 09 Jan 2007 19:09:22 -0500
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0701091539050.3594@woody.osdl.org> (Linus
	Torvalds's message of "Tue, 9 Jan 2007 15:46:32 -0800 (PST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36434>

Linus Torvalds <torvalds@osdl.org> writes:

> On Tue, 9 Jan 2007, Junio C Hamano wrote:
>> 
>> Being able to test merge or even make commits without being on a
>> branch is vastly useful.
>
> Yes. I think the detached head notion is really really important. I think 
> it was a mistake to not allow it initially, but hey, there were various 
> historical reasons, and the whole thing about how branches worked was a 
> bit up in the air.
>
> I would suggest a solution:
>
>  - git checkout will refuse to switch AWAY from a detached head unless the 
>    SHA1 of the detached head exactly matches some other branch.

... or an existing "ref^{commit}".

> I'd love to see the detached HEAD series move into "master", but I do 
> think we should make sure that people can't drop their work easily by 
> mistake, and I think the above suggestion is both simple and workable.
>
> Comments?

I agree with the "reachability is wrong -- you would lose the
point in the middle" reasoning.
