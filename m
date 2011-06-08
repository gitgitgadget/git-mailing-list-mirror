From: Jeff King <peff@peff.net>
Subject: Re: [RFC/PATCH] git put: an alternative to add/reset/checkout
Date: Wed, 8 Jun 2011 13:30:12 -0400
Message-ID: <20110608173012.GA4279@sigill.intra.peff.net>
References: <20110607200659.GA6177@sigill.intra.peff.net>
 <7vvcwh4ako.fsf@alter.siamese.dyndns.org>
 <20110607214532.GB7663@sigill.intra.peff.net>
 <m3hb80dynr.fsf@localhost.localdomain>
 <vpqtyc0nsfw.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jakub Narebski <jnareb@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Scott Chacon <schacon@gmail.com>,
	Michael Nahas <mike@nahas.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Jun 08 19:30:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QUMaE-00033u-3x
	for gcvg-git-2@lo.gmane.org; Wed, 08 Jun 2011 19:30:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752817Ab1FHRaR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jun 2011 13:30:17 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:34517
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751247Ab1FHRaQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jun 2011 13:30:16 -0400
Received: (qmail 892 invoked by uid 107); 8 Jun 2011 17:30:23 -0000
Received: from c-76-21-13-32.hsd1.ca.comcast.net (HELO sigill.intra.peff.net) (76.21.13.32)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 08 Jun 2011 13:30:23 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 08 Jun 2011 13:30:12 -0400
Content-Disposition: inline
In-Reply-To: <vpqtyc0nsfw.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175409>

On Wed, Jun 08, 2011 at 07:28:35PM +0200, Matthieu Moy wrote:

> > Jeff King <peff@peff.net> writes:
> >
> >> I find the all-caps ugly, and it is part of what confuses them with
> >> HEAD. At the same time, we are using the same namespace that ref lookup
> >> uses. So calling it "worktree" might be too ambiguous. I tried to avoid
> >> using "--worktree" because I wanted to make it clear that these were
> >> ordered arguments, not options.
> >
> > Perhaps we can use some character that is forbidden in ref names,
> > doesn't make trouble when doing allowed operations on said refs, won't
> > confuse user, and is not trouble with shell... ehhh...
> >
> > * @{wtree} would confuse users that it has something to do with reflog
> 
> Well, we already have @{upstream} ...

Yes, but like all of the @{} things, it's a modifier for the left-hand
side. So "master@{upstream}" is meaningful, and "@{upstream}" is the
same as "HEAD@{upstream}".

What does "master@{wtree}" mean?

-Peff
