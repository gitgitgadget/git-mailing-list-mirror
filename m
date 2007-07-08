From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Fix "apply --reverse" with regard to whitespace
Date: Sun, 08 Jul 2007 02:02:19 -0700
Message-ID: <7vd4z32rqc.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0707062155170.6977@iabervon.org>
	<Pine.LNX.4.64.0707071849430.4093@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org,
	gitster@pobox.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Jul 08 11:02:25 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I7Seu-00016V-DW
	for gcvg-git@gmane.org; Sun, 08 Jul 2007 11:02:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752790AbXGHJCW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 8 Jul 2007 05:02:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752669AbXGHJCW
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Jul 2007 05:02:22 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:42022 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752472AbXGHJCV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Jul 2007 05:02:21 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070708090221.TDBX1204.fed1rmmtao102.cox.net@fed1rmimpo02.cox.net>;
          Sun, 8 Jul 2007 05:02:21 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id Lx2L1X0021kojtg0000000; Sun, 08 Jul 2007 05:02:21 -0400
In-Reply-To: <Pine.LNX.4.64.0707071849430.4093@racer.site> (Johannes
	Schindelin's message of "Sat, 7 Jul 2007 18:50:39 +0100 (BST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51869>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> "git apply" used to take check the whitespace in the wrong
> direction.
>
> Noticed by Daniel Barkalow.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>
> 	On Fri, 6 Jul 2007, Daniel Barkalow wrote:
>
> 	> If you apply in reverse a patch which adds junk (e.g., terminal
> 	> whitespace), it complains about the junk you're adding, even 
> 	> though (since it's in reverse) you're actually removing that 
> 	> junk.
>
> 	This fixes it.

Hmm.  Does this cover the "trailing blank lines removal" as
well?
