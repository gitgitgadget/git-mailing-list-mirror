From: Theodore Tso <tytso@mit.edu>
Subject: Re: [PATCH] git-send-email: Add --suppress-all-from option.
Date: Fri, 21 Dec 2007 19:55:04 -0500
Message-ID: <20071222005504.GD8601@thunk.org>
References: <1198216860-487-1-git-send-email-git@davidb.org> <7vfxxw7xkb.fsf@gitster.siamese.dyndns.org> <20071221192120.GA13171@mail.oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, David Brown <git@davidb.org>,
	git@vger.kernel.org
To: Joel Becker <Joel.Becker@oracle.com>
X-From: git-owner@vger.kernel.org Sat Dec 22 01:55:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J5seZ-0003RF-UD
	for gcvg-git-2@gmane.org; Sat, 22 Dec 2007 01:55:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750738AbXLVAzY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Dec 2007 19:55:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750711AbXLVAzY
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Dec 2007 19:55:24 -0500
Received: from thunk.org ([69.25.196.29]:51111 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750696AbXLVAzX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Dec 2007 19:55:23 -0500
Received: from root (helo=closure.thunk.org)
	by thunker.thunk.org with local-esmtps 
	(tls_cipher TLS-1.0:RSA_AES_256_CBC_SHA:32)  (Exim 4.50 #1 (Debian))
	id 1J5sp0-0005uP-TT; Fri, 21 Dec 2007 20:06:35 -0500
Received: from tytso by closure.thunk.org with local (Exim 4.67)
	(envelope-from <tytso@thunk.org>)
	id 1J5sds-0003TV-Ct; Fri, 21 Dec 2007 19:55:04 -0500
Content-Disposition: inline
In-Reply-To: <20071221192120.GA13171@mail.oracle.com>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69114>

On Fri, Dec 21, 2007 at 11:21:20AM -0800, Joel Becker wrote:
> 	Yay, even better that we're going to evaluate the sucker (I was
> just complaining about this yesterday to someone, so how apropos that it
> comes up on-list).
> 	First and foremost, I think git-send-email should not default to
> anything.  It was quite a surprise, the first time I tried to use it, to
> discover I had to add two options to ~/.gitconfig just for sane
> behavior.  Never mind that I couldn't suppress the author-cc.  I think
> that a naive "git send-email --to bob@bob.com foo.patch" should only go
> to bob, period.
> 	We can then add ways to auto-cc.  I don't mind typing the extra
> bits.  Heck, we could even define a --review that does what is currently
> the default - cc-everyone-who-might-care-as-we-go-upstream.

Where e-mail addresses are used by default by git-send-email should
probably be a git configuration option (and then we will need to
document the heck out of this when we change it, so this is probably a
git-1.6.0 thing), so projects can tell all of their contributors if
they need to make changes in their config file for the proper
defaults.  Right now the defaults are more or less perfect for the
Linux Kernel development processes, but other folks might not like
them.  On the flip side, just removing all of the current auto-cc's
would be awfully inconvenient for the Linux kernel development
community.

						- Ted
