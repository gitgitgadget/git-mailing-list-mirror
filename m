From: Jeff King <peff@peff.net>
Subject: Re: [PATCH/RFD 0/2] revision.c: --merges, --no-merges and
 --merges-only
Date: Thu, 17 Mar 2011 15:59:05 -0400
Message-ID: <20110317195905.GG20508@sigill.intra.peff.net>
References: <cover.1300359256.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu Mar 17 20:59:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q0JLm-0001Tw-Ev
	for gcvg-git-2@lo.gmane.org; Thu, 17 Mar 2011 20:59:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755112Ab1CQT7I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Mar 2011 15:59:08 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:35246
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754358Ab1CQT7H (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Mar 2011 15:59:07 -0400
Received: (qmail 27040 invoked by uid 107); 17 Mar 2011 19:59:42 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 17 Mar 2011 15:59:42 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 17 Mar 2011 15:59:05 -0400
Content-Disposition: inline
In-Reply-To: <cover.1300359256.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169271>

On Thu, Mar 17, 2011 at 12:33:56PM +0100, Michael J Gruber wrote:

> This mini series makes it so that --no-merges undoes --merges
> and vice versa, as the user should be able to expect,
> and that --merges-only is a separate option.

Having recently been confused by this (and frustrated at the lack of an
equivalent to your new "--merges"), I do think the result is better.

However, this is totally changing the meaning of an option to plumbing
like rev-list (among others). Is it worth the breakage? If so, what's
the migration plan? Did I miss a discussion somewhere?

-Peff
