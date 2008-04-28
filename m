From: Jeff King <peff@peff.net>
Subject: Re: [PATCH resend] make "git push" update origin and mirrors, "git
	push --mirror" update mirrors
Date: Sun, 27 Apr 2008 21:26:13 -0400
Message-ID: <20080428012613.GB15121@sigill.intra.peff.net>
References: <4812DA50.3000702@gnu.org> <20080426170126.GC29771@spearce.org> <7vzlrgmrvb.fsf@gitster.siamese.dyndns.org> <20080427043014.GI29771@spearce.org> <20080427044049.GJ29771@spearce.org> <7vabjflvlh.fsf@gitster.siamese.dyndns.org> <20080427173446.GM29771@spearce.org> <7vy76zf449.fsf@gitster.siamese.dyndns.org> <4814E097.7030407@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Paolo Bonzini <bonzini@gnu.org>
X-From: git-owner@vger.kernel.org Mon Apr 28 03:27:11 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JqI92-0000XE-Ac
	for gcvg-git-2@gmane.org; Mon, 28 Apr 2008 03:27:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752939AbYD1B0R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Apr 2008 21:26:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752255AbYD1B0R
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Apr 2008 21:26:17 -0400
Received: from peff.net ([208.65.91.99]:1182 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752066AbYD1B0Q (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Apr 2008 21:26:16 -0400
Received: (qmail 6866 invoked by uid 111); 28 Apr 2008 01:26:14 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Sun, 27 Apr 2008 21:26:14 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 27 Apr 2008 21:26:13 -0400
Content-Disposition: inline
In-Reply-To: <4814E097.7030407@gnu.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80495>

On Sun, Apr 27, 2008 at 10:22:47PM +0200, Paolo Bonzini wrote:

> I think "git pull" is different, because it is more often fetching from  
> one defined place (while Shawn said that he has a need for one-to-many  
> "git push"es and so do I).  For "git pull", the branch config provides a  
> valuable default more often than for "git push".

I think it is highly dependent on your workflow. I would have said the
exact opposite.

For example, on one project, I keep a "working" repo on my laptop where
I develop and integrate work from others. I get their work by pulling
individually from other developers. But when I push, it always goes to
one place: my "publish" repo, where the other developers will grab my
changes.

In that workflow, I pull from many different places, but always push to
one. I assumed that is actually similar to the Linus "integrator"
workflow (although I think he just does one-shot pulls without defining
remotes).

-Peff
