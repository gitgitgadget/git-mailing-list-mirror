From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Demonstrate failure of 'core.ignorecase = true'
Date: Thu, 22 Mar 2012 15:07:05 -0400
Message-ID: <20120322190705.GB27037@sigill.intra.peff.net>
References: <1332370222-5123-1-git-send-email-pj@irregularexpressions.net>
 <4F6ACB67.1080503@viscovery.net>
 <4F6B0C3E.8090501@in.waw.pl>
 <20120322141245.GB8803@sigill.intra.peff.net>
 <7vbonozi8c.fsf@alter.siamese.dyndns.org>
 <20120322173701.GA11928@sigill.intra.peff.net>
 <7viphwxyp1.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>,
	Johannes Sixt <j.sixt@viscovery.net>,
	"Peter J. Weisberg" <pj@irregularexpressions.net>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 22 20:07:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SAnM4-0001i8-W8
	for gcvg-git-2@plane.gmane.org; Thu, 22 Mar 2012 20:07:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759304Ab2CVTHW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Mar 2012 15:07:22 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:56860
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753015Ab2CVTHH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Mar 2012 15:07:07 -0400
Received: (qmail 4208 invoked by uid 107); 22 Mar 2012 19:07:22 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 22 Mar 2012 15:07:22 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 22 Mar 2012 15:07:05 -0400
Content-Disposition: inline
In-Reply-To: <7viphwxyp1.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193690>

On Thu, Mar 22, 2012 at 11:44:42AM -0700, Junio C Hamano wrote:

> I wanted it to tell *what* happens when core.ignorecase is set.  In other
> words, I wanted the description to say that the logic employed is to work
> around what case-insensitive filesystems do.  Case sensitive filesystems
> obviously do not do what case-insensitive ones do (like reporting a
> "Makefile" exists when only "makefile" exists), so I hoped that it was
> clear enough that the additional logic would not be suitable there.

Ah. I see now why you made the change you did. But if I missed it,
perhaps it was too subtle (of course, I found the other one perfectly
adequate, so...).

> I guess we really need to make the description foolproof then.
> 
>                    ... exists on them is "makefile". By setting this
> 	variable to `true`, Git employs logic to work around them.
>         Setting this to `true` on a case insensitive filesystem does
> 	not make any sense, because it would not magically make your
> 	system to treat your filesystem case insensitively.

I'm OK with that (modulo s/insensitive/sensitive/ on the third line).
It may be overly explicit, but I would rather err on that side.

-Peff
