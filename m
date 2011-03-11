From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] Add Author and Documentation sections to
 git-for-each-ref.txt
Date: Fri, 11 Mar 2011 01:20:41 -0500
Message-ID: <20110311062041.GA20048@sigill.intra.peff.net>
References: <1299590170-30799-1-git-send-email-alcosholik@gmail.com>
 <1299590170-30799-3-git-send-email-alcosholik@gmail.com>
 <4D773570.4010803@drmicha.warpmail.net>
 <7voc5k9hfy.fsf@alter.siamese.dyndns.org>
 <20110310223732.GE15828@sigill.intra.peff.net>
 <7v4o7a3748.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Alexei Sholik <alcosholik@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 11 07:20:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PxviS-0004XK-W4
	for gcvg-git-2@lo.gmane.org; Fri, 11 Mar 2011 07:20:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751994Ab1CKGUo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Mar 2011 01:20:44 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:36676
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750905Ab1CKGUn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Mar 2011 01:20:43 -0500
Received: (qmail 3104 invoked by uid 107); 11 Mar 2011 06:21:14 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 11 Mar 2011 01:21:14 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 11 Mar 2011 01:20:41 -0500
Content-Disposition: inline
In-Reply-To: <7v4o7a3748.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168885>

On Thu, Mar 10, 2011 at 03:09:43PM -0800, Junio C Hamano wrote:

> > Yeah, I would just as soon drop Author and Documented-by fields in all
> > manpages. We could replace them with a single "Credits" in git(1). It
> > can either mention nobody, very few people (like Linus as the originator
> > and Junio as the long-time maintainer), or the top N (for N < 20 or so)
> > people in shortlog. And then mention that you can run shortlog yourself.
> 
> Sounds sensible.

If you want to see what the full patch would look like, you can fetch it
from:

  git://github.com/peff/git.git jk/doc-credits

The patch itself is rather large, so I didn't want to post it. I don't
know if we should extract the list of people who are being dropped and
check if they have any objection. You can get a partial list with:

   git show jk/doc-credits^ |
     grep ^- |
     perl -lne 'print for /<(.*?)>/g' |
     sort -u

though some people are mentioned only by name, not by email.

-Peff
