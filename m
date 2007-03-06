From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] gitweb: Change to use explicitly function call cgi->escapHTML()
Date: Tue, 6 Mar 2007 06:01:56 -0500
Message-ID: <20070306110156.GA13380@coredump.intra.peff.net>
References: <20070306093917.GA1761@coredump.intra.peff.net> <989B956029373F45A0B8AF02970818902DAA12@zch01exm26.fsl.freescale.net> <20070306104127.GA13096@coredump.intra.peff.net> <7vveheprsc.fsf@assigned-by-dhcp.cox.net> <20070306105629.GA13285@coredump.intra.peff.net> <7vps7mprj6.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Li Yang-r58472 <LeoLi@freescale.com>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Mar 06 12:02:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HOXQe-0000H3-IQ
	for gcvg-git@gmane.org; Tue, 06 Mar 2007 12:02:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932184AbXCFLB7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Mar 2007 06:01:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934075AbXCFLB7
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Mar 2007 06:01:59 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1711 "HELO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932184AbXCFLB6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Mar 2007 06:01:58 -0500
Received: (qmail 12059 invoked from network); 6 Mar 2007 06:02:16 -0500
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by 66-23-211-5.clients.speedfactory.net with SMTP; 6 Mar 2007 06:02:16 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 06 Mar 2007 06:01:56 -0500
Content-Disposition: inline
In-Reply-To: <7vps7mprj6.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41574>

On Tue, Mar 06, 2007 at 02:58:37AM -0800, Junio C Hamano wrote:

> Sorry, what I meant to say was on top of Li's patch.

Ah, I understand your point now. Yes, if other mod_perl CGIs can impact
the value, then we should definitely set it explicitly, as per your
patch (and we should use Li's patch for safety, then, not mine).

-Peff
