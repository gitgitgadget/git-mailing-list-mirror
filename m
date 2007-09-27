From: Theodore Tso <tytso@mit.edu>
Subject: Re: Mergetool generating blank files (1.5.3)
Date: Thu, 27 Sep 2007 18:23:26 -0400
Message-ID: <20070927222326.GB8688@thunk.org>
References: <94ccbe710709271131o620bf1far8893328ce98f0ba4@mail.gmail.com> <20070927185707.GC12427@artemis.corp> <46FBFDD7.1080300@gmail.com> <20070927191125.GD12427@artemis.corp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: Pierre Habouzit <madcoder@debian.org>,
	Russ Brown <pickscrape@gmail.com>,
	Kelvie Wong <kelvie@ieee.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 28 00:23:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ib1li-0004JT-N9
	for gcvg-git-2@gmane.org; Fri, 28 Sep 2007 00:23:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757537AbXI0WXc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Sep 2007 18:23:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756948AbXI0WXb
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Sep 2007 18:23:31 -0400
Received: from thunk.org ([69.25.196.29]:47150 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756321AbXI0WXb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Sep 2007 18:23:31 -0400
Received: from root (helo=candygram.thunk.org)
	by thunker.thunk.org with local-esmtps 
	(tls_cipher TLS-1.0:RSA_AES_256_CBC_SHA:32)  (Exim 4.50 #1 (Debian))
	id 1Ib1v2-000130-87; Thu, 27 Sep 2007 18:33:16 -0400
Received: from tytso by candygram.thunk.org with local (Exim 4.63)
	(envelope-from <tytso@thunk.org>)
	id 1Ib1lW-0005Vu-Il; Thu, 27 Sep 2007 18:23:26 -0400
Content-Disposition: inline
In-Reply-To: <20070927191125.GD12427@artemis.corp>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59343>

On Thu, Sep 27, 2007 at 09:11:25PM +0200, Pierre Habouzit wrote:
> > >   And as none of the other merge tool that are supported are able to
> > > either do 3way merges, or have a decent UI (that definitely seems to be
> > > exclusive features) I've given up on git-mergetool (and to be fair, it
> > > sucks, because it could be _sooo_ useful sometimes).
> > > 
> > 
> > What about meld? That does 3-way merge, and the UI is fine.
> 
>   Indeed, it seems that since the last time I tested it, it now does
> diff3 merging. I should reevaluate it :)

Pierre,

FYI, kdiff3, meld, xxdiff, opendiff (on MacOSX), and emerge all
support 3-way merge.

						- Ted
