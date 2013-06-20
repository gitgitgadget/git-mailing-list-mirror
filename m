From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2] pull: merge into unborn by fast-forwarding from empty
 tree
Date: Thu, 20 Jun 2013 18:03:28 -0400
Message-ID: <20130620220328.GA3992@sigill.intra.peff.net>
References: <20130620124758.GA2376@sigill.intra.peff.net>
 <aca810600b895ed3f0a3fc575e0f6861e591de5b.1371733403.git.trast@inf.ethz.ch>
 <7v8v24vd0m.fsf@alter.siamese.dyndns.org>
 <20130620201957.GC31364@sigill.intra.peff.net>
 <7vmwqkqzhy.fsf@alter.siamese.dyndns.org>
 <20130620205533.GA8074@sigill.intra.peff.net>
 <7v7ghoqwwv.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Thomas Rast <trast@inf.ethz.ch>,
	Stefan =?utf-8?B?U2Now7zDn2xlcg==?= <mail@stefanschuessler.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 21 00:03:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Upmx6-0008Dz-8X
	for gcvg-git-2@plane.gmane.org; Fri, 21 Jun 2013 00:03:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758353Ab3FTWDc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Jun 2013 18:03:32 -0400
Received: from cloud.peff.net ([50.56.180.127]:60278 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758343Ab3FTWDc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Jun 2013 18:03:32 -0400
Received: (qmail 15979 invoked by uid 102); 20 Jun 2013 22:04:31 -0000
Received: from c-98-244-76-202.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (98.244.76.202)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 20 Jun 2013 17:04:31 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 20 Jun 2013 18:03:28 -0400
Content-Disposition: inline
In-Reply-To: <7v7ghoqwwv.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228546>

On Thu, Jun 20, 2013 at 02:45:04PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > I think I got us off-track with my expectation of ending the one case
> > with a conflicted index. But caring about that is even more unlikely.  I
> > think Thomas's original patch is probably a happy medium.
> 
> OK, so should I consider it Reviewed-by: peff?

Yes, modulo the breakage of the &&- chain that Thomas mentioned.

> > As an orthogonal matter, we probably should reverse the order of
> > updating HEAD and the index/working tree, as it does not make much sense
> > to me to do the former if the latter is not possible (and that is the
> > case even with the current code).
> 
> Yes.

OK. I'll prepare a series with both patches. Stand by...

-Peff
