From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] sha1_name(): accept ':directory/' to get at the cache_tree
Date: Thu, 21 Dec 2006 20:29:08 -0800
Message-ID: <7vzm9g7duz.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0612220318320.19693@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, junkio@cox.net
X-From: git-owner@vger.kernel.org Fri Dec 22 05:29:27 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1Gxc23-0001JA-P6
	for gcvg-git@gmane.org; Fri, 22 Dec 2006 05:29:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945929AbWLVE3M (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Dec 2006 23:29:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945928AbWLVE3M
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Dec 2006 23:29:12 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:62376 "EHLO
	fed1rmmtao11.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1945929AbWLVE3L (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Dec 2006 23:29:11 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20061222042908.FMHE25875.fed1rmmtao11.cox.net@fed1rmimpo01.cox.net>;
          Thu, 21 Dec 2006 23:29:08 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 1gUS1W0081kojtg0000000; Thu, 21 Dec 2006 23:28:26 -0500
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0612220318320.19693@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Fri, 22 Dec 2006 03:19:21 +0100
	(CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35127>

(1) Why is this needed?

(2) What does this do when the index is unmerged?
