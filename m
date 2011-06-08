From: Jeff King <peff@peff.net>
Subject: Re: Command-line interface thoughts (ad-hominem attacks)
Date: Wed, 8 Jun 2011 11:05:37 -0400
Message-ID: <20110608150537.GC7805@sigill.intra.peff.net>
References: <BANLkTikTWx7A64vN+hVZgL7cuiZ16Eobgg@mail.gmail.com>
 <7vd3ir9btd.fsf@alter.siamese.dyndns.org>
 <4DEDC124.3060302@drmicha.warpmail.net>
 <201106081312.46377.jnareb@gmail.com>
 <BANLkTinoQCZhyhgw61u7c3eF4e5MEf+eFA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jakub Narebski <jnareb@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Junio C Hamano <gitster@pobox.com>,
	Scott Chacon <schacon@gmail.com>, git@vger.kernel.org
To: mike@nahas.com
X-From: git-owner@vger.kernel.org Wed Jun 08 17:05:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QUKKI-00052K-Rr
	for gcvg-git-2@lo.gmane.org; Wed, 08 Jun 2011 17:05:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756230Ab1FHPFm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jun 2011 11:05:42 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:41402
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755162Ab1FHPFl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jun 2011 11:05:41 -0400
Received: (qmail 30929 invoked by uid 107); 8 Jun 2011 15:05:48 -0000
Received: from c-76-21-13-32.hsd1.ca.comcast.net (HELO sigill.intra.peff.net) (76.21.13.32)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 08 Jun 2011 11:05:48 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 08 Jun 2011 11:05:37 -0400
Content-Disposition: inline
In-Reply-To: <BANLkTinoQCZhyhgw61u7c3eF4e5MEf+eFA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175379>

On Wed, Jun 08, 2011 at 07:39:16AM -0400, Michael Nahas wrote:

> On Wed, Jun 8, 2011 at 7:12 AM, Jakub Narebski <jnareb@gmail.com> wrote:
> > I don't quite think that we need "git diff NEXT WTREE"; the short
> > and sweet "git diff" is short for a reason,
> 
> To be clear, I'm not advocating and have never advocated getting rid
> of zero-argument "git diff".  I've advocated that every (whole
> project) diff command should be expressible by a "git diff TREE1
> TREE2".  I'm fine with defaults if one or zero trees are specified.

I agree with this, but...

> So "git diff" would default to "git diff NEXT WTREE".

Isn't this going to be behavior change, since your NEXT is not quite the
same as the index? How do I now get an n-way combined diff of the
unmerged files in the index?

-Peff
