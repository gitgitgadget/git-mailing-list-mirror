From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Teach 'git apply' to look at $GIT_DIR/config
Date: Sat, 17 Feb 2007 18:32:04 -0500
Message-ID: <20070217233203.GA6014@coredump.intra.peff.net>
References: <7vlkiwsepm.fsf@assigned-by-dhcp.cox.net> <7v8xewsd2j.fsf@assigned-by-dhcp.cox.net> <20070217232603.GB30839@coredump.intra.peff.net> <7vmz3cqs3d.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun Feb 18 00:32:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HIZ2c-0007on-Bg
	for gcvg-git@gmane.org; Sun, 18 Feb 2007 00:32:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992880AbXBQXcJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 17 Feb 2007 18:32:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992881AbXBQXcI
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Feb 2007 18:32:08 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1063 "HELO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S2992880AbXBQXcH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Feb 2007 18:32:07 -0500
Received: (qmail 14834 invoked from network); 17 Feb 2007 18:32:13 -0500
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by 66-23-211-5.clients.speedfactory.net with SMTP; 17 Feb 2007 18:32:13 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 17 Feb 2007 18:32:04 -0500
Content-Disposition: inline
In-Reply-To: <7vmz3cqs3d.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40027>

On Sat, Feb 17, 2007 at 03:31:18PM -0800, Junio C Hamano wrote:

> I thought about that, but decided against it.  If you are truly
> operating outside a git managed repository, it does not feel
> right to apply configuration user has for git.

Then why are they using git-apply, and not patch?

-Peff
