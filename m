From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] fetch-pack: Finish negotation if remote replies "ACK
 %s ready"
Date: Thu, 17 Mar 2011 03:16:01 -0400
Message-ID: <20110317071600.GG11931@sigill.intra.peff.net>
References: <1300146519-26508-1-git-send-email-spearce@spearce.org>
 <20110317071512.GF11931@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Mar 17 08:16:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q07RI-0002aB-Lq
	for gcvg-git-2@lo.gmane.org; Thu, 17 Mar 2011 08:16:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751846Ab1CQHQE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Mar 2011 03:16:04 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:48440
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751694Ab1CQHQD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Mar 2011 03:16:03 -0400
Received: (qmail 21126 invoked by uid 107); 17 Mar 2011 07:16:37 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 17 Mar 2011 03:16:37 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 17 Mar 2011 03:16:01 -0400
Content-Disposition: inline
In-Reply-To: <20110317071512.GF11931@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169216>

On Thu, Mar 17, 2011 at 03:15:12AM -0400, Jeff King wrote:

> > Assuming the client is only following the remote (and does not make
> > its own local commits), the client needs 11 rounds to spin through
> > the entire list of tags (32 commits per round, ceil(339/32) == 11).
> > Unfortunately the server knows on the first "have %s" line that
> > it can produce a good pack, and does not need to see the remaining
> > 320 tags in the other 10 rounds.
> 
> Does this optimization help in that case? From looking at the code, it
> seems that we offer "ACK %s ready" only in the case that the client
> has something we do not. I.e., they _are_ building local commits on top.

OK, never mind, I just read your 2/2. ;)

Sorry for the noise.

-Peff
