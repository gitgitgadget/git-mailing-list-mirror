From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] docs: brush up obsolete bits of git-fsck manpage
Date: Fri, 16 Dec 2011 20:28:11 -0500
Message-ID: <20111217012811.GC20225@sigill.intra.peff.net>
References: <20111216113310.GA16601@sigill.intra.peff.net>
 <7vy5ucgsic.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Dec 17 02:28:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rbj4e-0006tu-6m
	for gcvg-git-2@lo.gmane.org; Sat, 17 Dec 2011 02:28:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760692Ab1LQB2S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Dec 2011 20:28:18 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:44495
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752771Ab1LQB2O (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Dec 2011 20:28:14 -0500
Received: (qmail 9413 invoked by uid 107); 17 Dec 2011 01:34:56 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 16 Dec 2011 20:34:56 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 16 Dec 2011 20:28:11 -0500
Content-Disposition: inline
In-Reply-To: <7vy5ucgsic.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187345>

On Fri, Dec 16, 2011 at 12:40:11PM -0800, Junio C Hamano wrote:

> By the way did you hand-tweak your patch in any way?
> 
> I am not complaining that it does not apply (it does), but I am curious
> how you got the line that begins with "corruption it finds ..." neatly in
> preimage and postimage; it could become a common line but doing so makes
> the patch unreadable and that is what I am getting from "git show" after
> applying the patch.

No, I don't think I tweaked it at all. You can fetch the original commit
(888b4eb) at:

  git://github.com/peff/git.git jk/fsck-docs

Running "git show" produces the same output as the patch I sent. I
double-checked with older versions of git, and they all produce the same
output for me. Ditto for applying what I sent and running "git show" on
the result.

Using "--patience", on the other hand, does find it as a common line,
Weird.

-Peff
