From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/3] Reduced re-roll of http-proxy-more branch
Date: Fri, 11 May 2012 13:00:13 -0400
Message-ID: <20120511170013.GA26916@sigill.intra.peff.net>
References: <4FAD1075.8020309@seap.minhap.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Nelson Benitez Leon <nelsonjesus.benitez@seap.minhap.es>
X-From: git-owner@vger.kernel.org Fri May 11 19:00:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SStCc-0005sh-Pv
	for gcvg-git-2@plane.gmane.org; Fri, 11 May 2012 19:00:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932619Ab2EKRAV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 May 2012 13:00:21 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:40043
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932559Ab2EKRAT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 May 2012 13:00:19 -0400
Received: (qmail 12791 invoked by uid 107); 11 May 2012 17:00:39 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 11 May 2012 13:00:39 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 11 May 2012 13:00:13 -0400
Content-Disposition: inline
In-Reply-To: <4FAD1075.8020309@seap.minhap.es>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197679>

On Fri, May 11, 2012 at 03:13:25PM +0200, Nelson Benitez Leon wrote:

> Hi, based on last feedback by Junio and Jeff I've created this
> reduced version of http-proxy-more branch with all the bits
> about "reading proxy from environment" removed. When cURL adds
> the new api we will only need to expand the code introduced by
> commit 1/3 .

Thanks. I know it is frustrating to work on a series only to end up
discarding a big chunk of it. But I think the result here makes a lot
more sense in the long run.

Patches 2 and 3 look OK, but I have a few comments on the first one
(I'll reply separately).

-Peff
