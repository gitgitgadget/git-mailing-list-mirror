From: Theodore Tso <tytso@mit.edu>
Subject: Re: [PATCH] Documentation: update git-pull.txt for clone's new default behavior
Date: Mon, 1 Jan 2007 19:57:08 -0500
Message-ID: <20070102005708.GA4253@thunk.org>
References: <20070101214023.GB23857@fieldses.org> <182318.86313.qm@web31812.mail.mud.yahoo.com> <20070102001044.GB32148@fieldses.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Luben Tuikov <ltuikov@yahoo.com>, Junio C Hamano <junkio@cox.net>,
	git@vger.kernel.org, Shawn Pearce <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jan 02 01:57:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H1XyS-0002N8-Nb
	for gcvg-git@gmane.org; Tue, 02 Jan 2007 01:57:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754792AbXABA5Q (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 1 Jan 2007 19:57:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932636AbXABA5Q
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Jan 2007 19:57:16 -0500
Received: from THUNK.ORG ([69.25.196.29]:56206 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754792AbXABA5P (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Jan 2007 19:57:15 -0500
Received: from root (helo=candygram.thunk.org)
	by thunker.thunk.org with local-esmtps 
	(tls_cipher TLS-1.0:RSA_AES_256_CBC_SHA:32)  (Exim 4.50 #1 (Debian))
	id 1H1Y27-00071M-LG; Mon, 01 Jan 2007 20:01:39 -0500
Received: from tytso by candygram.thunk.org with local (Exim 4.62)
	(envelope-from <tytso@thunk.org>)
	id 1H1Xxk-0006gE-CO; Mon, 01 Jan 2007 19:57:08 -0500
To: "J. Bruce Fields" <bfields@fieldses.org>
Content-Disposition: inline
In-Reply-To: <20070102001044.GB32148@fieldses.org>
User-Agent: Mutt/1.5.12-2006-07-14
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35758>

On Mon, Jan 01, 2007 at 07:10:44PM -0500, J. Bruce Fields wrote:
> 
> The simplest way to understand the current behavior is probably to
> install the latest git, read the git-clone man page, clone a new
> repository, and take a look at it.

This should be mentioned in the 1.5 release notes --- that you won't
see a lot of the power the new git unless you create a new repository
using git-clone.  For example, the man page for git-branch says that
"git branch -r" will list remote branches won't print anything if the
repository was originally cloned using an older version of git.  

(I was using the version that shipped with Ubuntu Edgy before I
recently upgraded to the bleeding edge "next" branch so I could try
out the latest and greatest git features that was being discussed on
the mailing list.  :-)

						- Ted
