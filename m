From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 0/6] packed deltas with offset to base instead of sha1
Date: Wed, 20 Sep 2006 22:30:50 -0700
Message-ID: <7v4pv1eqgl.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0609202350450.2627@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Sep 21 07:30:57 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GQH9D-0003EJ-MF
	for gcvg-git@gmane.org; Thu, 21 Sep 2006 07:30:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751238AbWIUFax (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Sep 2006 01:30:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751239AbWIUFax
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Sep 2006 01:30:53 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:36295 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S1751238AbWIUFaw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Sep 2006 01:30:52 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060921053051.DSBZ21457.fed1rmmtao07.cox.net@fed1rmimpo01.cox.net>;
          Thu, 21 Sep 2006 01:30:51 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id QtWd1V0051kojtg0000000
	Thu, 21 Sep 2006 01:30:37 -0400
To: Nicolas Pitre <nico@cam.org>
In-Reply-To: <Pine.LNX.4.64.0609202350450.2627@xanadu.home> (Nicolas Pitre's
	message of "Thu, 21 Sep 2006 00:04:14 -0400 (EDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27452>

Nicolas Pitre <nico@cam.org> writes:

> The following patches are the result of my work to allow deltas to have
> their base specified as an offset within a pack instead of a 20 byte 
> sha1.
>
> This turned to be somewhat more involved than I originally expected. 
> Given the relative pack reduction resulting from that, I might have 
> decided against doing this if I had known beforehand how much work was 
> needed.
>
> But since it is done now I think it is worth merging nevertheless.  Some 
> parts are still pure code cleanups anyway.
>
> Overall the larger projects are likely to benefit more as they have a 
> larger proportion of deltas.  On the historic Linux archive the pack 
> reduction is about 5%.

Nice, although I suspect this would make it a bit more involved
to merge a few outstanding stuff.

Will take a look when I'm done looking at Linus's packed-ref
stuff.
