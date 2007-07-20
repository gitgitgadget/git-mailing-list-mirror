From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Update listingblock monospace fix to support all docbook versions
Date: Fri, 20 Jul 2007 09:42:47 -0700
Message-ID: <7vfy3jxbzs.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0707200806540.20056@beast.quantumfyre.co.uk>
	<20070720121153.23352.73276.julian@quantumfyre.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Fredrik Tolf <fredrik@dolda2000.com>, git@vger.kernel.org
To: Julian Phillips <julian@quantumfyre.co.uk>
X-From: git-owner@vger.kernel.org Fri Jul 20 18:48:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IBvel-00052C-Oo
	for gcvg-git@gmane.org; Fri, 20 Jul 2007 18:48:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764694AbXGTQmu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Jul 2007 12:42:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S941383AbXGTQmu
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Jul 2007 12:42:50 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:53353 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1764155AbXGTQmt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jul 2007 12:42:49 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070720164249.LWRQ1399.fed1rmmtao105.cox.net@fed1rmimpo02.cox.net>;
          Fri, 20 Jul 2007 12:42:49 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id Rsin1X0131kojtg0000000; Fri, 20 Jul 2007 12:42:48 -0400
In-Reply-To: <20070720121153.23352.73276.julian@quantumfyre.co.uk> (Julian
	Phillips's message of "Fri, 20 Jul 2007 13:06:21 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53099>

Julian Phillips <julian@quantumfyre.co.uk> writes:

> So this uses the string '#GIT#SET#MAN#FONT#', and then changes that to
> .ft using a post-process perl script.
>
> Not pretty, but it works.

Owwwww... pain.

Unless anybody else has better fix I'd say we go with this.

Thanks.
