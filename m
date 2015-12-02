From: Jeff King <peff@peff.net>
Subject: Re: Bug: Incorrect stripping of the [PATCH] prefix in git-am
Date: Wed, 2 Dec 2015 10:49:48 -0500
Message-ID: <20151202154948.GA9525@sigill.intra.peff.net>
References: <5655D3DA.1050403@informatik.uni-hamburg.de>
 <5655D755.8060503@atlas-elektronik.com>
 <5655DAE7.2000008@informatik.uni-hamburg.de>
 <20151202005826.GE28197@sigill.intra.peff.net>
 <565EE63A.3040006@informatik.uni-hamburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Stefan Beller <sbeller@google.com>,
	stefan.naewe@atlas-elektronik.com, git@vger.kernel.org
To: huebbe <nathanael.huebbe@informatik.uni-hamburg.de>
X-From: git-owner@vger.kernel.org Wed Dec 02 16:50:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a49fM-0000gU-5F
	for gcvg-git-2@plane.gmane.org; Wed, 02 Dec 2015 16:50:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932832AbbLBPty (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Dec 2015 10:49:54 -0500
Received: from cloud.peff.net ([50.56.180.127]:36283 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932821AbbLBPtv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Dec 2015 10:49:51 -0500
Received: (qmail 20781 invoked by uid 102); 2 Dec 2015 15:49:51 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 02 Dec 2015 09:49:51 -0600
Received: (qmail 31153 invoked by uid 107); 2 Dec 2015 15:49:53 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 02 Dec 2015 10:49:53 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 02 Dec 2015 10:49:48 -0500
Content-Disposition: inline
In-Reply-To: <565EE63A.3040006@informatik.uni-hamburg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281889>

On Wed, Dec 02, 2015 at 01:38:18PM +0100, huebbe wrote:

> As such, I would like to ask whether it would be possible/sensible
> to somehow escape square brackets, or mark the beginning
> of the original commit message in the `git format-patch` output?
> This would allow `git am` to reproduce the exact commit message by default
> without breaking the "[]" convention.

I am not sure why "git format-patch -k | git am -k" does not do what you
want. That is what those options were added for (and what git-rebase
uses internally to make sure commit messages are left unmunged).

-Peff
