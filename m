From: Theodore Tso <tytso@mit.edu>
Subject: Re: Recent and near future backward incompatibilities
Date: Sun, 15 Oct 2006 18:40:12 -0400
Message-ID: <20061015224012.GC5092@thunk.org>
References: <7v4pu62ite.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
	Stephen Hemminger <shemminger@osdl.org>
X-From: git-owner@vger.kernel.org Mon Oct 16 00:40:49 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GZEef-00023o-D9
	for gcvg-git@gmane.org; Mon, 16 Oct 2006 00:40:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422920AbWJOWkV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 Oct 2006 18:40:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422916AbWJOWkV
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Oct 2006 18:40:21 -0400
Received: from thunk.org ([69.25.196.29]:3308 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S1422920AbWJOWkU (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 15 Oct 2006 18:40:20 -0400
Received: from root (helo=candygram.thunk.org)
	by thunker.thunk.org with local-esmtps 
	(tls_cipher TLS-1.0:RSA_AES_256_CBC_SHA:32)  (Exim 4.50 #1 (Debian))
	id 1GZEhJ-00041r-ND; Sun, 15 Oct 2006 18:43:09 -0400
Received: from tytso by candygram.thunk.org with local (Exim 4.62)
	(envelope-from <tytso@thunk.org>)
	id 1GZEeS-0000nu-DN; Sun, 15 Oct 2006 18:40:12 -0400
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7v4pu62ite.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28936>

On Sat, Oct 14, 2006 at 11:29:17PM -0700, Junio C Hamano wrote:
> It was brought to my attention that the public git.git
> repository cannot be cloned with older versions of git.  More
> precisely, packs generated with post 16854571 (NOT contained in
> v1.4.2.3 but in the current "master" and more importantly in
> v1.4.3-rc3 which I tagged tonight) can contain deltas that are
> not compatible with the version of git before d60fc1c8, which
> means that v1.1.6 and older (v1.2.0 and later are Ok).

By the way, note that Ubuntu Dapper (the current stable version of
Ubuntu) is shipped with git version 1.1.3, and that incompatibility
extends not to the git repository, but also the Linux-2.6 repostiory
at

git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git

						- Ted
