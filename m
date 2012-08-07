From: Ben Walton <bwalton@artsci.utoronto.ca>
Subject: Re: [PATCH] Enable HAVE_DEV_TTY for Solaris
Date: Tue, 07 Aug 2012 11:31:48 -0400
Message-ID: <1344353369-sup-5103@pinkfloyd.chass.utoronto.ca>
References: <20120807003541.GA18219@sigill.intra.peff.net> <1344308862-24635-1-git-send-email-bwalton@artsci.utoronto.ca> <7v4nofxt89.fsf@alter.siamese.dyndns.org> <20120807040326.GA18682@sigill.intra.peff.net> <20120807041026.GA21918@sigill.intra.peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>,
	rctay89 <rctay89@gmail.com>, schwab <schwab@linux-m68k.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Aug 07 17:32:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sylld-0005Ny-FN
	for gcvg-git-2@plane.gmane.org; Tue, 07 Aug 2012 17:32:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752886Ab2HGPb6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Aug 2012 11:31:58 -0400
Received: from garcia.cquest.utoronto.ca ([192.82.128.9]:55287 "EHLO
	garcia.cquest.utoronto.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752170Ab2HGPb5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Aug 2012 11:31:57 -0400
Received: from pinkfloyd.chass.utoronto.ca ([128.100.160.254]:55241 ident=93)
	by garcia.cquest.utoronto.ca with esmtp (Exim 4.63)
	(envelope-from <bwalton@cquest.utoronto.ca>)
	id 1Syll6-0006j1-Np; Tue, 07 Aug 2012 11:31:48 -0400
Received: from bwalton by pinkfloyd.chass.utoronto.ca with local (Exim 4.72)
	(envelope-from <bwalton@cquest.utoronto.ca>)
	id 1Syll6-0002Me-Mj; Tue, 07 Aug 2012 11:31:48 -0400
In-reply-to: <20120807041026.GA21918@sigill.intra.peff.net>
User-Agent: Sup/git
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203029>

Excerpts from Jeff King's message of Tue Aug 07 00:10:26 -0400 2012:

> Signed-off-by: Jeff King <peff@peff.net>

Acked-by: Ben Walton <bwalton@artsci.utoronto.ca>

I agree with your assesment that this is the right way to go (vs
migrating out of stdio) for now.  If the changes Tay needs to make
require the migration then it can become part of that series.
Otherwise those changes would just be change for change's sake at this
time.

If my HAVE_DEV_TTY enabling patch for Solaris is added on top of this,
I'm a happy camper.

Thanks
-Ben
--
Ben Walton
Systems Programmer - CHASS
University of Toronto
C:416.407.5610 | W:416.978.4302
