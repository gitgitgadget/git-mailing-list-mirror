From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Teach 'git pull' the '--rebase' option
Date: Fri, 26 Oct 2007 07:45:18 -0400
Message-ID: <20071026114518.GB2693@coredump.intra.peff.net>
References: <Pine.LNX.4.64.0710252351130.4362@racer.site> <alpine.LFD.0.999.0710251602160.30120@woody.linux-foundation.org> <Pine.LNX.4.64.0710260007450.4362@racer.site> <20071026114331.GA2693@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org, gitster@pobox.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Oct 26 13:46:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IlNdV-0001tK-Hc
	for gcvg-git-2@gmane.org; Fri, 26 Oct 2007 13:45:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753155AbXJZLpX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Oct 2007 07:45:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759496AbXJZLpW
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Oct 2007 07:45:22 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2910 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753322AbXJZLpV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Oct 2007 07:45:21 -0400
Received: (qmail 28562 invoked by uid 111); 26 Oct 2007 11:45:20 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Fri, 26 Oct 2007 07:45:20 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 26 Oct 2007 07:45:18 -0400
Content-Disposition: inline
In-Reply-To: <20071026114331.GA2693@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62410>

On Fri, Oct 26, 2007 at 07:43:32AM -0400, Jeff King wrote:

> Reasonable, although perhaps it should mention what I suspect might be a
> common workflow for this feature: CVS emulation. I.e., there is a
> central repo, which is the only thing considered "published". Developers
> make commits in their local repo, and then rebase their changes onto the
> HEAD before pushing. The only difference from CVS is that you don't
> actually get to commit in CVS, you have to do the rebase with your
> working tree. :)

Actually, I think I've just restated Junio's comment somewhat, so the
change you made in response to him is an improvement. Sorry for the
noise.

-Peff
