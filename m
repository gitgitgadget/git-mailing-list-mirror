From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] git-name-rev: accept list of refs from user
Date: Sat, 17 Feb 2007 18:19:43 -0500
Message-ID: <20070217231943.GA30839@coredump.intra.peff.net>
References: <7vmz3ctzer.fsf@assigned-by-dhcp.cox.net> <20070217231327.GA5382@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun Feb 18 00:19:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HIYqO-0002OV-Gd
	for gcvg-git@gmane.org; Sun, 18 Feb 2007 00:19:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933094AbXBQXTq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 17 Feb 2007 18:19:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933095AbXBQXTq
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Feb 2007 18:19:46 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2644 "HELO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S933094AbXBQXTp (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Feb 2007 18:19:45 -0500
Received: (qmail 14410 invoked from network); 17 Feb 2007 18:19:53 -0500
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by 66-23-211-5.clients.speedfactory.net with SMTP; 17 Feb 2007 18:19:53 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 17 Feb 2007 18:19:43 -0500
Content-Disposition: inline
In-Reply-To: <20070217231327.GA5382@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40021>

On Sat, Feb 17, 2007 at 06:13:28PM -0500, Jeff King wrote:

>   git show-ref | grep /v1 | git name-rev --refs-from=- $commit

BTW, I think this should be in addition to, not instead of, Johannes'
patch. I think for the simple filtering case, his syntax is much quicker
and more natural.

Of course, there will be plenty of conflicts merging them. :) I can do
the merge and resubmit after you publish Johannes' patch; just let me
know.

-Peff
