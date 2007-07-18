From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] unpack-trees.c: assume submodules are clean during check-out
Date: Wed, 18 Jul 2007 00:29:52 -0700
Message-ID: <7vy7he6ufj.fsf@assigned-by-dhcp.cox.net>
References: <20070717182828.GA4583MdfPADPa@greensroom.kotnet.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Sven Verdoolaege <skimo@kotnet.org>
X-From: git-owner@vger.kernel.org Wed Jul 18 09:29:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IB3yu-0000dV-Jh
	for gcvg-git@gmane.org; Wed, 18 Jul 2007 09:29:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752479AbXGRH3y (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Jul 2007 03:29:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752422AbXGRH3y
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Jul 2007 03:29:54 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:65489 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752384AbXGRH3x (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jul 2007 03:29:53 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070718072953.UDCW1358.fed1rmmtao107.cox.net@fed1rmimpo02.cox.net>;
          Wed, 18 Jul 2007 03:29:53 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id QvVs1X0061kojtg0000000; Wed, 18 Jul 2007 03:29:52 -0400
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52838>

Passing of ce instead of path in the unpack-trees callchain
looks like the right thing to do.  Good job.

Thanks.
