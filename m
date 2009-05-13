From: Theodore Tso <tytso@mit.edu>
Subject: Re: Cross-Platform Version Control
Date: Wed, 13 May 2009 17:04:25 -0400
Message-ID: <20090513210425.GD6579@mit.edu>
References: <419AD153-53B4-4DAB-AF72-4127C17B1CA0@gmail.com> <20090512151403.GS30527@spearce.org> <20090512161638.GB29566@coredump.intra.peff.net> <alpine.LFD.2.01.0905130915540.3343@localhost.localdomain> <alpine.LFD.2.01.0905130951100.3343@localhost.localdomain> <alpine.LFD.2.01.0905131036040.3343@localhost.localdomain> <46a038f90905131126s79e5b8e1qd0c6c100ec836127@mail.gmail.com> <alpine.LFD.2.01.0905131131240.3343@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Martin Langhoff <martin.langhoff@gmail.com>,
	Jeff King <peff@peff.net>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Esko Luontola <esko.luontola@gmail.com>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed May 13 23:04:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M4LdJ-0006jz-EZ
	for gcvg-git-2@gmane.org; Wed, 13 May 2009 23:04:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760247AbZEMVEm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 May 2009 17:04:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759597AbZEMVEl
	(ORCPT <rfc822;git-outgoing>); Wed, 13 May 2009 17:04:41 -0400
Received: from THUNK.ORG ([69.25.196.29]:34511 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756980AbZEMVEl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 May 2009 17:04:41 -0400
Received: from root (helo=closure.thunk.org)
	by thunker.thunk.org with local-esmtp   (Exim 4.50 #1 (Debian))
	id 1M4Lcq-00043p-AM; Wed, 13 May 2009 17:04:28 -0400
Received: from tytso by closure.thunk.org with local (Exim 4.69)
	(envelope-from <tytso@mit.edu>)
	id 1M4Lco-0002BB-0Q; Wed, 13 May 2009 17:04:26 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.01.0905131131240.3343@localhost.localdomain>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@mit.edu
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119104>

On Wed, May 13, 2009 at 11:37:28AM -0700, Linus Torvalds wrote:
> Note: in all of the above, I assume that people care more about just plain 
> UTF characters (and the insane NFD form OS X uses) than about worrying 
> about the _really_ subtle issues of case-independence. Those are a major 
> pain, but they will need even more "internal" support, because there 
> simply isn't any sane wrapping method.

Stupid question --- if we get something that works for Windows and
MacOS X, is there any reason why we need to solve the general problem
of case-insentive filesystems?  It's really backwards compatibility
with Legacy OS's that most important, right?  Are there any other
systems other than Windows and Mac OS X which (a) perpetrate case
insensitivity on application programmers, and (b) which current or
future git users are likely to care about?

						- Ted
