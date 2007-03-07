From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] gitweb: Change to use explicitly function call cgi->escapHTML()
Date: Tue, 06 Mar 2007 16:49:16 -0800
Message-ID: <7vvehdnaib.fsf@assigned-by-dhcp.cox.net>
References: <20070306093917.GA1761@coredump.intra.peff.net>
	<200703061423.18417.jnareb@gmail.com>
	<7vzm6qm07l.fsf@assigned-by-dhcp.cox.net>
	<200703070137.07477.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Li Yang-r58472" <LeoLi@freescale.com>,
	"Jeff King" <peff@peff.net>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 07 01:49:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HOkLN-0008Bx-Fd
	for gcvg-git@gmane.org; Wed, 07 Mar 2007 01:49:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161071AbXCGAtT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Mar 2007 19:49:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161070AbXCGAtS
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Mar 2007 19:49:18 -0500
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:40498 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161071AbXCGAtS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Mar 2007 19:49:18 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070307004916.UUPN24587.fed1rmmtao105.cox.net@fed1rmimpo02.cox.net>;
          Tue, 6 Mar 2007 19:49:16 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id XcpG1W00S1kojtg0000000; Tue, 06 Mar 2007 19:49:17 -0500
In-Reply-To: <200703070137.07477.jnareb@gmail.com> (Jakub Narebski's message
	of "Wed, 7 Mar 2007 01:37:06 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41629>

Jakub Narebski <jnareb@gmail.com> writes:

> In short: escape tag contents if needed, do not escape attrbure values.

I trust a patch from you will follow shortly?
