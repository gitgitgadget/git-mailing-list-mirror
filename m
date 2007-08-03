From: Jeff King <peff@peff.net>
Subject: Re: git-diff on touched files: bug or feature?
Date: Fri, 3 Aug 2007 04:24:36 -0400
Message-ID: <20070803082435.GA15475@coredump.intra.peff.net>
References: <vpqwswf8c1i.fsf@bauges.imag.fr> <7v4pjj5fp6.fsf@assigned-by-dhcp.cox.net> <vpqhcni47ek.fsf@bauges.imag.fr> <7vd4y6xnw4.fsf@assigned-by-dhcp.cox.net> <7v1wemxnkk.fsf@assigned-by-dhcp.cox.net> <vpqzm1a2l72.fsf@bauges.imag.fr> <7vy7gtvhgc.fsf@assigned-by-dhcp.cox.net> <20070803070407.GA17287@coredump.intra.peff.net> <7vr6mlnj4g.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 03 10:24:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IGsSo-0005jK-GW
	for gcvg-git@gmane.org; Fri, 03 Aug 2007 10:24:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760163AbXHCIYn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 3 Aug 2007 04:24:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760108AbXHCIYm
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Aug 2007 04:24:42 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1537 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759468AbXHCIYk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Aug 2007 04:24:40 -0400
Received: (qmail 12828 invoked from network); 3 Aug 2007 08:24:40 -0000
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by peff.net with (DHE-RSA-AES128-SHA encrypted) SMTP; 3 Aug 2007 08:24:40 -0000
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 03 Aug 2007 04:24:36 -0400
Content-Disposition: inline
In-Reply-To: <7vr6mlnj4g.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54689>

On Fri, Aug 03, 2007 at 12:59:43AM -0700, Junio C Hamano wrote:

> On the other hand, if your workflow is "work on one thing at a
> time, and never make partial commits", then your diff tends to
> be small and more focused to begin with, and you can afford to
> care about "touched but ended up unmodified".  Interestingly, it

In an ideal world, I would work that way. But often you uncover a bug in
existing code while writing new code, and you want to make that bugfix a
separate commit. I generally make a partial commit to stash the bugfix
and test it individually. Without making a partial commit, how would you
split the bugfix changes from the working changes?  Or do you manually
pull the bugfix into another branch or working tree?

There is one point you didn't address from my original mail which I
would be curious to hear your take on. In your workflow, how do you
remind yourself that there are untracked files that need to be added? Do
you just wait until you see the commit template at the end?

-Peff
