From: Theodore Tso <tytso@mit.edu>
Subject: Re: GIT and SCC
Date: Wed, 5 Nov 2008 14:38:25 -0500
Message-ID: <20081105193824.GA9266@mit.edu>
References: <1225909527.8578.10.camel@terrenisrv1.terrenis.net> <20081105182506.GO15463@spearce.org> <e2b179460811051111y2d6e4c5eq19c8b58b93f942a9@mail.gmail.com> <1225913035.8578.18.camel@terrenisrv1.terrenis.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mike Ralphson <mike.ralphson@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Martin Terreni <martin@terrenis.net>
X-From: git-owner@vger.kernel.org Wed Nov 05 20:39:45 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KxoEC-00089t-Vk
	for gcvg-git-2@gmane.org; Wed, 05 Nov 2008 20:39:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755185AbYKETia (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Nov 2008 14:38:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754723AbYKETia
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Nov 2008 14:38:30 -0500
Received: from www.church-of-our-saviour.org ([69.25.196.31]:45356 "EHLO
	thunker.thunk.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754479AbYKETi3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Nov 2008 14:38:29 -0500
Received: from root (helo=closure.thunk.org)
	by thunker.thunk.org with local-esmtp   (Exim 4.50 #1 (Debian))
	id 1KxoCw-0005Zr-5C; Wed, 05 Nov 2008 14:38:26 -0500
Received: from tytso by closure.thunk.org with local (Exim 4.69)
	(envelope-from <tytso@mit.edu>)
	id 1KxoCv-0002Qk-4Z; Wed, 05 Nov 2008 14:38:25 -0500
Content-Disposition: inline
In-Reply-To: <1225913035.8578.18.camel@terrenisrv1.terrenis.net>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@mit.edu
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100177>

On Wed, Nov 05, 2008 at 09:23:55PM +0200, Martin Terreni wrote:
> 
> http://en.wikipedia.org/wiki/SCC_compliant
> 
> It is probably not much, but this is what I could find in a minute. many
> VC system have a SCC complaint API (apart of the native). This protocol
> was created by M$ is used by many systems so they are not bound to a
> specific VC tool.

It's a closed-source, undocumented API that you can only get access to
by signing a Microsoft NDA.   From the WinMerge API:

	SCC API is closed API (no public documentation available) some
	IDE's (e.g. Visual Studio) use. There apparently have couple
	of reverse-engineered free implementations for SCC API. Status
	of those are unknown.

	WARNING: Be very sure you are not submitting any code behing
	NDA for WinMerge. WinMerge is Open Source so it is not legal
	to do. And what is worse it would prevent anybody reading that
	code working with SCC (and perhaps also VCS) support.

http://winmerge.org/Wiki/VCS_integration

							- Ted
