From: Jeff King <peff@peff.net>
Subject: Re: git send-email should not allow 'y' for in-reply-to
Date: Fri, 11 Jan 2013 16:23:25 -0500
Message-ID: <20130111212325.GA18193@sigill.intra.peff.net>
References: <A0DB01D693D8EF439496BC8B037A0AEF322039A7@xmb-rcd-x15.cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: "Matt Seitz (matseitz)" <matseitz@cisco.com>
X-From: git-owner@vger.kernel.org Fri Jan 11 22:23:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ttm4q-0007dA-0F
	for gcvg-git-2@plane.gmane.org; Fri, 11 Jan 2013 22:23:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754686Ab3AKVX2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jan 2013 16:23:28 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:57832 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753704Ab3AKVX1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jan 2013 16:23:27 -0500
Received: (qmail 24703 invoked by uid 107); 11 Jan 2013 21:24:42 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 11 Jan 2013 16:24:42 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 11 Jan 2013 16:23:25 -0500
Content-Disposition: inline
In-Reply-To: <A0DB01D693D8EF439496BC8B037A0AEF322039A7@xmb-rcd-x15.cisco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213245>

On Fri, Jan 11, 2013 at 08:13:57PM +0000, Matt Seitz (matseitz) wrote:

> > > How about "What Message-ID to use as In-Reply-To for the first email?"
> > > or "Provide the Message-ID to use as In-Reply-To for the first
> > > email:".
> > 
> > seem fine to me. Maybe somebody who has been confused by it can offer
> > more. At any rate, patches welcome.
> 
> Suggestion: "Message-ID to use as In-Reply-To for the first email:".
> 
> Simple and unlikely to generate a "y" or "n" response.  Putting
> "Message-ID" first makes it more obvious what data is being asked for
> by this prompt.

You'd think. But the existing message that has been causing problems is:

  Message-ID to be used as In-Reply-To for the first email?

which is more or less what you are proposing. I do think a colon rather
than a question mark helps indicate that the response is not yes/no.

-Peff
