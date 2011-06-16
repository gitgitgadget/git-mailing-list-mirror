From: Jeff King <peff@github.com>
Subject: Re: [PATCH 7/7] archive: provide builtin .tar.gz filter
Date: Thu, 16 Jun 2011 13:46:53 -0400
Message-ID: <20110616174653.GD6584@sigill.intra.peff.net>
References: <20110616003800.GC20355@sigill.intra.peff.net>
 <7v39jai94h.fsf@alter.siamese.dyndns.org>
 <20110616065146.GA30672@sigill.intra.peff.net>
 <20110616075621.GA12413@arachsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Ren?? Scharfe <rene.scharfe@lsrfire.ath.cx>,
	"J.H." <warthog19@eaglescrag.net>, git@vger.kernel.org,
	git-dev@github.com
To: Chris Webb <chris@arachsys.com>
X-From: git-owner@vger.kernel.org Thu Jun 16 19:47:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QXGei-0003TD-9p
	for gcvg-git-2@lo.gmane.org; Thu, 16 Jun 2011 19:47:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758508Ab1FPRq4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Jun 2011 13:46:56 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:58831
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757205Ab1FPRqz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Jun 2011 13:46:55 -0400
Received: (qmail 15444 invoked by uid 107); 16 Jun 2011 17:47:06 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 16 Jun 2011 13:47:06 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 16 Jun 2011 13:46:53 -0400
Content-Disposition: inline
In-Reply-To: <20110616075621.GA12413@arachsys.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175906>

On Thu, Jun 16, 2011 at 08:56:21AM +0100, Chris Webb wrote:

> Jeff King <peff@github.com> writes:
> 
> > No, I mean that people may _want_ the timestamp in day to day use. Using
> > "-n" all the time suppresses it. And there is no reason to suppress it,
> > except that our test does not account for it properly. So your patch is
> > hurting people who don't want "-n" (i.e., want the timestamp) just to
> > make our test happy.
> 
> It's useful to omit the timestamp outside of git too. Source-based package
> management systems generally store a URL from which to fetch a source
> tarball, and a hash of that source tarball to ensure it hasn't been tampered
> with. It's nice to be able to use a gitweb URL like
> 
>   http://git.kernel.org/?p=git/git.git;a=snapshot;h=e5af0de202e885b793482d416b8ce9d50dd2b8bc;sf=tgz
> 
> as the tarball source, and still be able to verify its integrity against a
> prestored hash.

OK. I'm totally willing to accept that people actually prefer the "-n"
behavior. I don't care either way myself. I just don't want the reason
to default to "-n" to be "because our test scripts need it" and not
"because this is what people actually want".

-Peff
