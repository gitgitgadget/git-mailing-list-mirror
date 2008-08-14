From: Jeff King <peff@peff.net>
Subject: Re: Why doesn't git-apply remove empty file
Date: Thu, 14 Aug 2008 16:54:47 -0400
Message-ID: <20080814205447.GC25469@sigill.intra.peff.net>
References: <38b2ab8a0808120917h10f15c81v4d1f04c0174dc994@mail.gmail.com> <7vod3xpxq2.fsf@gitster.siamese.dyndns.org> <38b2ab8a0808130048t506dbb7ah1d6fcd6bd4f3c90c@mail.gmail.com> <48A357BA.8060003@lsrfire.ath.cx> <alpine.LFD.1.10.0808131602200.3462@nehalem.linux-foundation.org> <38b2ab8a0808141242k4bd6867dt8ef54f160713061f@mail.gmail.com> <alpine.LFD.1.10.0808141246190.3324@nehalem.linux-foundation.org> <alpine.LFD.1.10.0808141258180.3324@nehalem.linux-foundation.org> <20080814202159.GD7138@leksak.fem-net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Francis Moreau <francis.moro@gmail.com>,
	=?utf-8?B?UmVuw6k=?= Scharfe <rene.scharfe@lsrfire.ath.cx>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Stephan Beyer <s-beyer@gmx.net>
X-From: git-owner@vger.kernel.org Thu Aug 14 22:55:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KTjrO-0006N5-OL
	for gcvg-git-2@gmane.org; Thu, 14 Aug 2008 22:55:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752781AbYHNUyu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Aug 2008 16:54:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752500AbYHNUyt
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Aug 2008 16:54:49 -0400
Received: from peff.net ([208.65.91.99]:2515 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750738AbYHNUyt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Aug 2008 16:54:49 -0400
Received: (qmail 14135 invoked by uid 111); 14 Aug 2008 20:54:48 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Thu, 14 Aug 2008 16:54:48 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 14 Aug 2008 16:54:47 -0400
Content-Disposition: inline
In-Reply-To: <20080814202159.GD7138@leksak.fem-net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92398>

On Thu, Aug 14, 2008 at 10:21:59PM +0200, Stephan Beyer wrote:

> Instead of generating reject files it puts conflict markers into the file.
> (If no context matches at all, then perhaps just insert them at the lines
> that the hunk header says.)
> And then declaring the files as "unmerged", so that you can see it in
> git status.

I use "git am -3" for that. Then you get conflict markers, or you can
use git-mergetool.

-Peff
