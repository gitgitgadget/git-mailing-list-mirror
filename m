From: Junio C Hamano <junkio@cox.net>
Subject: Re: [3/4] What's not in 1.5.2 (new topics)
Date: Thu, 17 May 2007 11:49:12 -0700
Message-ID: <7vzm438evr.fsf@assigned-by-dhcp.cox.net>
References: <11793556363795-git-send-email-junkio@cox.net>
	<11793556371774-git-send-email-junkio@cox.net>
	<200705170539.11402.andyparkins@gmail.com>
	<7v4pmcauu3.fsf@assigned-by-dhcp.cox.net>
	<20070517110225.GA3334@steel.home> <20070517124622.GP4489@pasky.or.cz>
	<20070517134649.GA20853@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Petr Baudis <pasky@suse.cz>, Alex Riesen <raa.lkml@gmail.com>,
	Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu May 17 20:49:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hol2P-0006mk-25
	for gcvg-git@gmane.org; Thu, 17 May 2007 20:49:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755575AbXEQStP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 17 May 2007 14:49:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755399AbXEQStP
	(ORCPT <rfc822;git-outgoing>); Thu, 17 May 2007 14:49:15 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:60243 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755575AbXEQStO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 May 2007 14:49:14 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070517184914.NSHY14313.fed1rmmtao101.cox.net@fed1rmimpo02.cox.net>;
          Thu, 17 May 2007 14:49:14 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 0JpC1X00U1kojtg0000000; Thu, 17 May 2007 14:49:14 -0400
In-Reply-To: <20070517134649.GA20853@coredump.intra.peff.net> (Jeff King's
	message of "Thu, 17 May 2007 09:46:49 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47549>

Jeff King <peff@peff.net> writes:

> Instead, why not:
>   1. url location is supplied in configuration as
>      [subproject "kernel/"]
>        url = git://git.kernel.org/pub/linux-2.4.git
>   2. .gitmodules is simply read as a lower-priority version of
>      configuration

That does not support seeking back and forth between appliance
release #1 and release #2 which wants to say they want to bind
two different things at the same kernel/ path, does it?
