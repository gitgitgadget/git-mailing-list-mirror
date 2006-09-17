From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] gitweb fix validating pg (page) parameter
Date: Sun, 17 Sep 2006 14:45:32 -0700
Message-ID: <7v8xki2mmb.fsf@assigned-by-dhcp.cox.net>
References: <20060917115245.GA15658@moooo.ath.cx>
	<7vlkoi2nqr.fsf@assigned-by-dhcp.cox.net>
	<20060917213838.GA12782@moooo.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 17 23:45:39 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GP4SH-00026F-5t
	for gcvg-git@gmane.org; Sun, 17 Sep 2006 23:45:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965127AbWIQVpe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Sep 2006 17:45:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965128AbWIQVpe
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Sep 2006 17:45:34 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:54238 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S965127AbWIQVpd (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Sep 2006 17:45:33 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060917214533.VHIS6077.fed1rmmtao01.cox.net@fed1rmimpo01.cox.net>;
          Sun, 17 Sep 2006 17:45:33 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id PZlL1V00W1kojtg0000000
	Sun, 17 Sep 2006 17:45:21 -0400
To: Matthias Lederhofer <matled@gmx.net>
In-Reply-To: <20060917213838.GA12782@moooo.ath.cx> (Matthias Lederhofer's
	message of "Sun, 17 Sep 2006 23:38:38 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27209>

Matthias Lederhofer <matled@gmx.net> writes:

>> > +	if ($page =~ m/[^0-9]/) {
>...
> The first page seems to have number 0.  After removing the 1 <= $page
> this code should do the same as my patch, apply whatever you think is
> easier to read (I prefer if over unless most of the time).

Ah, I did not notice we call the first page 0; barfing on any
non-digit in the string like you do sounds quite sane.

Thanks.
