From: Theodore Tso <tytso@mit.edu>
Subject: Re: [PATCH] update-hook: remove all functionality that should be in hooks/post-receive
Date: Sat, 24 Mar 2007 10:21:04 -0400
Message-ID: <20070324142104.GA31791@thunk.org>
References: <200703231022.00189.andyparkins@gmail.com> <7v648ro3a3.fsf@assigned-by-dhcp.cox.net> <200703240814.35525.andyparkins@gmail.com> <20070324102652.GA15474@thunk.org> <7vodmikjol.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat Mar 24 15:21:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HV77Z-0002sr-QV
	for gcvg-git@gmane.org; Sat, 24 Mar 2007 15:21:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751930AbXCXOVN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 24 Mar 2007 10:21:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751932AbXCXOVN
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Mar 2007 10:21:13 -0400
Received: from THUNK.ORG ([69.25.196.29]:52379 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751930AbXCXOVM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Mar 2007 10:21:12 -0400
Received: from root (helo=candygram.thunk.org)
	by thunker.thunk.org with local-esmtps 
	(tls_cipher TLS-1.0:RSA_AES_256_CBC_SHA:32)  (Exim 4.50 #1 (Debian))
	id 1HV7DC-0002Tv-MI; Sat, 24 Mar 2007 10:27:18 -0400
Received: from tytso by candygram.thunk.org with local (Exim 4.62)
	(envelope-from <tytso@thunk.org>)
	id 1HV77A-0000x4-PY; Sat, 24 Mar 2007 10:21:04 -0400
Content-Disposition: inline
In-Reply-To: <7vodmikjol.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43000>

On Sat, Mar 24, 2007 at 03:41:30AM -0700, Junio C Hamano wrote:
> While I think it would be great to have a central clearinghouse
> for people to share and enjoy useful hook collections for
> various workflows and use cases, I do not necessarily think
> inside git.git project itself is the best place to do so.

What are your concernswith having a set of useful hook collections in
contrib/hooks, which get installed in /usr/share/git/hooks, or some
such?  The nice of doing this is that various distro packages will
have the hooks installed in standardized places, which means that it
becomes easier for people distribute receipes on how to enable various
advanced bits of functionality by using 'ln -s /usr/share/git/hooks/FOO
.git/hooks/BAR', and it's standardized across distributions.

						- Ted
