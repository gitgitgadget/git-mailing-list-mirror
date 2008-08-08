From: Jeff King <peff@peff.net>
Subject: Re: git diff/log --check exitcode and PAGER environment variable
Date: Fri, 8 Aug 2008 09:19:33 -0400
Message-ID: <20080808131933.GB19705@sigill.intra.peff.net>
References: <489C145B.5090400@sneakemail.com> <7vfxpfet8a.fsf@gitster.siamese.dyndns.org> <20080808131759.GA19705@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Peter Valdemar =?utf-8?B?TcO4cmNoIChMaXN0cyk=?= 
	<4ux6as402@sneakemail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 08 15:20:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KRRtU-0006fy-PW
	for gcvg-git-2@gmane.org; Fri, 08 Aug 2008 15:20:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752901AbYHHNTf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Aug 2008 09:19:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752857AbYHHNTf
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Aug 2008 09:19:35 -0400
Received: from peff.net ([208.65.91.99]:2990 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752647AbYHHNTe (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Aug 2008 09:19:34 -0400
Received: (qmail 20020 invoked by uid 111); 8 Aug 2008 13:19:34 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Fri, 08 Aug 2008 09:19:34 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 08 Aug 2008 09:19:33 -0400
Content-Disposition: inline
In-Reply-To: <20080808131759.GA19705@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91663>

On Fri, Aug 08, 2008 at 09:17:59AM -0400, Jeff King wrote:

> Yes, all of his testing with "git diff" is hampered by the pager hiding
> the exit code. And that is dealt with by the patches in next (and I
> tested his examples with 'next', and they work fine).
> 
> But that still leaves the part about "git log" not changing its exit
> code. I don't think it has ever been designed to, and I'm not even sure
> what the semantics would be (exit code != 0 if any logged commit has a
> whitespace problem? That seems the most logical, and it might be useful
> for limited ranges).

...and then after writing this I realized that all of this was dealt
with later in the thread. Sorry for the noise.

-Peff
