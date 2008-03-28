From: Jeff King <peff@peff.net>
Subject: Re: [ANNOUNCE] GIT 1.5.5-rc2
Date: Fri, 28 Mar 2008 17:27:01 -0400
Message-ID: <20080328212700.GA9529@coredump.intra.peff.net>
References: <7viqz72we4.fsf@gitster.siamese.dyndns.org> <20080328181345.GB8299@coredump.intra.peff.net> <7vtziq1rwa.fsf@gitster.siamese.dyndns.org> <20080328212340.GC9131@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 28 22:27:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JfM72-0006C0-KM
	for gcvg-git-2@gmane.org; Fri, 28 Mar 2008 22:27:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755363AbYC1V1G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Mar 2008 17:27:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755413AbYC1V1E
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Mar 2008 17:27:04 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4337 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755363AbYC1V1E (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Mar 2008 17:27:04 -0400
Received: (qmail 7854 invoked by uid 111); 28 Mar 2008 21:27:02 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Fri, 28 Mar 2008 17:27:02 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 28 Mar 2008 17:27:01 -0400
Content-Disposition: inline
In-Reply-To: <20080328212340.GC9131@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78440>

On Fri, Mar 28, 2008 at 05:23:40PM -0400, Jeff King wrote:

> > I was getting the impression that it was still in "ah, but this is
> > better", "you are right, but how about doing this", stage and was hoping
> > that "ok, based on the discussion here is the final one" will come soon.
> 
> Ah. I think the current status is "here are two patches that work, but
> will always assume utf-8 encoding" which I think is not unreasonable as
> a bugfix. A nice feature would be to allow setting the encoding, but:

After sending my lengthy response, I realized that you might have
actually been talking about the minor fixups that happened, and missed
the "correct" 2/2 which was sent later in the thread. So following this
are the most up-to-date versions. 1/1 is the same as the original, 2/2
does Teemu's "let user set subject in editor" suggestion, plus the
follow-on syntax fixup.

-Peff
