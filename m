From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Proof-of-concept patch to remember what the detached
 HEAD was
Date: Thu, 15 Oct 2009 17:26:32 -0400
Message-ID: <20091015212632.GA13180@coredump.intra.peff.net>
References: <76718490910141156g440ee455t2e1db72ad72b7049@mail.gmail.com>
 <alpine.LNX.2.00.0910141509200.32515@iabervon.org>
 <alpine.LFD.2.00.0910141616530.20122@xanadu.home>
 <7v7huxbtbk.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.00.0910141647390.20122@xanadu.home>
 <7vws2xa9lu.fsf@alter.siamese.dyndns.org>
 <20091014230934.GC29664@coredump.intra.peff.net>
 <885649360910150036o72c3bd97ofad85d5316dc5b35@mail.gmail.com>
 <alpine.LFD.2.00.0910151436180.20122@xanadu.home>
 <7v1vl45t9k.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Nicolas Pitre <nico@fluxnic.net>,
	James Pickens <jepicken@gmail.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jay Soffian <jaysoffian@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 15 23:30:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MyXtS-0003NT-Hc
	for gcvg-git-2@lo.gmane.org; Thu, 15 Oct 2009 23:29:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932708AbZJOV1M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Oct 2009 17:27:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754925AbZJOV1M
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Oct 2009 17:27:12 -0400
Received: from peff.net ([208.65.91.99]:53346 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754902AbZJOV1L (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Oct 2009 17:27:11 -0400
Received: (qmail 10080 invoked by uid 107); 15 Oct 2009 21:30:05 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Thu, 15 Oct 2009 17:30:05 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 15 Oct 2009 17:26:32 -0400
Content-Disposition: inline
In-Reply-To: <7v1vl45t9k.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130423>

On Thu, Oct 15, 2009 at 12:52:55PM -0700, Junio C Hamano wrote:

> I like James's suggestion to allow us to store refs other than refs/heads/
> in HEAD to denote this state, and keep commit and reset from updating such
> a ref through updating HEAD.

Didn't we already consider and reject this the first time around? For
example, this thread has a ton of stuff about how we shouldn't prevent
people from making commits on the wandering state:

  http://thread.gmane.org/gmane.comp.version-control.git/35777/focus=35835

And here's me even advocating this exact strategy (and I'm sure I didn't
think of it; it's probably discussed elsewhere, too):

  http://thread.gmane.org/gmane.comp.version-control.git/35777/focus=35858

Not that I am not necessarily complaining, but I just hope this decision
is "with new-found knowledge we are revisiting this decision" and not
"we totally forgot about what came before".

-Peff
