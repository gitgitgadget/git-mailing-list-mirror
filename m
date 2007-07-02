From: Theodore Tso <tytso@mit.edu>
Subject: Re: [PATCH] Make '!' aliases more useful
Date: Mon, 2 Jul 2007 10:55:49 -0400
Message-ID: <20070702145549.GB4720@thunk.org>
References: <Pine.LNX.4.64.0707012249590.4438@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jul 02 16:56:25 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I5NKA-0004cb-Uv
	for gcvg-git@gmane.org; Mon, 02 Jul 2007 16:56:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756456AbXGBOzx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 2 Jul 2007 10:55:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756726AbXGBOzx
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Jul 2007 10:55:53 -0400
Received: from THUNK.ORG ([69.25.196.29]:35328 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755924AbXGBOzw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jul 2007 10:55:52 -0400
Received: from root (helo=candygram.thunk.org)
	by thunker.thunk.org with local-esmtps 
	(tls_cipher TLS-1.0:RSA_AES_256_CBC_SHA:32)  (Exim 4.50 #1 (Debian))
	id 1I5NRV-0004xw-Dy; Mon, 02 Jul 2007 11:03:57 -0400
Received: from tytso by candygram.thunk.org with local (Exim 4.63)
	(envelope-from <tytso@thunk.org>)
	id 1I5NJd-00021O-GL; Mon, 02 Jul 2007 10:55:49 -0400
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0707012249590.4438@racer.site>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51373>

On Sun, Jul 01, 2007 at 10:51:58PM +0100, Johannes Schindelin wrote:
> 
> When an alias starts with an exclamation mark, the rest is interpreted
> as a shell command. However, all arguments passed to git used to be
> ignored.
> 
> Now you can have an alias like
> 
> 	$ git config alias.e '!echo'
> 
> and
> 
> 	$ git e Hello World
> 
> does what you expect it to do.

But what if you don't want the argument passed at the end of the
alias, but somewhere else?  I suspect the better answer would be to
support $* and $1, $2, $3, et. al interpolation, no?  It was on my
list of things to do when I had a spare moment, but I never got around
to it.

					- Ted
