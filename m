From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] get_tree_entry: map blank requested entry to tree root
Date: Tue, 09 Jan 2007 15:48:33 -0800
Message-ID: <7vk5zviwxa.fsf@assigned-by-dhcp.cox.net>
References: <20070109161147.GA9313@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 10 00:48:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H4Qhp-0006uR-FY
	for gcvg-git@gmane.org; Wed, 10 Jan 2007 00:48:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932563AbXAIXsf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 9 Jan 2007 18:48:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932562AbXAIXse
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Jan 2007 18:48:34 -0500
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:49998 "EHLO
	fed1rmmtao01.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932563AbXAIXse (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jan 2007 18:48:34 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070109234833.QVVN9173.fed1rmmtao01.cox.net@fed1rmimpo01.cox.net>;
          Tue, 9 Jan 2007 18:48:33 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 9Bnj1W00A1kojtg0000000; Tue, 09 Jan 2007 18:47:43 -0500
To: Jeff King <peff@peff.net>
In-Reply-To: <20070109161147.GA9313@coredump.intra.peff.net> (Jeff King's
	message of "Tue, 9 Jan 2007 11:11:47 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36430>

Makes sense, although I somewhat worry about changing the
behaviour and potentially breaking the expectation of callers
of get_tree_entry() other than "git show".
