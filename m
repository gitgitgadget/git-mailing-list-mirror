From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 0/3] Git commit --patch (again)
Date: Tue, 10 May 2011 15:56:47 -0400
Message-ID: <20110510195646.GC14456@sigill.intra.peff.net>
References: <1304748001-17982-1-git-send-email-conrad.irwin@gmail.com>
 <20110509144451.GA11362@sigill.intra.peff.net>
 <7vei47q0i6.fsf@alter.siamese.dyndns.org>
 <20110509220806.GC3719@sigill.intra.peff.net>
 <7vwrhzmnxf.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: conrad.irwin@gmail.com, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 10 21:56:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QJt39-0007Sx-Pq
	for gcvg-git-2@lo.gmane.org; Tue, 10 May 2011 21:56:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752282Ab1EJT4u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 May 2011 15:56:50 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:52163
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751829Ab1EJT4u (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 May 2011 15:56:50 -0400
Received: (qmail 25345 invoked by uid 107); 10 May 2011 19:58:46 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 10 May 2011 15:58:46 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 10 May 2011 15:56:47 -0400
Content-Disposition: inline
In-Reply-To: <7vwrhzmnxf.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173353>

On Mon, May 09, 2011 at 04:53:00PM -0700, Junio C Hamano wrote:

> -- >8 --
> From: Jeff King <peff@peff.net>
> Subject: [PATCH] t7501.8: feed a meaningful command
> 
> The command expects "git commit --interactive <path>" to fail because you
> cannot (yet) limit "commit --interactive" with a pathspec, but even if the
> command allowed to take <path>, the test would have failed as saying just
> 7:quit would leave the index the same as the current commit, leading to an
> attempt to create an empty commit that would fail without --allow-empty.
> 
> Signed-off-by: Jeff King <peff@peff.net>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>

Thanks. The commit message and SBO-forgery are fine by me. :)

-Peff
