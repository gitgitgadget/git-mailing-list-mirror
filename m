From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Fix git-rebase -i to allow squashing of fast-forwardable commits
Date: Fri, 13 Jul 2007 22:34:01 -0700
Message-ID: <7vejjbmtva.fsf@assigned-by-dhcp.cox.net>
References: <20070712223035.GB30532@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 14 07:34:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I9aGf-0008UL-24
	for gcvg-git@gmane.org; Sat, 14 Jul 2007 07:34:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751695AbXGNFeG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 14 Jul 2007 01:34:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751239AbXGNFeF
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Jul 2007 01:34:05 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:49115 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751259AbXGNFeE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Jul 2007 01:34:04 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070714053403.BMWT1393.fed1rmmtao106.cox.net@fed1rmimpo01.cox.net>;
          Sat, 14 Jul 2007 01:34:03 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id PHa11X0031kojtg0000000; Sat, 14 Jul 2007 01:34:02 -0400
In-Reply-To: <20070712223035.GB30532@steel.home> (Alex Riesen's message of
	"Fri, 13 Jul 2007 00:30:35 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52442>

I think this makes sense.  Thanks for fixing it up.
