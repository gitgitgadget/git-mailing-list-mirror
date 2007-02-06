From: Jeff King <peff@peff.net>
Subject: Re: Difficulties in advertising a new branch to git newbies
Date: Tue, 6 Feb 2007 02:31:41 -0500
Message-ID: <20070206073141.GD23866@coredump.intra.peff.net>
References: <87odognuhl.wl%cworth@cworth.org> <87y7nbdeaw.wl%cworth@cworth.org> <7vveifkczt.fsf@assigned-by-dhcp.cox.net> <7vodo7karm.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Carl Worth <cworth@cworth.org>, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Feb 06 08:31:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HEKns-00054U-Dq
	for gcvg-git@gmane.org; Tue, 06 Feb 2007 08:31:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750994AbXBFHbn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Feb 2007 02:31:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751059AbXBFHbn
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Feb 2007 02:31:43 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1374 "HELO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750994AbXBFHbn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Feb 2007 02:31:43 -0500
Received: (qmail 22802 invoked from network); 6 Feb 2007 02:31:43 -0500
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by 66-23-211-5.clients.speedfactory.net with SMTP; 6 Feb 2007 02:31:43 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 06 Feb 2007 02:31:41 -0500
Content-Disposition: inline
In-Reply-To: <7vodo7karm.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38817>

On Mon, Feb 05, 2007 at 11:25:49PM -0800, Junio C Hamano wrote:

> So addition to "if unique", we need another DWIM rule that says
> "refs/heads/branch" trumps even when there are branch elsewhere
> and prevents ambiguity rule from triggering.

FWIW, the patch I just posted allows all existing lookups to trump
refs/remotes/*/%s, but will complain of ambiguities between remotes.
But please don't take my patch as a vote for this being sane. :) I just
wanted to give Carl something to play with.

-Peff
