From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] git-add: allow path limiting with -u
Date: Sat, 12 May 2007 00:13:42 -0700
Message-ID: <7vejlm5xax.fsf@assigned-by-dhcp.cox.net>
References: <20070512064159.GA7471@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, jnareb@gmail.com, cworth@cworth.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat May 12 09:13:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HmlnY-0007TD-L0
	for gcvg-git@gmane.org; Sat, 12 May 2007 09:13:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756020AbXELHNo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 12 May 2007 03:13:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756444AbXELHNo
	(ORCPT <rfc822;git-outgoing>); Sat, 12 May 2007 03:13:44 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:37934 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756020AbXELHNo (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 May 2007 03:13:44 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070512071344.LMTC24310.fed1rmmtao104.cox.net@fed1rmimpo01.cox.net>;
          Sat, 12 May 2007 03:13:44 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id y7Di1W0041kojtg0000000; Sat, 12 May 2007 03:13:43 -0400
In-Reply-To: <20070512064159.GA7471@coredump.intra.peff.net> (Jeff King's
	message of "Sat, 12 May 2007 02:42:00 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47023>

Jeff King <peff@peff.net> writes:

> Rather than updating all working tree paths, we limit
> ourselves to paths listed on the command line.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> This turned out to be quite easy to implement. Patch is slightly larger
> than necessary due to removing _all_ from the variable names, but I
> think that better expresses the new functionality.
>
> I'm not sure that the documentation needs updated at all; I had just
> assumed after reading it that 'git-add -u foo' would DWIM.

Wonderful, and I agree it should be almost trivial once you
understand how diff works.  Will take a look.
