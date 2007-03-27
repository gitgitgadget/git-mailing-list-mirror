From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-send-email and aliases
Date: Tue, 27 Mar 2007 03:59:19 -0700
Message-ID: <7vlkhjne9k.fsf@assigned-by-dhcp.cox.net>
References: <38b2ab8a0703260239j3f3f0be2teee70fc502f6f7c1@mail.gmail.com>
	<7vwt14wd38.fsf@assigned-by-dhcp.cox.net>
	<38b2ab8a0703270238n655bdee1kac227a6675261210@mail.gmail.com>
	<7vircnou7i.fsf@assigned-by-dhcp.cox.net>
	<20070327104623.GA26796@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Francis Moreau <francis.moro@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Mar 27 12:59:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HW9Oe-00081P-48
	for gcvg-git@gmane.org; Tue, 27 Mar 2007 12:59:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751076AbXC0K7V (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Mar 2007 06:59:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753791AbXC0K7V
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Mar 2007 06:59:21 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:47882 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751076AbXC0K7U (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Mar 2007 06:59:20 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070327105920.JEZH1606.fed1rmmtao104.cox.net@fed1rmimpo02.cox.net>;
          Tue, 27 Mar 2007 06:59:20 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id fmzK1W00G1kojtg0000000; Tue, 27 Mar 2007 06:59:20 -0400
In-Reply-To: <20070327104623.GA26796@sigill.intra.peff.net> (Jeff King's
	message of "Tue, 27 Mar 2007 06:46:23 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43260>

Jeff King <peff@peff.net> writes:

> Might it not be easier to simply add a GIT_NOALIAS variable, and set it
> at the top of all git programs?

It might be easier but I do not think that is useful.  When
git-commit runs the $EDITOR for the commit log message, I think
people would expect (if you are using vi) "!!git log" to honor
their alias.
