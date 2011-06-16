From: Jeff King <peff@github.com>
Subject: Re: [PATCH 7/7] archive: provide builtin .tar.gz filter
Date: Thu, 16 Jun 2011 14:21:50 -0400
Message-ID: <20110616182149.GB12689@sigill.intra.peff.net>
References: <20110616003800.GC20355@sigill.intra.peff.net>
 <7v39jai94h.fsf@alter.siamese.dyndns.org>
 <20110616065146.GA30672@sigill.intra.peff.net>
 <20110616075621.GA12413@arachsys.com>
 <20110616174653.GD6584@sigill.intra.peff.net>
 <7vtybphcym.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Chris Webb <chris@arachsys.com>,
	Ren?? Scharfe <rene.scharfe@lsrfire.ath.cx>,
	"J.H." <warthog19@eaglescrag.net>, git@vger.kernel.org,
	git-dev@github.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 16 20:21:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QXHCX-0005zc-A8
	for gcvg-git-2@lo.gmane.org; Thu, 16 Jun 2011 20:21:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757977Ab1FPSVw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Jun 2011 14:21:52 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:46404
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752687Ab1FPSVw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Jun 2011 14:21:52 -0400
Received: (qmail 16004 invoked by uid 107); 16 Jun 2011 18:22:02 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 16 Jun 2011 14:22:02 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 16 Jun 2011 14:21:50 -0400
Content-Disposition: inline
In-Reply-To: <7vtybphcym.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175912>

On Thu, Jun 16, 2011 at 11:02:09AM -0700, Junio C Hamano wrote:

> Jeff King <peff@github.com> writes:
> 
> > OK. I'm totally willing to accept that people actually prefer the "-n"
> > behavior. I don't care either way myself. I just don't want the reason
> > to default to "-n" to be "because our test scripts need it" and not
> > "because this is what people actually want".
> 
> Surely I share the exact feeling, and that is why I quoted the other "-n"
> added to gitweb because that was what people actually wanted.

Fair enough. I'll use "gzip -n" in my re-roll.

Any comment on the "tarfilter" versus "generic archive filter" issue, or
on the general interface? I think getting that right is my biggest issue
in moving forward.

Also, since it's easy via the external helper route, should there be any
other builtin formats? Bzip2? It's not that big a deal for a big hosting
site like kernel.org to stick it in their configuration, but I wonder if
normal users would find it useful.

-Peff
