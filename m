From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] git-rm.txt: Fix quoting
Date: Tue, 7 Dec 2010 11:43:15 -0500
Message-ID: <20101207164315.GA21749@sigill.intra.peff.net>
References: <4CFDF388.6060907@drmicha.warpmail.net>
 <73d13b752212b557c0dc157edea9a62122840e93.1291712241.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue Dec 07 17:43:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQ0dQ-000124-D0
	for gcvg-git-2@lo.gmane.org; Tue, 07 Dec 2010 17:43:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755125Ab0LGQnT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Dec 2010 11:43:19 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:60237 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755105Ab0LGQnS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Dec 2010 11:43:18 -0500
Received: (qmail 25270 invoked by uid 111); 7 Dec 2010 16:43:17 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Tue, 07 Dec 2010 16:43:17 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 07 Dec 2010 11:43:15 -0500
Content-Disposition: inline
In-Reply-To: <73d13b752212b557c0dc157edea9a62122840e93.1291712241.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163088>

On Tue, Dec 07, 2010 at 10:07:11AM +0100, Michael J Gruber wrote:

> Literal " produces typographically incorrect quotations, but "works" in
> most circumstances. In the subheadings of git-rm.txt, it "works" for the
> html backend but not for the docbook conversion to nroff: double "" and
> spurious double spaces appear in the output.
> 
> Replace "incorrect" quotations by ``correct'' ones, and fix other
> "quotations" which are really `code fragments`.
> 
> This should make git-rm.txt "-clean.

Thanks, this is a much better solution than what I posted earlier.

Acked-by: Jeff King <peff@peff.net>

> We still have a lingering inconsistency for denoting code fragments.
> Single backticks merely are a literal monospaced environment; html outputcolors
> this, nroff does not indicate it at all. I'm staying consistent with the
> surrounding text here.

Try setting MAN_BOLD_LITERAL in your config.mak.

-Peff
