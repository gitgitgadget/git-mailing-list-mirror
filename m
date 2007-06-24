From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH][RESEND] git-submodule: provide easy way of adding new submodules
Date: Sun, 24 Jun 2007 10:50:48 -0700
Message-ID: <7vir9dtf5z.fsf@assigned-by-dhcp.cox.net>
References: <20070621095300.GA27071MdfPADPa@greensroom.kotnet.org>
	<7v8xaa4f5g.fsf@assigned-by-dhcp.pobox.com>
	<20070624151750.GA997MdfPADPa@greensroom.kotnet.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Lars Hjemli <hjemli@gmail.com>
To: skimo@liacs.nl
X-From: git-owner@vger.kernel.org Sun Jun 24 19:50:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I2WEd-0002jz-Ld
	for gcvg-git@gmane.org; Sun, 24 Jun 2007 19:50:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751844AbXFXRuu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 24 Jun 2007 13:50:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751758AbXFXRuu
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Jun 2007 13:50:50 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:62686 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751477AbXFXRut (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Jun 2007 13:50:49 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070624175048.EHNU3993.fed1rmmtao106.cox.net@fed1rmimpo02.cox.net>;
          Sun, 24 Jun 2007 13:50:48 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id FVqo1X00L1kojtg0000000; Sun, 24 Jun 2007 13:50:49 -0400
In-Reply-To: <20070624151750.GA997MdfPADPa@greensroom.kotnet.org> (Sven
	Verdoolaege's message of "Sun, 24 Jun 2007 17:17:50 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50808>

Sven Verdoolaege <skimo@kotnet.org> writes:

> They're different because submodule update (which also calls module_clone)
> is performed on a module that already exists in the repo and
> was therefore checked out by git as an empty directory.  If you
> add a new submodule, then there is no reason for the subdirectory
> to exist already.

Ah, you are absolutely right.  Thanks for the clarification.

By the way, when I have to say "thanks for the clarification", I
think it is an indication that the relevant parts of the code
need a bit of commenting ;-).
