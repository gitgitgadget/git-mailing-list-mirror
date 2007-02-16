From: Junio C Hamano <junkio@cox.net>
Subject: Re: Error.pm: add configuration variable in Makefile
Date: Fri, 16 Feb 2007 13:18:42 -0800
Message-ID: <7vzm7d3iod.fsf@assigned-by-dhcp.cox.net>
References: <200702162200.15241.barra_cuda@katamail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael <barra_cuda@katamail.com>
X-From: git-owner@vger.kernel.org Fri Feb 16 22:18:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HIATj-0006LT-BA
	for gcvg-git@gmane.org; Fri, 16 Feb 2007 22:18:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946257AbXBPVSo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Feb 2007 16:18:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946258AbXBPVSo
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Feb 2007 16:18:44 -0500
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:34479 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1946257AbXBPVSn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Feb 2007 16:18:43 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070216211843.EJAT22948.fed1rmmtao104.cox.net@fed1rmimpo02.cox.net>;
          Fri, 16 Feb 2007 16:18:43 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id QMJj1W0031kojtg0000000; Fri, 16 Feb 2007 16:18:43 -0500
In-Reply-To: <200702162200.15241.barra_cuda@katamail.com>
	(barra_cuda@katamail.com's message of "Fri, 16 Feb 2007 22:00:15
	+0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39951>

Michael <barra_cuda@katamail.com> writes:

> When compiling, we check in perl/Makefile.PL if Error.pm is available. If not, 
> we use our Error.pm instead. So, after a "make install" the system does have 
> an Error.pm. This is fine, unless we are used to create an 
> rpm/deb/whatever-it-is by ourselves and install it with the system's package 
> manager.

The private copy is only to help people who build from the
source _and_ are lazy enough to install Error.pm from more
official sources (either CPAN or officially pacakged ones).

My preference is to never allow out private copy to leak into
binary packages, and have our binary packages _always_ depend on
the officially packaged ones.
