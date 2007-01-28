From: Jeff King <peff@peff.net>
Subject: Re: More precise tag following
Date: Sun, 28 Jan 2007 08:15:59 -0500
Message-ID: <20070128131559.GA31217@coredump.intra.peff.net>
References: <7vy7nqxd08.fsf@assigned-by-dhcp.cox.net> <20070127080126.GC9966@spearce.org> <Pine.LNX.4.64.0701270837170.25027@woody.linux-foundation.org> <20070127201640.GA25637@coredump.intra.peff.net> <Pine.LNX.4.64.0701271432450.25027@woody.linux-foundation.org> <20070127235238.GA28706@coredump.intra.peff.net> <20070128023958.GF9897@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Theodore Tso <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Sun Jan 28 14:16:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HB9tH-0002BT-49
	for gcvg-git@gmane.org; Sun, 28 Jan 2007 14:16:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932524AbXA1NQE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 28 Jan 2007 08:16:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932412AbXA1NQE
	(ORCPT <rfc822;git-outgoing>); Sun, 28 Jan 2007 08:16:04 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1619 "HELO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932524AbXA1NQD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Jan 2007 08:16:03 -0500
Received: (qmail 8033 invoked from network); 28 Jan 2007 08:16:25 -0500
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by 66-23-211-5.clients.speedfactory.net with SMTP; 28 Jan 2007 08:16:25 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 28 Jan 2007 08:15:59 -0500
Content-Disposition: inline
In-Reply-To: <20070128023958.GF9897@thunk.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38032>

On Sat, Jan 27, 2007 at 09:39:58PM -0500, Theodore Tso wrote:

> For emacs users, it would even be better to tie it into emacs.  That
> way you're already at the line number looking at the source code when

I agree that connecting it with the editor might be sensible; I'm not
likely to work on an emacs version, though. :)

One of my other long-standing annoyances with using "raw" git-blame is
that it shows me a bunch of commits, but then I have to open a new
window and cut and paste the hash to actually _see_ the commit. That's
why I think something like tig makes sense, where you can jump between
different views very easily. An editor extension should be able to do
the same thing.

> course, scrolling to the right part of the file is a pain.  So
> building it into the editor is not only convenient, but it avoids the
> psychological effects that could make it seem slow because how long it
> takes to fill the attribution for these first bits:

Agreed, I noticed that as well (especially because the enormous font and
spacing choices of GTK made sure you could only see the first couple of
lines :) ).

> is there?).  I have no idea how you would hack this into Vim, other
> than passing the line number into the GUI so it can open right into
> the function that the developer was looking at.

I'll look into what's out there for vim; there's quite a bit of
extensibility if you buy into things like the perl support.

-Peff
