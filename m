From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH(resend)] gitweb: Allow configuring the default projects order and add order 'none'
Date: Fri, 06 Apr 2007 17:51:44 -0700
Message-ID: <7vk5wpgg67.fsf@assigned-by-dhcp.cox.net>
References: <11758967042669-git-send-email-frank@lichtenheld.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>,
	Frank Lichtenheld <frank@lichtenheld.de>
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Sat Apr 07 03:28:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HZz9g-0005nT-Ff
	for gcvg-git@gmane.org; Sat, 07 Apr 2007 02:51:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964810AbXDGAvq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 6 Apr 2007 20:51:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964826AbXDGAvq
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Apr 2007 20:51:46 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:49828 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964810AbXDGAvp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Apr 2007 20:51:45 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070407005145.SPUI1606.fed1rmmtao104.cox.net@fed1rmimpo01.cox.net>;
          Fri, 6 Apr 2007 20:51:45 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id k0rj1W00V1kojtg0000000; Fri, 06 Apr 2007 20:51:44 -0400
In-Reply-To: <11758967042669-git-send-email-frank@lichtenheld.de> (Frank
	Lichtenheld's message of "Fri, 6 Apr 2007 23:58:24 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43951>

Both of these two patches from Frank seem sane to me, but I
think I'd ask your Ack before applying, as repo.or.cz is
probably the heaviest user of the 'fork' feature.
