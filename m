From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Force listingblocks to be monospaced in manpages
Date: Fri, 20 Jul 2007 00:00:57 -0700
Message-ID: <7v3azj1rva.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0707190157430.1964@beast.quantumfyre.co.uk>
	<20070719014852.4573.65336.julian@quantumfyre.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Fredrik Tolf <fredrik@dolda2000.com>, git@vger.kernel.org
To: Julian Phillips <julian@quantumfyre.co.uk>
X-From: git-owner@vger.kernel.org Fri Jul 20 09:01:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IBmUK-00072g-Ij
	for gcvg-git@gmane.org; Fri, 20 Jul 2007 09:01:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755441AbXGTHA7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Jul 2007 03:00:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754280AbXGTHA7
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Jul 2007 03:00:59 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:62407 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752614AbXGTHA6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jul 2007 03:00:58 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070720070059.IIGO1393.fed1rmmtao106.cox.net@fed1rmimpo01.cox.net>;
          Fri, 20 Jul 2007 03:00:59 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id Rj0x1X00U1kojtg0000000; Fri, 20 Jul 2007 03:00:58 -0400
In-Reply-To: <20070719014852.4573.65336.julian@quantumfyre.co.uk> (Julian
	Phillips's message of "Wed, 18 Jul 2007 22:33:57 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53063>

Julian Phillips <julian@quantumfyre.co.uk> writes:

> In order for these roff commands to get through to the manpage they
> have to be element encoded to prevent quoting.  In particular with
> docbook xsl 1.72.0 and newer we have to use U+2302 instead of . to
> prevent the roff command being escaped.  We also add a small perl
> script for docbook < 1.72.0.

This does not work at all for docbook 1.71.  I get "^<TAB>ft C"
as output from xmlto.
