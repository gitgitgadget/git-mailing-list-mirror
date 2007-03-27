From: Theodore Tso <tytso@mit.edu>
Subject: Re: an hg-to-git adventure
Date: Tue, 27 Mar 2007 07:33:32 -0400
Message-ID: <20070327113332.GA469@thunk.org>
References: <87tzw7qawl.fsf@rho.meyering.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jim Meyering <jim@meyering.net>
X-From: git-owner@vger.kernel.org Tue Mar 27 13:33:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HW9vy-00083x-2C
	for gcvg-git@gmane.org; Tue, 27 Mar 2007 13:33:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753819AbXC0Ldr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Mar 2007 07:33:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753821AbXC0Ldr
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Mar 2007 07:33:47 -0400
Received: from thunk.org ([69.25.196.29]:35220 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753819AbXC0Ldq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Mar 2007 07:33:46 -0400
Received: from root (helo=candygram.thunk.org)
	by thunker.thunk.org with local-esmtps 
	(tls_cipher TLS-1.0:RSA_AES_256_CBC_SHA:32)  (Exim 4.50 #1 (Debian))
	id 1HWA1j-0000oO-Gz; Tue, 27 Mar 2007 07:39:47 -0400
Received: from tytso by candygram.thunk.org with local (Exim 4.62)
	(envelope-from <tytso@thunk.org>)
	id 1HW9vg-0005O4-IF; Tue, 27 Mar 2007 07:33:32 -0400
Content-Disposition: inline
In-Reply-To: <87tzw7qawl.fsf@rho.meyering.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43267>

On Tue, Mar 27, 2007 at 11:43:38AM +0200, Jim Meyering wrote:
> Normally, converting a mercurial repository to git is simple: just
> run the hg-to-git script (from git/contrib).  However, the one I did
> yesterday was different.

By the way, there is a faster hg-to-git script called hg-fast-export
located inside the fast-export repository:

	git://repo.or.cz/fast-export.git

This uses git-fast-import and does a much faster conversion job.  It
also has some features to clean up author names (including pulling out
Signed-Off-By: information so it can be stuffed into the author field)
automatically.

						- Ted
