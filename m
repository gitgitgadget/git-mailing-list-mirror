From: Theodore Tso <tytso@mit.edu>
Subject: Re: What's in git.git (stable)
Date: Sun, 4 Feb 2007 15:58:58 -0500
Message-ID: <20070204205858.GE12943@thunk.org>
References: <7v7iv2soxv.fsf@assigned-by-dhcp.cox.net> <7vps8qtgbm.fsf@assigned-by-dhcp.cox.net> <20070204185144.GB24368@coredump.intra.peff.net> <Pine.LNX.4.64.0702041111010.8424@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Junio C Hamano <junkio@cox.net>,
	git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sun Feb 04 21:59:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HDoS4-0001gV-Fi
	for gcvg-git@gmane.org; Sun, 04 Feb 2007 21:59:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752539AbXBDU7H (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 4 Feb 2007 15:59:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752555AbXBDU7G
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Feb 2007 15:59:06 -0500
Received: from THUNK.ORG ([69.25.196.29]:38246 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752539AbXBDU7G (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Feb 2007 15:59:06 -0500
Received: from root (helo=candygram.thunk.org)
	by thunker.thunk.org with local-esmtps 
	(tls_cipher TLS-1.0:RSA_AES_256_CBC_SHA:32)  (Exim 4.50 #1 (Debian))
	id 1HDoWw-0007SB-ML; Sun, 04 Feb 2007 16:04:10 -0500
Received: from tytso by candygram.thunk.org with local (Exim 4.62)
	(envelope-from <tytso@thunk.org>)
	id 1HDoRu-0003IJ-4C; Sun, 04 Feb 2007 15:58:58 -0500
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0702041111010.8424@woody.linux-foundation.org>
User-Agent: Mutt/1.5.12-2006-07-14
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38709>

On Sun, Feb 04, 2007 at 11:12:34AM -0800, Linus Torvalds wrote:
> 
> 
> On Sun, 4 Feb 2007, Jeff King wrote:
> > 
> > Just a thought, but it might be useful to blame the contents of an
> > arbitrary file (but starting the history at a given pathname). Something
> > like "git blame --contents /tmp/foo.c file.c", with contents defaulting
> > to "file.c". There's much discussion of editor interfaces, and this
> > leaves the possibility of git-blaming the contents of the editor buffer
> > (after writing it out to a temp file) without having to save changes to
> > the working tree file.
> 
> I agree, that probably would make most sense. If we do this at all. On the 
> other hand, I suspect that most editors would probably want to pipe the 
> contents to the program, not write it to a temp-file.

... and use it with --incremental, as well.  In emacs you can have the
annotation take place as it is being written out relatively easily, by
arranging to have a callback function get called each time more
information is handed back to emacs via a pipe.

						- Ted
