From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] rebase -i: fix overzealous output redirection
Date: Wed, 25 Jul 2007 23:38:40 -0700
Message-ID: <7vejivacun.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0707260735150.14781@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jul 26 08:38:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IDwzl-0000hz-7s
	for gcvg-git@gmane.org; Thu, 26 Jul 2007 08:38:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756674AbXGZGim (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 26 Jul 2007 02:38:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756499AbXGZGim
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Jul 2007 02:38:42 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:35069 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754671AbXGZGim (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jul 2007 02:38:42 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070726063841.WSCS1358.fed1rmmtao103.cox.net@fed1rmimpo01.cox.net>;
          Thu, 26 Jul 2007 02:38:41 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id U6eg1X00L1kojtg0000000; Thu, 26 Jul 2007 02:38:41 -0400
In-Reply-To: <Pine.LNX.4.64.0707260735150.14781@racer.site> (Johannes
	Schindelin's message of "Thu, 26 Jul 2007 07:35:51 +0100 (BST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53784>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> When squashing, you no longer saw what the editor had to say to you
> after commit 'Shut "git rebase -i" up when no --verbose was given'
> (if you used a console based editor, at least).
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
> 	This bit me real hard when cleaning up the work-tree patch
> 	series.

Heh, good catch.

At least you are eating your own dog food, which is a very
assuring thing before the feature release.  Thanks.
