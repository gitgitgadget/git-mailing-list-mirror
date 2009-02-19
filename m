From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] add basic branch display tests
Date: Wed, 18 Feb 2009 22:53:32 -0500
Message-ID: <20090219035332.GC19862@coredump.intra.peff.net>
References: <20090219033329.GA13666@coredump.intra.peff.net> <20090219033444.GA18970@coredump.intra.peff.net> <20090219034504.GA19862@coredump.intra.peff.net> <76718490902181951p54dc222ai5ac6397f3471fc44@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 19 04:55:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1La00N-0005A1-Cr
	for gcvg-git-2@gmane.org; Thu, 19 Feb 2009 04:55:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751905AbZBSDxf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Feb 2009 22:53:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751881AbZBSDxf
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Feb 2009 22:53:35 -0500
Received: from peff.net ([208.65.91.99]:54117 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751861AbZBSDxe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Feb 2009 22:53:34 -0500
Received: (qmail 19196 invoked by uid 107); 19 Feb 2009 03:53:55 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 18 Feb 2009 22:53:55 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 18 Feb 2009 22:53:32 -0500
Content-Disposition: inline
In-Reply-To: <76718490902181951p54dc222ai5ac6397f3471fc44@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110620>

On Wed, Feb 18, 2009 at 10:51:27PM -0500, Jay Soffian wrote:

> On Wed, Feb 18, 2009 at 10:45 PM, Jeff King <peff@peff.net> wrote:
> > But here we stick the "remotes/" head on, since we are showing both
> > types. But the right hand side of the symref doesn't get the same
> > treatment.
> >
> > I don't think it's a big deal, but I wasn't sure if it was intentional,
> 
> It was intentional on my part. I thought appending it a second time
> was redundant, and the remotes/ prefix on the LHS is just their to
> distinguish remote branches from local.

OK. The more I think about it, the more I think what is currently there
is best.

> Thanks for the tests. If I had added them myself I wouldn't have you
> publicly questioning my intent. ;-)

You're welcome. :)

-Peff
