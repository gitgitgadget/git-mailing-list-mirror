From: Junio C Hamano <junkio@cox.net>
Subject: Re: Build Failure: GIT-GUI-VARS
Date: Thu, 10 May 2007 19:30:05 -0700
Message-ID: <7v8xbwgkia.fsf@assigned-by-dhcp.cox.net>
References: <FF405582-7769-4A08-87A0-680F8CD165DC@silverinsanity.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Brian Gernhardt <benji@silverinsanity.com>
X-From: git-owner@vger.kernel.org Fri May 11 04:30:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HmKtb-0002Bk-0y
	for gcvg-git@gmane.org; Fri, 11 May 2007 04:30:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757291AbXEKCaJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 10 May 2007 22:30:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757489AbXEKCaI
	(ORCPT <rfc822;git-outgoing>); Thu, 10 May 2007 22:30:08 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:39839 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757291AbXEKCaH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 May 2007 22:30:07 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070511023007.ERKC13903.fed1rmmtao107.cox.net@fed1rmimpo02.cox.net>;
          Thu, 10 May 2007 22:30:07 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id xeW61W00P1kojtg0000000; Thu, 10 May 2007 22:30:07 -0400
In-Reply-To: <FF405582-7769-4A08-87A0-680F8CD165DC@silverinsanity.com> (Brian
	Gernhardt's message of "Thu, 10 May 2007 21:51:14 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46930>

Brian Gernhardt <benji@silverinsanity.com> writes:

> Actually, I can't tell why make is trying to build it in the first
> place.  :-/  gitk-wish is added to OTHER_PROGRAMS inside a NO_TCLTK
> block.

I do not either, and obviously does not reproduce for me.  Time
for you to try "make -d" perhaps?
