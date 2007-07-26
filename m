From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/5] Clean up work-tree handling
Date: Thu, 26 Jul 2007 00:06:49 -0700
Message-ID: <7vmyxj8wza.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0707260729150.14781@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jul 26 09:06:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IDxR0-0003Mc-6M
	for gcvg-git@gmane.org; Thu, 26 Jul 2007 09:06:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761651AbXGZHGv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 26 Jul 2007 03:06:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760978AbXGZHGv
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Jul 2007 03:06:51 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:63790 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758679AbXGZHGu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jul 2007 03:06:50 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070726070650.GXKT1393.fed1rmmtao106.cox.net@fed1rmimpo01.cox.net>;
          Thu, 26 Jul 2007 03:06:50 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id U76p1X0051kojtg0000000; Thu, 26 Jul 2007 03:06:49 -0400
In-Reply-To: <Pine.LNX.4.64.0707260729150.14781@racer.site> (Johannes
	Schindelin's message of "Thu, 26 Jul 2007 07:30:09 +0100 (BST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53795>

This seems to break t1020 and t1500, probably among other
things.
