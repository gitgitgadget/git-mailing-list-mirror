From: Jeff King <peff@peff.net>
Subject: Re: How to create tags outside of refs/tags?
Date: Tue, 22 Feb 2011 10:27:23 -0500
Message-ID: <20110222152723.GA23353@sigill.intra.peff.net>
References: <AANLkTimxAhMfPsqEJVyteuTzXLr+QnhcxpJLgaE=y12_@mail.gmail.com>
 <AANLkTi=7yUh9J9S5LdpNY0SwCv008ih2LEd3KNvy46sL@mail.gmail.com>
 <20110222080305.GA11177@sigill.intra.peff.net>
 <7vvd0cebi6.fsf@alter.siamese.dyndns.org>
 <20110222081458.GA11825@sigill.intra.peff.net>
 <m3wrks756a.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Christian Halstrick <christian.halstrick@gmail.com>,
	git <git@vger.kernel.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 22 16:27:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pru9I-00036P-3W
	for gcvg-git-2@lo.gmane.org; Tue, 22 Feb 2011 16:27:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754083Ab1BVP1b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Feb 2011 10:27:31 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:47547 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753543Ab1BVP1b (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Feb 2011 10:27:31 -0500
Received: (qmail 2009 invoked by uid 111); 22 Feb 2011 15:27:30 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Tue, 22 Feb 2011 15:27:30 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 22 Feb 2011 10:27:23 -0500
Content-Disposition: inline
In-Reply-To: <m3wrks756a.fsf@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167553>

On Tue, Feb 22, 2011 at 02:09:14AM -0800, Jakub Narebski wrote:

> > I think changing the config name to tag.list-ignore would make it more
> > obvious what is going on. If you don't want to push certain tags, I
> > think refspecs are the way to do that, and this should be a purely local
> > display thing.
> 
> You meant `tag.listIgnore`, weren't you?  No hyphens in config
> variable names.

Sure.

> About refspecs: we currently do not support negative refspecs, do we?
> (IIRC there was proposal to use '!' or '-' as prefix for them).  So we
> can't currently exclude refs/tags/private/* while including
> refs/tags/v*?

Yeah, I think you might be stuck enumerating the tags you want via
refspec. But I stand by my statement; if this feature is something we
want, it should be purely about listing tags. I don't want to get into
weird tag-specific config affecting the what we push. If somebody wants
negative refspecs, that can be a separate patch.

But like I said before, I am lukewarm on the patch in the first place.

-Peff
