From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] config: define and document exit codes
Date: Wed, 18 May 2011 04:21:30 -0400
Message-ID: <20110518082130.GG27482@sigill.intra.peff.net>
References: <20110517140725.GA17193@sigill.intra.peff.net>
 <6301052eb455e9088e50f78760e6ca1b9499564a.1305646709.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Wed May 18 10:21:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QMc0i-0007RR-4T
	for gcvg-git-2@lo.gmane.org; Wed, 18 May 2011 10:21:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755454Ab1ERIVe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 May 2011 04:21:34 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:44635
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754316Ab1ERIVd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 May 2011 04:21:33 -0400
Received: (qmail 3053 invoked by uid 107); 18 May 2011 08:23:34 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 18 May 2011 04:23:34 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 18 May 2011 04:21:30 -0400
Content-Disposition: inline
In-Reply-To: <6301052eb455e9088e50f78760e6ca1b9499564a.1305646709.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173858>

On Tue, May 17, 2011 at 05:38:52PM +0200, Michael J Gruber wrote:

> The return codes of git_config_set() and friends are magic numbers right
> in the source. #define them in cache.h where the functions are declared,
> and use the constants in the source.
> 
> Also, mention the resulting exit codes of "git config" in its man page
> (and complete the list).

This version (and the accompanying 2/2) both look sane to me. Thanks for
taking time to clean up.

-Peff
