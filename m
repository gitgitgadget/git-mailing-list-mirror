From: Theodore Tso <tytso@mit.edu>
Subject: Re: Git Vs. Svn for a project which *must* distribute binaries too.
Date: Tue, 5 Jun 2007 07:19:04 -0400
Message-ID: <20070605111904.GA12755@thunk.org>
References: <5971b1ba0706040448i6e166031od1212192a549c4a9@mail.gmail.com> <alpine.LFD.0.98.0706040755560.23741@woody.linux-foundation.org> <5971b1ba0706040838nc9ea7c7h54a57d4235d53bcf@mail.gmail.com> <alpine.LFD.0.98.0706040857380.23741@woody.linux-foundation.org> <20070604175751.GL19935@cip.informatik.uni-erlangen.de> <alpine.LFD.0.98.0706041336440.23741@woody.linux-foundation.org> <20070604212121.GA31852@dspnet.fr.eu.org> <alpine.LFD.0.98.0706041429380.23741@woody.linux-foundation.org> <20070604223003.GJ6528@ca-server1.us.oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Olivier Galibert <galibert@pobox.com>,
	Thomas Glanzmann <thomas@glanzmann.de>,
	Bryan Childs <godeater@gmail.com>, git@vger.kernel.org
To: Joel Becker <Joel.Becker@oracle.com>
X-From: git-owner@vger.kernel.org Tue Jun 05 13:26:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HvXAn-0000x7-1C
	for gcvg-git@gmane.org; Tue, 05 Jun 2007 13:26:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752751AbXFELZx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 5 Jun 2007 07:25:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752747AbXFELZx
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Jun 2007 07:25:53 -0400
Received: from THUNK.ORG ([69.25.196.29]:41651 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752751AbXFELZw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jun 2007 07:25:52 -0400
Received: from root (helo=candygram.thunk.org)
	by thunker.thunk.org with local-esmtps 
	(tls_cipher TLS-1.0:RSA_AES_256_CBC_SHA:32)  (Exim 4.50 #1 (Debian))
	id 1HvXHp-000867-5H; Tue, 05 Jun 2007 07:33:17 -0400
Received: from tytso by candygram.thunk.org with local (Exim 4.63)
	(envelope-from <tytso@thunk.org>)
	id 1HvX44-0003lM-9M; Tue, 05 Jun 2007 07:19:04 -0400
Content-Disposition: inline
In-Reply-To: <20070604223003.GJ6528@ca-server1.us.oracle.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49193>

On Mon, Jun 04, 2007 at 03:30:03PM -0700, Joel Becker wrote:
> 	It survives because it is well-known.  Everyone expects it to
> break.  ocfs2 has an "ALL" branch that is everything we have working,
> sort of a "test this bleeding edge" thing.  It gets rebased all the
> time, and everyone knows that they can't trust it to update linearly.
> Other developers have similar things in their repositories.

I wonder if it would be useful to be able to be able to flag a
branches as "jumping around a lot", where this flag would be
downloaded from another repository when it is cloned, so that a naive
user could get some kind of warning before committing a patch on top
of one of these branches that is known jump around.  

	"This branch gets rebased all the time and is really meant for
	testing.  If you really want to commit this changeset, please
	configure yourself for expert mode or use the --force."

Or maybe just a warning, ala what we do with detached heads.

						- Ted
