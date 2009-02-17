From: Jeff King <peff@peff.net>
Subject: Re: PUSH_HEAD, was Re: disallowing push to currently checked-out
	branch
Date: Tue, 17 Feb 2009 14:48:27 -0500
Message-ID: <20090217194827.GB16067@coredump.intra.peff.net>
References: <alpine.DEB.1.00.0902161839120.6289@intel-tinevez-2-302> <76718490902161048i3c19bb43h30b1cfc62dd9a61e@mail.gmail.com> <alpine.DEB.1.00.0902162102180.6289@intel-tinevez-2-302> <76718490902161312j2aee999bga00d95231fa85647@mail.gmail.com> <alpine.DEB.1.00.0902162215200.6289@intel-tinevez-2-302> <76718490902161428k7d252a02i3e79e4f197608891@mail.gmail.com> <20090216225226.GB23764@sigill.intra.peff.net> <76718490902162153m6a524b2dv335be66a0f0294ca@mail.gmail.com> <alpine.DEB.1.00.0902171200250.6185@intel-tinevez-2-302> <76718490902170929v3ed9e3c2tb2f7fb1bfc01b3ab@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Sergio Callegari <sergio.callegari@gmail.com>,
	git@vger.kernel.org
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 17 20:50:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZVx8-000447-Ie
	for gcvg-git-2@gmane.org; Tue, 17 Feb 2009 20:49:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753197AbZBQTsa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Feb 2009 14:48:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752186AbZBQTsa
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Feb 2009 14:48:30 -0500
Received: from peff.net ([208.65.91.99]:55932 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752085AbZBQTs3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Feb 2009 14:48:29 -0500
Received: (qmail 31627 invoked by uid 107); 17 Feb 2009 19:48:49 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 17 Feb 2009 14:48:49 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 17 Feb 2009 14:48:27 -0500
Content-Disposition: inline
In-Reply-To: <76718490902170929v3ed9e3c2tb2f7fb1bfc01b3ab@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110446>

On Tue, Feb 17, 2009 at 12:29:53PM -0500, Jay Soffian wrote:

> So both you and Junio have changed your mind since that thread then.
> Because in that thread, you propose  receive.guardCurrentBranch, which
> was quite similar to today's receive.denyCurrentBranch. Junio then
> argues that treating just the checked-out branch as special, as
> opposed to all local branches is not the right thing to do:

I have to admit, I found that thread a very interesting read, because I
somehow missed it the first time and it seemed the opposite of what
happened later.

> So, I'm not sure what happened in the intervening time between the
> receive.localBranches proposal and the receive.denyCurrentBranch
> implementation that suddenly what is basically guardCurrentBranch
> became a good idea.

I think what happened (partially) is that I never read the original,
then at GitTogether somebody (Sam?) was complaining about usability
issues, so I wrote the denyCurrentBranch patch. Why and how people
changed their minds is a mystery to me, though.

-Peff

PS I seem to have an uncanny knack for writing a patch, then finding out
that Dscho wrote the exact same patch months or years earlier. I think
this is the third time it has happened.
