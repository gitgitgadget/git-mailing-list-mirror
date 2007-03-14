From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 2/5] diff --quiet
Date: Wed, 14 Mar 2007 16:37:25 -0700
Message-ID: <7vlkhz5rd6.fsf@assigned-by-dhcp.cox.net>
References: <7vwt1j8z0e.fsf@assigned-by-dhcp.cox.net>
	<7vodmv7bza.fsf@assigned-by-dhcp.cox.net>
	<81b0412b0703141533q4e71e67aqaa83de45fa9e3988@mail.gmail.com>
	<81b0412b0703141554r524346d0kf73a5d43b49ed99a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Junio C Hamano" <junkio@cox.net>, git@vger.kernel.org
To: "Alex Riesen" <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 15 00:37:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HRd29-0003Sn-6Z
	for gcvg-git@gmane.org; Thu, 15 Mar 2007 00:37:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964826AbXCNXh0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Mar 2007 19:37:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964831AbXCNXh0
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Mar 2007 19:37:26 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:40066 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964826AbXCNXh0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Mar 2007 19:37:26 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070314233727.NCZW2807.fed1rmmtao106.cox.net@fed1rmimpo02.cox.net>;
          Wed, 14 Mar 2007 19:37:27 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id andR1W00G1kojtg0000000; Wed, 14 Mar 2007 19:37:25 -0400
In-Reply-To: <81b0412b0703141554r524346d0kf73a5d43b49ed99a@mail.gmail.com>
	(Alex Riesen's message of "Wed, 14 Mar 2007 23:54:45 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42251>

"Alex Riesen" <raa.lkml@gmail.com> writes:

> Actually, I find it a bit strange to leave the output silent,
> if --quiet is turned off. For all the user sees, it is still quiet
> and exit-coded

For that exact reason, for all the user cares, it is better to
leave the output turned off and result given back with exit
status.  --quiet is really for scripted use, in other words.

I wonder if we should perhaps turn off the PAGER when --exit-code
or --quiet is given.
