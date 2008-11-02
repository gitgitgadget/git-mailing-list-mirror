From: Theodore Tso <tytso@mit.edu>
Subject: Re: Git/Mercurial interoperability (and what about bzr?)
Date: Sat, 1 Nov 2008 21:13:28 -0400
Message-ID: <20081102011328.GG8134@mit.edu>
References: <alpine.DEB.1.00.0810281445190.22125@pacific.mpi-cbg.de.mpi-cbg.de> <Pine.LNX.4.64.0810281536360.27029@ds9.cixit.se> <E026EBDF-F402-49AB-A7A8-0A0EFB513907@ai.rug.nl> <20081028191234.GS24201@genesis.frugalware.org> <20081028213144.GC10862@mit.edu> <87ljw3zx8i.fsf@mid.deneb.enyo.de> <m3prlffzk2.fsf@localhost.localdomain> <87abcjpvy2.fsf@mid.deneb.enyo.de> <20081101133931.GC8134@mit.edu> <alpine.LFD.2.00.0811011047050.3483@nehalem.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Florian Weimer <fw@deneb.enyo.de>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sun Nov 02 02:14:54 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KwRYL-0005kR-5G
	for gcvg-git-2@gmane.org; Sun, 02 Nov 2008 02:14:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752192AbYKBBNg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Nov 2008 21:13:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752177AbYKBBNf
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Nov 2008 21:13:35 -0400
Received: from www.church-of-our-saviour.org ([69.25.196.31]:59161 "EHLO
	thunker.thunk.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752174AbYKBBNf (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Nov 2008 21:13:35 -0400
Received: from root (helo=closure.thunk.org)
	by thunker.thunk.org with local-esmtp   (Exim 4.50 #1 (Debian))
	id 1KwRWz-0003lC-7W; Sat, 01 Nov 2008 21:13:29 -0400
Received: from tytso by closure.thunk.org with local (Exim 4.69)
	(envelope-from <tytso@mit.edu>)
	id 1KwRWy-00067B-Jm; Sat, 01 Nov 2008 21:13:28 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.0811011047050.3483@nehalem.linux-foundation.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@mit.edu
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99794>

On Sat, Nov 01, 2008 at 10:51:51AM -0700, Linus Torvalds wrote:
> 
> 
> On Sat, 1 Nov 2008, Theodore Tso wrote:
> > 
> > .hgtags is stored as a versioned file in Mercurial.  That's one of the
> > problems, and it leads to no shortage of headaches.
> 
> I told people this was insane long long ago, and I thought the hg people 
> had learnt to use local tags. They act sanely, as far as I know (ie they 
> act the same way git tags do).
> 
> Of course, the problem with hg local tags is that hg apparently has no 
> sane way to _propagate_ such local tag-space information from one 
> repository to another. But that's purely a problem with hg itself. I don't 
> know why that hasn't gotten fixed.

Yeah, well, hg calls them _local_ tags, and so people consider that by
design, they aren't supposed to be propagated outside of the local
repository.  As I recall, hg doesn't support GPG signing local tags,
for the same reason.

							- Ted
