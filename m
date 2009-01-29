From: Jeff King <peff@peff.net>
Subject: Re: What's cooking in git.git (Jan 2009, #07; Wed, 28)
Date: Thu, 29 Jan 2009 06:50:26 -0500
Message-ID: <20090129115026.GB10792@coredump.intra.peff.net>
References: <7vwscej26i.fsf@gitster.siamese.dyndns.org> <20090129035138.GC11836@coredump.intra.peff.net> <bd6139dc0901290327u572cc30ci9dc719c912fbf875@mail.gmail.com> <20090129113735.GA6505@coredump.intra.peff.net> <351A6988-32EB-473F-B6E5-8FBB38D91F88@ai.rug.nl> <bd6139dc0901290345u4962f747gbe93c945ab35c9cb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Pieter de Bie <pdebie@ai.rug.nl>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 29 12:52:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSVR5-0006v7-M4
	for gcvg-git-2@gmane.org; Thu, 29 Jan 2009 12:51:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754017AbZA2Lu3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Jan 2009 06:50:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753403AbZA2Lu3
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Jan 2009 06:50:29 -0500
Received: from peff.net ([208.65.91.99]:38774 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752766AbZA2Lu3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Jan 2009 06:50:29 -0500
Received: (qmail 7608 invoked by uid 107); 29 Jan 2009 11:50:38 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Thu, 29 Jan 2009 06:50:38 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 29 Jan 2009 06:50:26 -0500
Content-Disposition: inline
In-Reply-To: <bd6139dc0901290345u4962f747gbe93c945ab35c9cb@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107663>

On Thu, Jan 29, 2009 at 12:45:23PM +0100, Sverre Rabbelier wrote:

> On Thu, Jan 29, 2009 at 12:40, Pieter de Bie <pdebie@ai.rug.nl> wrote:
> > This is true in all cases. If you create a new branch in any repository,
> > push that, and later do a 'git pull', you get that message. I agree it's
> > not the nicest way to handle things, but this is not an issue with the
> > clone, it's an issue of pushing new branches in general.
> 
> Mhhh, so maybe we want a way to set up tracking branches when pushing,
> yes? From what I've seen a patch to do that shouldn't be too hard, so
> if there's interest in that I could look into that.

I think that would be reasonable. It wouldn't help the case of "somebody
else pushed some content that you want to pull", but like you said, I
think the primary workflow is that you immediately push after cloning
the empty repo.

-Peff
