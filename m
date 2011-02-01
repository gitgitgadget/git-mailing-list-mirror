From: Jeff King <peff@peff.net>
Subject: Re: [1.8.0] reorganize the mess that the source tree has become
Date: Mon, 31 Jan 2011 20:48:07 -0500
Message-ID: <20110201014807.GA2722@sigill.intra.peff.net>
References: <7vzkqh8vqw.fsf@alter.siamese.dyndns.org>
 <7vwrll57ha.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.00.1101311459000.8580@xanadu.home>
 <20110131210045.GB14419@sigill.intra.peff.net>
 <alpine.LFD.2.00.1101311621150.8580@xanadu.home>
 <20110131231210.GD14419@sigill.intra.peff.net>
 <alpine.LFD.2.00.1101311903320.8580@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Tue Feb 01 02:48:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pk5Ls-0003ML-Ax
	for gcvg-git-2@lo.gmane.org; Tue, 01 Feb 2011 02:48:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754372Ab1BABsL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Jan 2011 20:48:11 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:37826 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754062Ab1BABsK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Jan 2011 20:48:10 -0500
Received: (qmail 15719 invoked by uid 111); 1 Feb 2011 01:48:09 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Tue, 01 Feb 2011 01:48:09 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 31 Jan 2011 20:48:07 -0500
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.1101311903320.8580@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165787>

On Mon, Jan 31, 2011 at 07:29:54PM -0500, Nicolas Pitre wrote:

> > Yes, we do suck at rename following. The problem is that it is partially
> [...]
> This is no excuse not to do proper source tree reorganization.

I think this is the crux of our disagreement. I don't agree that your
proposal is any way more "proper" than what is there now. Leaving the
rename issue aside (i.e., if we were starting a new project), I would
still be slightly against a src/ directory. I find them annoying.

But I don't care _that_ much, and I would rather not waste either of our
time debating it more. I would much rather you spend your time on
pack v4. :)

> I disagree.  This is like saying: "renames are not well supported, so 
> let's avoid them while using Git."  People used to say that of merges 
> with CVS.  Are we going to follow suit de facto?  Imagine the Git 
> detractors taking our source tree mess to exemplify this Git flaw since 
> "Git developers themselves are unwilling to move files around because 
> Git sucks at it".

For the record, part of my argument was that renaming is annoying to
some degree in _all_ systems, not just git.

> > I do think it's wrong to say "renames can't be
> > done"; I just the cost needs to be considered.
> 
> Instead, why not saying: "Rename tracking is not as optimal as it could 
> be, so let's work it out." ?

I did also say that. :)

-Peff
