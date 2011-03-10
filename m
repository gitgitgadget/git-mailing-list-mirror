From: Jeff King <peff@peff.net>
Subject: Re: Fwd: [PATCH 2/2] pretty.c: allow date formats in user format
 strings
Date: Thu, 10 Mar 2011 17:31:48 -0500
Message-ID: <20110310223148.GD15828@sigill.intra.peff.net>
References: <20110305195020.GA3089@sigill.intra.peff.net>
 <20110305200010.GB32095@sigill.intra.peff.net>
 <AANLkTinH8zwX2sbd5bpk=x4R3zOAg3Dc92Fbspfdv03T@mail.gmail.com>
 <AANLkTikaN=wsg6RLFaFxh=L3RCYjKkVGFR4VTrQ=KRZk@mail.gmail.com>
 <20110307161758.GB11934@sigill.intra.peff.net>
 <7v39mw9f7a.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Dietmar Winkler <dietmarw@gmx.de>,
	Will Palmer <wmpalmer@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 10 23:31:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PxoOi-0006ja-TT
	for gcvg-git-2@lo.gmane.org; Thu, 10 Mar 2011 23:31:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753294Ab1CJWbu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Mar 2011 17:31:50 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:59825
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753199Ab1CJWbt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Mar 2011 17:31:49 -0500
Received: (qmail 31789 invoked by uid 107); 10 Mar 2011 22:32:20 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 10 Mar 2011 17:32:20 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 10 Mar 2011 17:31:48 -0500
Content-Disposition: inline
In-Reply-To: <7v39mw9f7a.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168858>

On Wed, Mar 09, 2011 at 01:06:17PM -0800, Junio C Hamano wrote:

> > Agreed. And I think it is possible to do it in a backwards-compatible
> > way; support %(longname:options) for everything, and keep short-hands
> > like %h and %ad for existing elements without options.
> 
> Yes, I think %( is not taken in the pretty-format language, so we should
> be able to do this.
> 
> I wanted to take your earlier "'%ad' or '%ad(format)'" patch but refrained
> from doing so.  The above line of reasoning is much better for the long
> term health of the project.

OK. Do you want me to throw away the %ad(format) patch for now, then, in
favor of building it on top of a more sane syntax?

I had originally planned to do %ad(format) for now, and then worry about
syntax later. Since we already have a variety of of other placeholders
with similar syntax (e.g., %w(), %C()). But I don't care too much either
way; it is not a feature I personally wanted, so delay doesn't bother
me. Dietmar (the original requestor) may feel differently, of course. :)

-Peff
