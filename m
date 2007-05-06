From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] connect: display connection progress
Date: Sun, 06 May 2007 13:41:31 -0700
Message-ID: <7vhcqpbs78.fsf@assigned-by-dhcp.cox.net>
References: <20070506195230.GA30339@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Michael S. Tsirkin" <mst@dev.mellanox.co.il>
X-From: git-owner@vger.kernel.org Sun May 06 22:41:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HknXz-0002R1-U0
	for gcvg-git@gmane.org; Sun, 06 May 2007 22:41:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753301AbXEFUld (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 6 May 2007 16:41:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753376AbXEFUld
	(ORCPT <rfc822;git-outgoing>); Sun, 6 May 2007 16:41:33 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:39962 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753301AbXEFUlc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 May 2007 16:41:32 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070506204132.ZCPM6556.fed1rmmtao106.cox.net@fed1rmimpo01.cox.net>;
          Sun, 6 May 2007 16:41:32 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id vwhX1W0031kojtg0000000; Sun, 06 May 2007 16:41:31 -0400
In-Reply-To: <20070506195230.GA30339@mellanox.co.il> (Michael S. Tsirkin's
	message of "Sun, 6 May 2007 22:52:30 +0300")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46373>

"Michael S. Tsirkin" <mst@dev.mellanox.co.il> writes:

> Make git notify the user about host resolution/connection attempts.  This
> is useful both as a progress indicator on slow links, and helps reassure the
> user there are no DNS/firewall problems.
>
> Signed-off-by: Michael S. Tsirkin <mst@dev.mellanox.co.il>
>
> ---
>
> I find the following useful.
> This currently only covers native git protocol. I expect it would
> be easy to extend this to other protocols, if there's interest.
> Opinions?

I think giving this kind of feedback makes a lot of sense, from
both the "assurance" point of view and also debuggability.

But please do this only under verbose, or squelch it if "quiet"
is asked.
