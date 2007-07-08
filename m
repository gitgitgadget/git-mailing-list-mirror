From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] gitweb: snapshot cleanups & support for offering multiple formats
Date: Sun, 08 Jul 2007 02:06:09 -0700
Message-ID: <7v8x9r2rjy.fsf@assigned-by-dhcp.cox.net>
References: <1183053733.6108.0.camel@mattlaptop2>
	<7vir8w6inf.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Matt McCutchen <hashproduct@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 08 11:06:44 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I7Sj0-0001ah-EN
	for gcvg-git@gmane.org; Sun, 08 Jul 2007 11:06:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753246AbXGHJGM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 8 Jul 2007 05:06:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753228AbXGHJGM
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Jul 2007 05:06:12 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:51859 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753155AbXGHJGK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Jul 2007 05:06:10 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070708090610.DCVJ1257.fed1rmmtao104.cox.net@fed1rmimpo02.cox.net>;
          Sun, 8 Jul 2007 05:06:10 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id Lx691X0061kojtg0000000; Sun, 08 Jul 2007 05:06:10 -0400
In-Reply-To: <7vir8w6inf.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Sat, 07 Jul 2007 13:52:36 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51870>

Junio C Hamano <gitster@pobox.com> writes:

> This however will break people's existing gitweb configuration,
> so if we were to do this it should be post 1.5.3, I would say.

We have swallowed some changes that breaks details of user
experience so far, and compared to one of them, the
incompatibility this brings in is much more benign.  We haven't
declared -rc1 when the command set and features for the next
release is cast in stone.

I am tempted to change my mind and am inclined to apply this.
