From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] commit: use a priority queue in merge base functions
Date: Wed, 29 Aug 2012 16:55:25 -0400
Message-ID: <20120829205525.GA28696@sigill.intra.peff.net>
References: <20120829110812.GA14069@sigill.intra.peff.net>
 <20120829111147.GB14734@sigill.intra.peff.net>
 <7vtxvlwt7o.fsf@alter.siamese.dyndns.org>
 <20120829205332.GA16064@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Thomas Rast <trast@student.ethz.ch>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 29 22:55:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T6pIX-0000xW-Pz
	for gcvg-git-2@plane.gmane.org; Wed, 29 Aug 2012 22:55:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753724Ab2H2Uzb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Aug 2012 16:55:31 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:47370 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753059Ab2H2Uzb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Aug 2012 16:55:31 -0400
Received: (qmail 1998 invoked by uid 107); 29 Aug 2012 20:55:47 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 29 Aug 2012 16:55:47 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 29 Aug 2012 16:55:25 -0400
Content-Disposition: inline
In-Reply-To: <20120829205332.GA16064@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204497>

On Wed, Aug 29, 2012 at 04:53:32PM -0400, Jeff King wrote:

> > Thanks.  This seems to break t6010-merge-base.sh for me, though...
> 
> Interesting. It works fine here, even under --valgrind. Did you apply
> the patches directly on top of 1251cc7?

Hmm, this does seem to break t6024 for me, though.

-Peff
