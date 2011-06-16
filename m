From: Jeff King <peff@peff.net>
Subject: Re: rewrite history
Date: Thu, 16 Jun 2011 16:13:00 -0400
Message-ID: <20110616201300.GA14674@sigill.intra.peff.net>
References: <362053118.20110616231758@gmail.com>
 <20110616192644.GB13466@sigill.intra.peff.net>
 <7vhb7ph8aj.fsf@alter.siamese.dyndns.org>
 <20110616194911.GA14355@sigill.intra.peff.net>
 <17721660.20110617000644@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Ilya Basin <basinilya@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 16 22:13:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QXIwS-0001RI-7l
	for gcvg-git-2@lo.gmane.org; Thu, 16 Jun 2011 22:13:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932664Ab1FPUNF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Jun 2011 16:13:05 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:54045
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932568Ab1FPUND (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Jun 2011 16:13:03 -0400
Received: (qmail 17830 invoked by uid 107); 16 Jun 2011 20:13:13 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 16 Jun 2011 16:13:13 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 16 Jun 2011 16:13:00 -0400
Content-Disposition: inline
In-Reply-To: <17721660.20110617000644@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175925>

On Fri, Jun 17, 2011 at 12:06:44AM +0400, Ilya Basin wrote:

> JK> I thought that was exactly what Ilya said with "X and X' have no
> JK> difference". I assumed that meant "they are semantically similar commits
> JK> on different bases" (i.e., a cherry-pick) and not "they have the exact
> JK> same tree state" (i.e., "git diff X X'" is empty).
> [...]
> sorry,
> git diff X X' is empty

Oh, then ignore everything I said. :)

I think you want to graft and filter-branch as Junio mentioned.

-Peff
