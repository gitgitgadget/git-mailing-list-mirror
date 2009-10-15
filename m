From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Proof-of-concept patch to remember what the detached
 HEAD was
Date: Thu, 15 Oct 2009 00:21:59 -0400
Message-ID: <20091015042159.GA21701@coredump.intra.peff.net>
References: <alpine.LNX.2.00.0910141509200.32515@iabervon.org>
 <alpine.LFD.2.00.0910141616530.20122@xanadu.home>
 <7v7huxbtbk.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.00.0910141647390.20122@xanadu.home>
 <7vws2xa9lu.fsf@alter.siamese.dyndns.org>
 <20091014230934.GC29664@coredump.intra.peff.net>
 <alpine.LFD.2.00.0910141926170.20122@xanadu.home>
 <7viqeha2zv.fsf@alter.siamese.dyndns.org>
 <20091015014737.GA9923@coredump.intra.peff.net>
 <alpine.LFD.2.00.0910142237010.20122@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jay Soffian <jaysoffian@gmail.com>, git@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Thu Oct 15 06:23:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MyHrk-0003Un-Kb
	for gcvg-git-2@lo.gmane.org; Thu, 15 Oct 2009 06:23:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751268AbZJOEWi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Oct 2009 00:22:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750942AbZJOEWi
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Oct 2009 00:22:38 -0400
Received: from peff.net ([208.65.91.99]:53173 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750776AbZJOEWi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Oct 2009 00:22:38 -0400
Received: (qmail 3594 invoked by uid 107); 15 Oct 2009 04:25:32 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Thu, 15 Oct 2009 00:25:32 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 15 Oct 2009 00:21:59 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.0910142237010.20122@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130376>

On Wed, Oct 14, 2009 at 11:08:59PM -0400, Nicolas Pitre wrote:

> IMHO this patch proposed by Daniel about the detached head is probably a 
> good compromise.  It makes "confusing" operations more verbose to give 
> new users a better feeling while keeping the flexibility intact.  And 
> increased verbosity is less annoying than decreased flexibility.

And I don't think there is as much opposition to a config option to
silence verbosity, because it isn't really a change in behavior. We
already have advice.*, and if the new message is too annoying, we can
get advice.commitDetachedHead.

-Peff
