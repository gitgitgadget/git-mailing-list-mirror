From: Jeff King <peff@peff.net>
Subject: Re: gitk problems: can't unset "idinlist(...)"
Date: Sat, 21 Jul 2007 01:09:12 -0400
Message-ID: <20070721050912.GB20622@coredump.intra.peff.net>
References: <alpine.LFD.0.999.0707201554540.27249@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Paul Mackerras <paulus@samba.org>,
	Junio C Hamano <junkio@cox.net>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sat Jul 21 07:09:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IC7De-0001vC-AE
	for gcvg-git@gmane.org; Sat, 21 Jul 2007 07:09:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753264AbXGUFJ1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 Jul 2007 01:09:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750768AbXGUFJ1
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Jul 2007 01:09:27 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3848 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752827AbXGUFJP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Jul 2007 01:09:15 -0400
Received: (qmail 13178 invoked from network); 21 Jul 2007 05:09:43 -0000
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by peff.net with (DHE-RSA-AES128-SHA encrypted) SMTP; 21 Jul 2007 05:09:43 -0000
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 21 Jul 2007 01:09:13 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LFD.0.999.0707201554540.27249@woody.linux-foundation.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53137>

On Fri, Jul 20, 2007 at 04:05:54PM -0700, Linus Torvalds wrote:

> 	can't unset "idinlist(57d1c91fa6d9146b309b7511f6432dea2a24858b)": no such element in array
> [...]
> I'm not seeing anything interesting or special about that named commit, or 
> anything else that would make gitk unhappy. But it is.

Interestingly, I repeatably get the exact same error but with a
different commit:

  7ed40918a386afc2e14a6d3da563ea6d13686c25

which looks like a totally uninteresting commit.

I would expect, given that our repositories are at presumably the same
state, that we would get the same error at the same spot, but we don't.
Which implies to me there is some randomness, except that I get the
_same_ commit every time (and presumably so do you).

My master (and all other branches) are at c2e6805.

-Peff
