From: Jeff King <peff@peff.net>
Subject: Re: [RFC PATCH] git log: support "auto" decorations
Date: Fri, 30 May 2014 14:39:57 -0400
Message-ID: <20140530183957.GA3909@sigill.intra.peff.net>
References: <alpine.LFD.2.11.1405291523520.8270@i7.linux-foundation.org>
 <20140530015855.GG28683@sigill.intra.peff.net>
 <CA+55aFzwy09-i=hpBy-5bYS6eowGzkdcF65cFJpL2qnJvYq85w@mail.gmail.com>
 <20140530065737.GA13591@sigill.intra.peff.net>
 <xmqqvbsn9pfx.fsf@gitster.dls.corp.google.com>
 <20140530170330.GA25443@sigill.intra.peff.net>
 <xmqqmwdz9nl9.fsf@gitster.dls.corp.google.com>
 <20140530183441.GA3704@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 30 20:40:04 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WqRil-0008JZ-Li
	for gcvg-git-2@plane.gmane.org; Fri, 30 May 2014 20:40:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933056AbaE3Sj7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 May 2014 14:39:59 -0400
Received: from cloud.peff.net ([50.56.180.127]:34336 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753232AbaE3Sj7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 May 2014 14:39:59 -0400
Received: (qmail 24415 invoked by uid 102); 30 May 2014 18:39:59 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 30 May 2014 13:39:59 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 30 May 2014 14:39:57 -0400
Content-Disposition: inline
In-Reply-To: <20140530183441.GA3704@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250464>

On Fri, May 30, 2014 at 02:34:41PM -0400, Jeff King wrote:

> On Fri, May 30, 2014 at 10:35:14AM -0700, Junio C Hamano wrote:
> 
> > > Do you want me to roll it up with a real commit message?
> > 
> > Yes.  I think the change is sensible.
> 
> Here it is. [...]

By the way, I rather derailed Linus's original patch with this
sub-thread. I think it actually looks fine as-is. The shortcomings he
listed are all there, but I think addressing them would end up even
worse.

-Peff
