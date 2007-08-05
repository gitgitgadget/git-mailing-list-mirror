From: Theodore Tso <tytso@mit.edu>
Subject: Re: way to automatically add untracked files?
Date: Sun, 5 Aug 2007 12:11:17 -0400
Message-ID: <20070805161117.GE28263@thunk.org>
References: <873ayymzc1.fsf@catnip.gol.com> <fc339e4a0708042100jdf0a0f1jd1fddfb5dc1c1052@mail.gmail.com> <20070805041320.GH9527@spearce.org> <200708051411.25238.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>,
	Miles Bader <miles@gnu.org>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Sun Aug 05 18:11:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHihW-0007id-Oa
	for gcvg-git@gmane.org; Sun, 05 Aug 2007 18:11:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752280AbXHEQL2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 5 Aug 2007 12:11:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752589AbXHEQL2
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Aug 2007 12:11:28 -0400
Received: from thunk.org ([69.25.196.29]:46827 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752197AbXHEQL1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Aug 2007 12:11:27 -0400
Received: from root (helo=tinytim.thunk.org)
	by thunker.thunk.org with local-esmtps 
	(tls_cipher TLS-1.0:RSA_AES_256_CBC_SHA:32)  (Exim 4.50 #1 (Debian))
	id 1IHipv-0006G0-FR; Sun, 05 Aug 2007 12:20:11 -0400
Received: from tytso by tinytim.thunk.org with local (Exim 4.63)
	(envelope-from <tytso@thunk.org>)
	id 1IHihJ-0004pO-UA; Sun, 05 Aug 2007 12:11:17 -0400
Content-Disposition: inline
In-Reply-To: <200708051411.25238.johan@herland.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55037>

On Sun, Aug 05, 2007 at 02:11:24PM +0200, Johan Herland wrote:
> $ hg addremove --help
> hg addremove [OPTION]... [FILE]...
> 
> add all new files, delete all missing files
> 
>     Add all new files and remove all missing files from the repository.
> 
>     New files are ignored if they match any of the patterns in .hgignore. As
>     with add, these changes take effect at the next commit.
> 
> Adding a git-addremove command should not be much work, and it would be a 
> lot friendlier to people whose workflow is more aligned with #2 than #1.

Not much work at alll:

# git config --system --add alias.addremove "git add . ; git add -u"

:-)

(And the performance problem with git add . is fixed in 1.5.3-rc4,
right?)

						- Ted
