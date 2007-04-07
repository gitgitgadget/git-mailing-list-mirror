From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Makefile: iconv() on Darwin has the old interface
Date: Fri, 06 Apr 2007 17:31:28 -0700
Message-ID: <7v1wixhvof.fsf@assigned-by-dhcp.cox.net>
References: <20070406234917.GK3854@regex.yaph.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: arjen@yaph.org (Arjen Laarhoven)
X-From: git-owner@vger.kernel.org Sat Apr 07 03:08:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HZyq5-0002FU-SR
	for gcvg-git@gmane.org; Sat, 07 Apr 2007 02:31:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933584AbXDGAbb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 6 Apr 2007 20:31:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933603AbXDGAbb
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Apr 2007 20:31:31 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:41674 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933584AbXDGAba (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Apr 2007 20:31:30 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070407003129.HLZP373.fed1rmmtao106.cox.net@fed1rmimpo01.cox.net>;
          Fri, 6 Apr 2007 20:31:29 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id k0XU1W00R1kojtg0000000; Fri, 06 Apr 2007 20:31:29 -0400
In-Reply-To: <20070406234917.GK3854@regex.yaph.org> (Arjen Laarhoven's message
	of "Sat, 7 Apr 2007 01:49:17 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43948>

This patch either goes to 'maint' if everybody on Darwin needs
to say OLD_ICONV, or not applied at all as-is if it is dependent
on which variant of Darwin you are talking about.

Anybody else on Darwin around?
