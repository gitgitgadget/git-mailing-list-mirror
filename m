From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] remote-curl: let users turn off smart http
Date: Fri, 21 Sep 2012 13:41:29 -0400
Message-ID: <20120921174129.GB20896@sigill.intra.peff.net>
References: <20120920165938.GB18655@sigill.intra.peff.net>
 <20120920170517.GB18981@sigill.intra.peff.net>
 <7va9wkbmyc.fsf@alter.siamese.dyndns.org>
 <20120920181231.GA19204@sigill.intra.peff.net>
 <7vzk4ka6dp.fsf@alter.siamese.dyndns.org>
 <20120920205107.GB22284@sigill.intra.peff.net>
 <7vd31g9z13.fsf@alter.siamese.dyndns.org>
 <20120920213058.GA23904@sigill.intra.peff.net>
 <7vmx0j700x.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 21 19:41:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TF7ES-0005vi-I9
	for gcvg-git-2@plane.gmane.org; Fri, 21 Sep 2012 19:41:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932298Ab2IURlc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Sep 2012 13:41:32 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:53510 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932070Ab2IURlb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Sep 2012 13:41:31 -0400
Received: (qmail 4529 invoked by uid 107); 21 Sep 2012 17:41:57 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 21 Sep 2012 13:41:57 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 21 Sep 2012 13:41:29 -0400
Content-Disposition: inline
In-Reply-To: <7vmx0j700x.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206143>

On Fri, Sep 21, 2012 at 10:34:22AM -0700, Junio C Hamano wrote:

> >> > I'm half-tempted to just drop the config entirely, leave
> >> > GIT_SMART_HTTP=false as an escape hatch, and see if anybody even cares.
> >> 
> >> Sounds like a very attractive minimalistic way to go forward.  We
> >> can always add per-remote configuration when we find it necessary,
> >> but once we add support, we cannot easily yank it out.
> >
> > Like this?
> 
> Yeah.  Will queue this one instead.  The simpler, the better ;-)

Thanks. I almost followed up with a rebased version of my config patch,
should we want to apply it later separately. But I think I would really
rather gather data from even a single bug report before we move any
further (and with any luck, there will be zero bug reports :) ).

-Peff
