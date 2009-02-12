From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/3] builtin-remote: teach show to display remote HEAD
Date: Wed, 11 Feb 2009 20:56:00 -0500
Message-ID: <20090212015559.GB3187@sigill.intra.peff.net>
References: <1234332083-45147-1-git-send-email-jaysoffian@gmail.com> <1234332083-45147-2-git-send-email-jaysoffian@gmail.com> <1234332083-45147-3-git-send-email-jaysoffian@gmail.com> <20090212002612.GC30231@coredump.intra.peff.net> <76718490902111748j58f80591ma149f8ec9fb8b352@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, gitster@pobox.com
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 12 02:57:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXQpZ-0001BV-M9
	for gcvg-git-2@gmane.org; Thu, 12 Feb 2009 02:57:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755629AbZBLB4H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Feb 2009 20:56:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754748AbZBLB4E
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Feb 2009 20:56:04 -0500
Received: from peff.net ([208.65.91.99]:34727 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753248AbZBLB4E (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Feb 2009 20:56:04 -0500
Received: (qmail 4726 invoked by uid 107); 12 Feb 2009 01:56:19 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Wed, 11 Feb 2009 20:56:19 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 11 Feb 2009 20:56:00 -0500
Content-Disposition: inline
In-Reply-To: <76718490902111748j58f80591ma149f8ec9fb8b352@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109558>

On Wed, Feb 11, 2009 at 08:48:42PM -0500, Jay Soffian wrote:

> Damn, I knew I wasn't going to slip that one by. :-)

"Given enough eyeballs, all ugly hacks are shallow." :)

> > I see that the inputs and outputs aren't exactly the same in both cases,
> 
> Which is why I didn't refactor it. The extra code needed to massage
> what builtin-remote.c has to the existing function in builtin-clone.c
> would've been more LOC than the duplicate code (I think...).
> 
> BUT
> 
> I'll try. :-)

See what you can do. But personally, I am not as concerned with reducing
LOC as I am with encapsulating system logic like "this is how you guess
which ref is HEAD". And if you can do both, great. :)

-Peff
