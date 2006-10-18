From: Junio C Hamano <junkio@cox.net>
Subject: Re: [ANNOUNCE] Example Cogito Addon - cogito-bundle
Date: Wed, 18 Oct 2006 15:48:40 -0700
Message-ID: <7vslhlxmt3.fsf@assigned-by-dhcp.cox.net>
References: <20061018053647.GA3507@coredump.intra.peff.net>
	<Pine.LNX.4.64.0610180739230.3962@g5.osdl.org>
	<20061018185225.GU20017@pasky.or.cz>
	<20061018185907.GV20017@pasky.or.cz>
	<7vy7rd1m4q.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0610181510510.1971@xanadu.home>
	<20061018191834.GA18829@spearce.org>
	<Pine.LNX.4.64.0610181525410.1971@xanadu.home>
	<20061018204626.GA19194@spearce.org>
	<Pine.LNX.4.64.0610181358200.3962@g5.osdl.org>
	<20061018214143.GF19194@spearce.org>
	<7vwt6xxofi.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0610181542160.3962@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 19 00:48:52 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GaKDN-0005ob-7H
	for gcvg-git@gmane.org; Thu, 19 Oct 2006 00:48:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423119AbWJRWsm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Oct 2006 18:48:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423121AbWJRWsm
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Oct 2006 18:48:42 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:61167 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S1423119AbWJRWsl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Oct 2006 18:48:41 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20061018224841.KDZG28934.fed1rmmtao07.cox.net@fed1rmimpo02.cox.net>;
          Wed, 18 Oct 2006 18:48:41 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id byok1V00R1kojtg0000000
	Wed, 18 Oct 2006 18:48:44 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0610181542160.3962@g5.osdl.org> (Linus Torvalds's
	message of "Wed, 18 Oct 2006 15:42:50 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29295>

Linus Torvalds <torvalds@osdl.org> writes:

> On Wed, 18 Oct 2006, Junio C Hamano wrote:
>> 
>> It should not be hard to write another program that generates a
>> packfile like pack-object does but taking a thin pack as its
>> input.  Then receive-pack can drive it instead of
>> unpack-objects.
>
> Give me half an hour. It should be trivial to make "unpack-objects" write 
> the "unpacked" objects into a pack-file instead.

Heh, three people having the same idea that goes in the same
direction at the same time is not necessarily a good sign of
efficient project management...

I am currently fighting with FC5 so please go ahead.
