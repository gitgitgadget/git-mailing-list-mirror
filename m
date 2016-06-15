From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] fsck --lost-found: write blob's contents, not their SHA-1
Date: Sun, 22 Jul 2007 16:00:49 -0700
Message-ID: <7v4pjwqc0u.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0707222120100.14781@racer.site>
	<7vodi4qfnx.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0707222246220.14781@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jul 23 01:00:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ICkQ2-0001Te-KC
	for gcvg-git@gmane.org; Mon, 23 Jul 2007 01:00:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762037AbXGVXAv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Jul 2007 19:00:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762305AbXGVXAv
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Jul 2007 19:00:51 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:33323 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761864AbXGVXAv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Jul 2007 19:00:51 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070722230051.PSBD1393.fed1rmmtao104.cox.net@fed1rmimpo01.cox.net>;
          Sun, 22 Jul 2007 19:00:51 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id Sn0p1X00A1kojtg0000000; Sun, 22 Jul 2007 19:00:50 -0400
In-Reply-To: <Pine.LNX.4.64.0707222246220.14781@racer.site> (Johannes
	Schindelin's message of "Sun, 22 Jul 2007 22:52:28 +0100 (BST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53363>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> But what the whole thing boils down to: After finding dangling objects, 
> you are much more likely using git tools on non-blobs than on blobs, and 
> vice versa.

Ok, color me converted.
