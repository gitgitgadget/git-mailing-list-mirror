From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] add a 'pre-push' hook
Date: Tue, 19 Aug 2008 20:15:33 -0400
Message-ID: <20080820001532.GA24361@sigill.intra.peff.net>
References: <1219170876-46893-1-git-send-email-schacon@gmail.com> <d411cc4a0808191155g188b0f10je5fd79afb92f36ef@mail.gmail.com> <20080819185804.GA17943@coredump.intra.peff.net> <d411cc4a0808191200o39837fd0ka2530aed870e06b0@mail.gmail.com> <20080819190832.GC17943@coredump.intra.peff.net> <48AB48A8.80904@vilain.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Scott Chacon <schacon@gmail.com>, git@vger.kernel.org,
	gitster@pobox.com
To: Sam Vilain <sam@vilain.net>
X-From: git-owner@vger.kernel.org Wed Aug 20 02:16:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVbNS-0000iX-N7
	for gcvg-git-2@gmane.org; Wed, 20 Aug 2008 02:16:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753377AbYHTAPj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Aug 2008 20:15:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753336AbYHTAPj
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Aug 2008 20:15:39 -0400
Received: from peff.net ([208.65.91.99]:3281 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752837AbYHTAPi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Aug 2008 20:15:38 -0400
Received: (qmail 9024 invoked by uid 111); 20 Aug 2008 00:15:37 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Tue, 19 Aug 2008 20:15:37 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 19 Aug 2008 20:15:33 -0400
Content-Disposition: inline
In-Reply-To: <48AB48A8.80904@vilain.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92943>

On Wed, Aug 20, 2008 at 10:26:48AM +1200, Sam Vilain wrote:

> > I think the common wisdom has been that such tests should be done on the
> > _receiving_ end, since that makes a more trustworthy enforcement point.
> 
> Probably true, but if someone wants to arrange it the other way around,
> what harm is there in that?

Read the rest of the message you are quoting where I say basically that.

-Peff
