From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] show_date(): fix relative dates
Date: Sat, 20 Jan 2007 18:48:14 -0800
Message-ID: <7vy7nx5c41.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0701202203260.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<7v3b656vq5.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0701210219400.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 21 03:48:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H8SlD-0004J5-9k
	for gcvg-git@gmane.org; Sun, 21 Jan 2007 03:48:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751154AbXAUCsQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 20 Jan 2007 21:48:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751170AbXAUCsQ
	(ORCPT <rfc822;git-outgoing>); Sat, 20 Jan 2007 21:48:16 -0500
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:38321 "EHLO
	fed1rmmtao07.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751154AbXAUCsP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Jan 2007 21:48:15 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070121024815.SBUW3976.fed1rmmtao07.cox.net@fed1rmimpo01.cox.net>;
          Sat, 20 Jan 2007 21:48:15 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id DenK1W00R1kojtg0000000; Sat, 20 Jan 2007 21:47:20 -0500
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0701210219400.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Sun, 21 Jan 2007 02:34:21 +0100
	(CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37304>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Now I expect the same of relative mode, only that the timezone does not 
> matter for relative mode _at all_.
> ...
> However, I was very surprised when "git log --walk-reflogs 
> --relative-date" showed me "in the future" for my last commits.

Exactly.

You are absolutely right.  I should have done that when I did
the show-branch --reflog workaround to pass 0.
