From: Junio C Hamano <junkio@cox.net>
Subject: Re: Submodule object store
Date: Mon, 26 Mar 2007 17:29:05 -0700
Message-ID: <7vps6vttpq.fsf@assigned-by-dhcp.cox.net>
References: <1174825838.12540.5.camel@localhost>
	<1174930688.5662.20.camel@localhost>
	<20070326183523.GG22773@admingilde.org>
	<200703262133.44520.Josef.Weidendorfer@gmx.de>
	<20070326220302.GH22773@admingilde.org>
	<7vfy7rvct2.fsf@assigned-by-dhcp.cox.net>
	<20070326231637.GJ22773@admingilde.org>
	<7vy7ljtwir.fsf@assigned-by-dhcp.cox.net>
	<20070326233603.GL22773@admingilde.org>
	<Pine.LNX.4.63.0703261515330.14387@qynat.qvtvafvgr.pbz>
	<20070326235527.GM22773@admingilde.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Lang <david.lang@digitalinsight.com>,
	Josef Weidendorfer <Josef.Weidendorfer@gmx.de>,
	Eric Lesh <eclesh@ucla.edu>,
	Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org
To: Martin Waitz <tali@admingilde.org>
X-From: git-owner@vger.kernel.org Tue Mar 27 02:29:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HVzYm-0003p1-Cz
	for gcvg-git@gmane.org; Tue, 27 Mar 2007 02:29:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750759AbXC0A3J (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Mar 2007 20:29:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751466AbXC0A3J
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Mar 2007 20:29:09 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:42461 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750759AbXC0A3H (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Mar 2007 20:29:07 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070327002906.TBLF321.fed1rmmtao107.cox.net@fed1rmimpo01.cox.net>;
          Mon, 26 Mar 2007 20:29:06 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id fcV41W00f1kojtg0000000; Mon, 26 Mar 2007 20:29:05 -0400
In-Reply-To: <20070326235527.GM22773@admingilde.org> (Martin Waitz's message
	of "Tue, 27 Mar 2007 01:55:27 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43217>

Martin Waitz <tali@admingilde.org> writes:

> The separated object store also helps reduce the memory requirement for
> large pushs/pulls.

That's a total bull.  The size of push/pull only depends on how
you separate set of refs (which affects the traversal hence
affects the set of objects to be exchanged).
