From: Theodore Tso <tytso@mit.edu>
Subject: Re: [PATCH] Make '!' aliases more useful
Date: Mon, 2 Jul 2007 12:08:10 -0400
Message-ID: <20070702160810.GD4720@thunk.org>
References: <Pine.LNX.4.64.0707012249590.4438@racer.site> <20070702145549.GB4720@thunk.org> <Pine.LNX.4.64.0707021654450.4071@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jul 02 18:08:20 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I5ORn-0004gA-6Q
	for gcvg-git@gmane.org; Mon, 02 Jul 2007 18:08:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753566AbXGBQIO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 2 Jul 2007 12:08:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753915AbXGBQIO
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Jul 2007 12:08:14 -0400
Received: from THUNK.ORG ([69.25.196.29]:39416 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753548AbXGBQIN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jul 2007 12:08:13 -0400
Received: from root (helo=candygram.thunk.org)
	by thunker.thunk.org with local-esmtps 
	(tls_cipher TLS-1.0:RSA_AES_256_CBC_SHA:32)  (Exim 4.50 #1 (Debian))
	id 1I5OZW-0005GI-Po; Mon, 02 Jul 2007 12:16:18 -0400
Received: from tytso by candygram.thunk.org with local (Exim 4.63)
	(envelope-from <tytso@thunk.org>)
	id 1I5ORe-0001Ty-KT; Mon, 02 Jul 2007 12:08:10 -0400
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0707021654450.4071@racer.site>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51378>

On Mon, Jul 02, 2007 at 04:55:24PM +0100, Johannes Schindelin wrote:
> > But what if you don't want the argument passed at the end of the
> > alias, but somewhere else?  I suspect the better answer would be to
> > support $* and $1, $2, $3, et. al interpolation, no?  It was on my
> > list of things to do when I had a spare moment, but I never got around
> > to it.
> 
> There is a point where you do not want to complicate git, but rather write 
> a script. This is such a point IMHO.

Such a point exists, I agree, but I would draw after $* and $1/$2/$3
interpolation.  There is a lot more value that gets added with
positional arguments support, and it makes git aliases more usable on
platforms such as Windows where scripting capability is much more
limited.

Regards,

					- Ted
