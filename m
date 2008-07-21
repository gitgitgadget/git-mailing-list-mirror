From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] git-add -a: add all files
Date: Sun, 20 Jul 2008 20:17:32 -0400
Message-ID: <20080721001731.GC12454@sigill.intra.peff.net>
References: <48806897.1080404@fastmail.fm> <76718490807181318o228171f9j836aaca2edb9b377@mail.gmail.com> <7vsku5grpr.fsf@gitster.siamese.dyndns.org> <7vk5fhgrm6.fsf_-_@gitster.siamese.dyndns.org> <905315640807192120k45b8c0e3k5b341e77c466dde@mail.gmail.com> <alpine.DEB.1.00.0807201250530.3305@eeepc-johanness> <76718490807200545l653bbda1l4d13f1e1e698c855@mail.gmail.com> <7v4p6k8l36.fsf@gitster.siamese.dyndns.org> <20080720235933.GA12454@sigill.intra.peff.net> <7vprp814oe.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jay Soffian <jaysoffian@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Tarmigan <tarmigan+git@gmail.com>, git@vger.kernel.org,
	Michael J Gruber <michaeljgruber+gmane@fastmail.fm>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 21 02:18:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KKj6p-0000LI-3g
	for gcvg-git-2@gmane.org; Mon, 21 Jul 2008 02:18:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754414AbYGUARf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Jul 2008 20:17:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754397AbYGUARf
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Jul 2008 20:17:35 -0400
Received: from peff.net ([208.65.91.99]:1437 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754275AbYGUARf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Jul 2008 20:17:35 -0400
Received: (qmail 6938 invoked by uid 111); 21 Jul 2008 00:17:32 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Sun, 20 Jul 2008 20:17:32 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 20 Jul 2008 20:17:32 -0400
Content-Disposition: inline
In-Reply-To: <7vprp814oe.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89275>

On Sun, Jul 20, 2008 at 05:06:41PM -0700, Junio C Hamano wrote:

> > But again, I haven ever felt the lack of this feature; such usage for me
> > always goes in scripts, where I am more than happy to write out "add .
> > && add -u && commit".
> 
> The reason we did not have such "feature" so far was not because somebody
> high in the git foodchain was opposed to the idea, but simply because
> nobody came up with a usable patch to do so.
> 
> I do not have anything fundamentally against "add -A" nor "commit -A".  To
> me, this is in "perhaps nice to have for some people, but I would not use
> it myself and I wouldn't bother" category, not in "I'm opposed -- it would
> promote bad workflow" cateogry.

I think I didn't make my point well; I am also not that I am opposed to
this feature. The paragraph you quoted meant to say "What I described
above with commit -A is what I think people who are asking for this
feature want. But _I_ don't actually want it, even as somebody who does
this workflow, so I might be wrong."

-Peff
