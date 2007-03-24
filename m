From: Theodore Tso <tytso@mit.edu>
Subject: Re: [PATCH] update-hook: remove all functionality that should be in hooks/post-receive
Date: Sat, 24 Mar 2007 06:26:52 -0400
Message-ID: <20070324102652.GA15474@thunk.org>
References: <200703231022.00189.andyparkins@gmail.com> <7v648ro3a3.fsf@assigned-by-dhcp.cox.net> <200703240814.35525.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 24 11:27:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HV3Su-0006rW-Rf
	for gcvg-git@gmane.org; Sat, 24 Mar 2007 11:27:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752512AbXCXK1O (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 24 Mar 2007 06:27:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752620AbXCXK1O
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Mar 2007 06:27:14 -0400
Received: from THUNK.ORG ([69.25.196.29]:52496 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752512AbXCXK1N (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Mar 2007 06:27:13 -0400
Received: from root (helo=candygram.thunk.org)
	by thunker.thunk.org with local-esmtps 
	(tls_cipher TLS-1.0:RSA_AES_256_CBC_SHA:32)  (Exim 4.50 #1 (Debian))
	id 1HV3Yg-0001NW-BS; Sat, 24 Mar 2007 06:33:15 -0400
Received: from tytso by candygram.thunk.org with local (Exim 4.62)
	(envelope-from <tytso@thunk.org>)
	id 1HV3SX-0004rP-0T; Sat, 24 Mar 2007 06:26:53 -0400
Content-Disposition: inline
In-Reply-To: <200703240814.35525.andyparkins@gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42992>

On Sat, Mar 24, 2007 at 08:14:31AM +0000, Andy Parkins wrote:
> So: ideally, what /I/ would like is that git distributes the script in a 
> standard location like /usr/share/doc/git/contrib/post-receive-emailer 
> with the execute bit already set; that can be easily linked to or 
> called from the actual post-receive hook.

I wonder if this is a good idea to do for all or most of the template
scripts, so that they can get automatically updated when git is
updated, instead of having the problem we had before where the hook
script got updated to match changes in git, but ancient repositories
would still have the old script.

						- Ted
