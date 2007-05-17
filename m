From: Theodore Tso <tytso@mit.edu>
Subject: Re: Smart fetch via HTTP?
Date: Thu, 17 May 2007 08:36:37 -0400
Message-ID: <20070517123637.GA9514@thunk.org>
References: <20070515201006.GD3653@efreet.light.src> <46a038f90705152225y529c9db3x8615822e876c25a8@mail.gmail.com> <Pine.LNX.4.64.0705161232120.6410@racer.site> <46a038f90705161426n3b928086t2d3e68749557f866@mail.gmail.com> <Pine.LNX.4.64.0705170152470.6410@racer.site> <20070517010335.GU3141@spearce.org> <Pine.LNX.4.64.0705161803580.1280@asgard.lang.hm> <20070517012602.GV3141@spearce.org> <20070517014542.GW3141@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: david@lang.hm, Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	Jan Hudec <bulb@ucw.cz>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu May 17 14:37:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HofEV-0003YA-4N
	for gcvg-git@gmane.org; Thu, 17 May 2007 14:37:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754567AbXEQMhH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 17 May 2007 08:37:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754338AbXEQMhH
	(ORCPT <rfc822;git-outgoing>); Thu, 17 May 2007 08:37:07 -0400
Received: from thunk.org ([69.25.196.29]:58570 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754567AbXEQMhF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 May 2007 08:37:05 -0400
Received: from root (helo=candygram.thunk.org)
	by thunker.thunk.org with local-esmtps 
	(tls_cipher TLS-1.0:RSA_AES_256_CBC_SHA:32)  (Exim 4.50 #1 (Debian))
	id 1HofKx-0004Ps-MY; Thu, 17 May 2007 08:44:07 -0400
Received: from tytso by candygram.thunk.org with local (Exim 4.63)
	(envelope-from <tytso@thunk.org>)
	id 1HofDh-0002ls-QE; Thu, 17 May 2007 08:36:37 -0400
Content-Disposition: inline
In-Reply-To: <20070517014542.GW3141@spearce.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47514>

On Wed, May 16, 2007 at 09:45:42PM -0400, Shawn O. Pearce wrote:
> Its not perfect.  The hotter parts of the object database is almost
> always the recent stuff, as that's what people are actively trying
> to fetch, or are using as a base when they are trying to fetch from
> someone else.  The hotter parts are also probably too new to be
> in the shared store offered by kernel.org admins, which means you
> cannot get good IO buffering.  Back to the current set of problems.

Actually, as long as objects/info/alternates is pointing at Linus's
kernel.org tree, I would think that it should work relatively well,
since everyone is normally basing their work on top of his tree as a
starting point.

						- Ted
