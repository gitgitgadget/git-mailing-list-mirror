From: Jeff King <peff@peff.net>
Subject: Re: [RFD} Use regex's in :/ revision naming machinery
Date: Tue, 6 Apr 2010 00:31:34 -0400
Message-ID: <20100406043133.GA3901@coredump.intra.peff.net>
References: <alpine.LFD.2.00.1004051551180.21411@i5.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Apr 06 06:32:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nz0SR-0001RS-Bo
	for gcvg-git-2@lo.gmane.org; Tue, 06 Apr 2010 06:32:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751010Ab0DFEbx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Apr 2010 00:31:53 -0400
Received: from peff.net ([208.65.91.99]:45276 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750892Ab0DFEbw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Apr 2010 00:31:52 -0400
Received: (qmail 2608 invoked by uid 107); 6 Apr 2010 04:32:29 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 06 Apr 2010 00:32:29 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 06 Apr 2010 00:31:34 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.1004051551180.21411@i5.linux-foundation.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144095>

On Mon, Apr 05, 2010 at 04:00:59PM -0700, Linus Torvalds wrote:

> So this is very much debatable, but I'm including a patch for the 
> discussion to start.

FWIW, this came up quite a while ago and people generally seemed to
think it was a good idea, but the patch from Dscho (cc'd) never made it
upstream.

The old thread is here:

  http://article.gmane.org/gmane.comp.version-control.git/50010

Personally, I think regex matching makes :/ a bit more usable, though
since that thread I have found I don't use :/ all that often (instead
needing to pick through the results of --grep looking for the commit in
question, at which point I just cut-and-paste the commit sha1). I agree
as was suggested elsewhere in the thread that searching from HEAD would
help.

-Peff
