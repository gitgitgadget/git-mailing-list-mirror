From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] add receive.denyNonFastforwards config variable
Date: Thu, 21 Sep 2006 02:25:39 -0700
Message-ID: <7vd59pa7vw.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0609210027430.19042@wbgn013.biozentrum.uni-wuerzburg.de>
	<7vfyemf9ah.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0609210107140.19042@wbgn013.biozentrum.uni-wuerzburg.de>
	<7vlkoeds82.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0609210211570.19042@wbgn013.biozentrum.uni-wuerzburg.de>
	<20060921055252.GA29479@coredump.intra.peff.net>
	<7vbqp9d8j2.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0609211103130.19042@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 21 11:26:13 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GQKoW-0004hU-Pb
	for gcvg-git@gmane.org; Thu, 21 Sep 2006 11:25:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751079AbWIUJZm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Sep 2006 05:25:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751080AbWIUJZl
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Sep 2006 05:25:41 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:19625 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S1751079AbWIUJZl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Sep 2006 05:25:41 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060921092540.XBQQ3535.fed1rmmtao09.cox.net@fed1rmimpo01.cox.net>;
          Thu, 21 Sep 2006 05:25:40 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id QxRS1V0021kojtg0000000
	Thu, 21 Sep 2006 05:25:26 -0400
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0609211103130.19042@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Thu, 21 Sep 2006 11:08:02 +0200
	(CEST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27472>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> Jeff King <peff@peff.net> writes:
>> 
>> >>     X - a - b - c - Y
>> >>   /           /
>> >> o - d - e - f
>
> And no, I am not aware of any such example.
>
> Probably because X would mark all ancestors (_including_ all other 
> possible merge bases) as uninteresting.

True.  Paint me convinced, too.
