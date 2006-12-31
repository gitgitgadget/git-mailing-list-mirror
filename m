From: Theodore Tso <tytso@mit.edu>
Subject: Re: [PATCH 3/4] Automatically detect a bare git repository.
Date: Sun, 31 Dec 2006 07:52:05 -0500
Message-ID: <20061231125205.GB14286@thunk.org>
References: <3ffc8ddd9b500c2a34d2bd6ba147dc750d951bcd.1167539318.git.spearce@spearce.org> <20061231043019.GC5823@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 31 13:52:19 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H10Af-0000zK-Mf
	for gcvg-git@gmane.org; Sun, 31 Dec 2006 13:52:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933163AbWLaMwK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 31 Dec 2006 07:52:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933164AbWLaMwK
	(ORCPT <rfc822;git-outgoing>); Sun, 31 Dec 2006 07:52:10 -0500
Received: from thunk.org ([69.25.196.29]:41081 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933163AbWLaMwJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Dec 2006 07:52:09 -0500
Received: from root (helo=candygram.thunk.org)
	by thunker.thunk.org with local-esmtps 
	(tls_cipher TLS-1.0:RSA_AES_256_CBC_SHA:32)  (Exim 4.50 #1 (Debian))
	id 1H10Es-0001ve-SD; Sun, 31 Dec 2006 07:56:35 -0500
Received: from tytso by candygram.thunk.org with local (Exim 4.62)
	(envelope-from <tytso@thunk.org>)
	id 1H10AX-0007Lb-HE; Sun, 31 Dec 2006 07:52:05 -0500
To: "Shawn O. Pearce" <spearce@spearce.org>
Content-Disposition: inline
In-Reply-To: <20061231043019.GC5823@spearce.org>
User-Agent: Mutt/1.5.12-2006-07-14
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35696>

On Sat, Dec 30, 2006 at 11:30:19PM -0500, Shawn O. Pearce wrote:
> Many users find it unfriendly that they can create a bare git
> repository easily with `git clone --bare` but are then unable to
> run simple commands like `git log` once they cd into that newly
> created bare repository.  This occurs because we do not check to
> see if the current working directory is a git repository.

Thanks for coding this up!   

If you do this, does this mean that we can also eliminate the global
variable --bare, since git will be able to figure out we're in a bare
repository all by itself?

						- Ted
