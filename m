From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Problem with Linus's git repository?
Date: Wed, 27 Jun 2007 21:19:44 -0700
Message-ID: <7v6458pv6n.fsf@assigned-by-dhcp.pobox.com>
References: <f5r8q5$pbr$1@sea.gmane.org>
	<alpine.LFD.0.98.0706260935440.8675@woody.linux-foundation.org>
	<Pine.LNX.4.64.0706270636140.7038@x2.ybpnyarg>
	<alpine.LFD.0.98.0706270932040.8675@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: walt <wa1ter@myrealbox.com>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Jun 28 06:19:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I3lTy-0001BS-9H
	for gcvg-git@gmane.org; Thu, 28 Jun 2007 06:19:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752310AbXF1ETq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Jun 2007 00:19:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752445AbXF1ETq
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Jun 2007 00:19:46 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:43395 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751752AbXF1ETp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jun 2007 00:19:45 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070628041945.SWTQ1257.fed1rmmtao104.cox.net@fed1rmimpo02.cox.net>;
          Thu, 28 Jun 2007 00:19:45 -0400
Received: from assigned-by-dhcp.pobox.com ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id GsKk1X00Q1kojtg0000000; Thu, 28 Jun 2007 00:19:45 -0400
In-Reply-To: <alpine.LFD.0.98.0706270932040.8675@woody.linux-foundation.org>
	(Linus Torvalds's message of "Wed, 27 Jun 2007 09:34:09 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51077>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> What is your git version? The _real_ fix probably is to just upgrade. Are 
> you using that broken(*) Debian git package by any chance?
>
> 		Linus
>
> (*) By broken I mean "stable cannot be bothered to upgrade packages to 
> modern versions, and is still on some ancient 1.4-based git version"

Well, although git 1.4 is ancient in git timescale, you can keep
your repository friendly with older versions of git and 1.4
certainly is not too old for that.  In other words, newer git
lets you choose to make your repository unreadable by 1.4, and
you chose to do so, perhaps for a good reason.

Should we call git 1.5 "backward incompatible" with 1.4, because
it allows you (or anybody) to make that choice?  I dunno.
