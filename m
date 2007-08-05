From: Jeff King <peff@peff.net>
Subject: Re: Terminology question about remote branches.
Date: Sun, 5 Aug 2007 07:02:00 -0400
Message-ID: <20070805110200.GA18083@coredump.intra.peff.net>
References: <854pjfin68.fsf@lola.goethe.zz> <20070804092933.aaec6d52.seanlkml@sympatico.ca> <85ejijgzzg.fsf@lola.goethe.zz> <20070805100532.GG12507@coredump.intra.peff.net> <85172807-B7EB-47DD-813E-FAF5894E1190@zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Kastrup <dak@gnu.org>, Sean <seanlkml@sympatico.ca>,
	git@vger.kernel.org
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Sun Aug 05 13:02:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHds9-00055H-KW
	for gcvg-git@gmane.org; Sun, 05 Aug 2007 13:02:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757393AbXHELCG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 5 Aug 2007 07:02:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755660AbXHELCE
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Aug 2007 07:02:04 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3106 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754074AbXHELCE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Aug 2007 07:02:04 -0400
Received: (qmail 17649 invoked from network); 5 Aug 2007 11:02:06 -0000
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by peff.net with (DHE-RSA-AES128-SHA encrypted) SMTP; 5 Aug 2007 11:02:05 -0000
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 05 Aug 2007 07:02:00 -0400
Content-Disposition: inline
In-Reply-To: <85172807-B7EB-47DD-813E-FAF5894E1190@zib.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54993>

On Sun, Aug 05, 2007 at 12:56:49PM +0200, Steffen Prohaska wrote:

> beyond my imagination that I could have a local following/automerging
> branch that is directly referring to a branch in a remote repo, without
> have a remote-tracking branch.
>
> How could I create such a setup in the first place?
>
>     git branch --track something origin/something
>     git checkout --track -b something origin/something
>
> are obvious, but what to say if I don't have origin/something?

I believe the --track setup uses the tracking branches to figure out
which remote/branch combo to track. To do it without a remote tracking
branch, you would have to add the lines to your .git/config manually.

-Peff
