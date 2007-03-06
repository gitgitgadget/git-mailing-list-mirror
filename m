From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] gitweb: Change to use explicitly function call cgi->escapHTML()
Date: Tue, 6 Mar 2007 05:41:27 -0500
Message-ID: <20070306104127.GA13096@coredump.intra.peff.net>
References: <20070306093917.GA1761@coredump.intra.peff.net> <989B956029373F45A0B8AF02970818902DAA12@zch01exm26.fsl.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>, Junio C Hamano <junkio@cox.net>,
	git@vger.kernel.org
To: Li Yang-r58472 <LeoLi@freescale.com>
X-From: git-owner@vger.kernel.org Tue Mar 06 11:41:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HOX6r-0007b9-67
	for gcvg-git@gmane.org; Tue, 06 Mar 2007 11:41:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752677AbXCFKlb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Mar 2007 05:41:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934055AbXCFKla
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Mar 2007 05:41:30 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4029 "HELO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752939AbXCFKla (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Mar 2007 05:41:30 -0500
Received: (qmail 11718 invoked from network); 6 Mar 2007 05:41:47 -0500
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by 66-23-211-5.clients.speedfactory.net with SMTP; 6 Mar 2007 05:41:47 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 06 Mar 2007 05:41:27 -0500
Content-Disposition: inline
In-Reply-To: <989B956029373F45A0B8AF02970818902DAA12@zch01exm26.fsl.freescale.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41568>

On Tue, Mar 06, 2007 at 06:31:23PM +0800, Li Yang-r58472 wrote:

> Yes, it also fixed the problem.  I'm not very familiar with perl.  Will
> CGI::autoEscape(1) change CGI action for other users of CGI module on
> the system?  If so, maybe it will break other CGIs.

I don't know enough about mod_perl to say, but if all scripts share the
package globals from CGI, then yes, you're affecting all other scripts.
Without mod_perl, obviously you have no impact.

If it is the case, then your original fix is probably better.

-Peff
