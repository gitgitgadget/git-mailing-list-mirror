From: Theodore Tso <tytso@mit.edu>
Subject: Re: How do get a specific version of a particular file?
Date: Tue, 27 Feb 2007 14:09:12 -0500
Message-ID: <20070227190912.GA30080@thunk.org>
References: <E1HM1XL-00071C-N5@candygram.thunk.org> <Pine.LNX.4.64.0702270830260.12485@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Feb 27 20:09:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HM7hU-0002yQ-Tp
	for gcvg-git@gmane.org; Tue, 27 Feb 2007 20:09:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752037AbXB0TJR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Feb 2007 14:09:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752040AbXB0TJR
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Feb 2007 14:09:17 -0500
Received: from thunk.org ([69.25.196.29]:48652 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752037AbXB0TJQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Feb 2007 14:09:16 -0500
Received: from root (helo=candygram.thunk.org)
	by thunker.thunk.org with local-esmtps 
	(tls_cipher TLS-1.0:RSA_AES_256_CBC_SHA:32)  (Exim 4.50 #1 (Debian))
	id 1HM7mn-000351-A3; Tue, 27 Feb 2007 14:14:53 -0500
Received: from tytso by candygram.thunk.org with local (Exim 4.62)
	(envelope-from <tytso@thunk.org>)
	id 1HM7hI-0001An-AS; Tue, 27 Feb 2007 14:09:12 -0500
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0702270830260.12485@woody.linux-foundation.org>
User-Agent: Mutt/1.5.12-2006-07-14
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40769>

On Tue, Feb 27, 2007 at 08:38:59AM -0800, Linus Torvalds wrote:
> Everybody has already pointed out how easy this actually is, but your 
> fundamental mistake was thinking that "only work on a object identifier" 
> is a bad thing.
> 
> Repeat after me: in git, *everything* is a SHA1 object!
> 
> So the problem you had was that "only". Remove the "only", and realize 
> that object identifiers will cover _all_ you ever need, and be happy.

Yeah, the problem was that in the git man pages I had read, and the
git tutorials that I had read, I had never learned about the
<tree>:<path> syntax of object identifiers.  So this was more of a
documentation problem than anything else --- I did look and trawlled
through the documentation for quite a while before posting because I
didn't want to look stupid, and I still didn't find it.

						- Ted
