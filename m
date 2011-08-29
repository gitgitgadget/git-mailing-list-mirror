From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 1/2] check-ref-format --print: Normalize refnames that
 start with slashes
Date: Mon, 29 Aug 2011 15:01:18 -0400
Message-ID: <20110829190118.GE756@sigill.intra.peff.net>
References: <1314418364-2532-1-git-send-email-mhagger@alum.mit.edu>
 <1314418364-2532-2-git-send-email-mhagger@alum.mit.edu>
 <4E58710B.60507@alum.mit.edu>
 <7vty92adv0.fsf@alter.siamese.dyndns.org>
 <20110829185011.GC756@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org,
	cmn@elego.de
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 29 21:01:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qy75T-0001cX-Hw
	for gcvg-git-2@lo.gmane.org; Mon, 29 Aug 2011 21:01:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754832Ab1H2TBY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Aug 2011 15:01:24 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:47914
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754828Ab1H2TBU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Aug 2011 15:01:20 -0400
Received: (qmail 19381 invoked by uid 107); 29 Aug 2011 19:02:05 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 29 Aug 2011 15:02:05 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 29 Aug 2011 15:01:18 -0400
Content-Disposition: inline
In-Reply-To: <20110829185011.GC756@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180330>

On Mon, Aug 29, 2011 at 02:50:12PM -0400, Jeff King wrote:

>   3. Having better tool support for comparing two sets of commits. The
>      ideal interface (to me) for this workflow would be something like:

BTW, this discussion is obviously about comparing what was applied
upstream with what was submitted, but I think such a tool could have
other purposes, too. It should be able to provide a much nicer interdiff
between two versions of the same series (e.g., for reviewers looking at
a re-roll). You could even use it as maintainer to apply a re-roll,
giving you a chance to review the differences as you apply.

-Peff
