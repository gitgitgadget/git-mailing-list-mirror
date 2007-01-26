From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] diff --check: use colour
Date: Thu, 25 Jan 2007 16:17:45 -0800
Message-ID: <7vejpi63py.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0701241505260.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jan 26 01:17:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HAEms-0002iJ-CB
	for gcvg-git@gmane.org; Fri, 26 Jan 2007 01:17:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030669AbXAZARr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 25 Jan 2007 19:17:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030670AbXAZARr
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Jan 2007 19:17:47 -0500
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:38711 "EHLO
	fed1rmmtao05.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030669AbXAZARq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Jan 2007 19:17:46 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070126001746.OYLP15640.fed1rmmtao05.cox.net@fed1rmimpo01.cox.net>;
          Thu, 25 Jan 2007 19:17:46 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id FcGo1W00p1kojtg0000000; Thu, 25 Jan 2007 19:16:49 -0500
In-Reply-To: <Pine.LNX.4.63.0701241505260.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Wed, 24 Jan 2007 15:05:48 +0100
	(CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37788>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> 	Is it possible that diff_get_color() _never_ returns NULL?

I think so, although it may often return a pointer that points
at NUL (e.g under --no-color option).
