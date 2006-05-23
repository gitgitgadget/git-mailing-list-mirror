From: Theodore Tso <tytso@mit.edu>
Subject: Re: [PATCH] cvsimport: introduce -L<imit> option to workaround memory leaks
Date: Tue, 23 May 2006 11:36:36 -0400
Message-ID: <20060523153636.GA21506@thunk.org>
References: <11482978883713-git-send-email-martin@catalyst.net.nz> <Pine.LNX.4.64.0605221926270.3697@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Martin Langhoff <martin@catalyst.net.nz>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <junkio@cox.net>, Johannes.Schindelin@gmx.de,
	spyderous@gentoo.org, smurf@smurf.noris.de
X-From: git-owner@vger.kernel.org Tue May 23 17:37:34 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FiYwZ-0002K8-16
	for gcvg-git@gmane.org; Tue, 23 May 2006 17:37:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750713AbWEWPhH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 23 May 2006 11:37:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750729AbWEWPhH
	(ORCPT <rfc822;git-outgoing>); Tue, 23 May 2006 11:37:07 -0400
Received: from thunk.org ([69.25.196.29]:38809 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S1750713AbWEWPhF (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 23 May 2006 11:37:05 -0400
Received: from root (helo=candygram.thunk.org)
	by thunker.thunk.org with local-esmtps 
	(tls_cipher TLS-1.0:RSA_AES_256_CBC_SHA:32)  (Exim 4.50 #1 (Debian))
	id 1FiYwE-0006jb-Bq; Tue, 23 May 2006 11:36:52 -0400
Received: from tytso by candygram.thunk.org with local (Exim 4.60)
	(envelope-from <tytso@thunk.org>)
	id 1FiYw0-0001rX-KB; Tue, 23 May 2006 11:36:36 -0400
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0605221926270.3697@g5.osdl.org>
User-Agent: Mutt/1.5.11
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20609>

On Mon, May 22, 2006 at 07:28:37PM -0700, Linus Torvalds wrote:
> 
> 
> This stupid patch on top of yours seems to make git happier. It's 
> disgusting, I know, but it just repacks things every kilo-commit.
> 
> I actually think that I found a real ext3 performance bug from trying to 
> determine why git sometimes slows down ridiculously when the tree has been 
> allowed to go too long without a repack.

Do you have dir_index (the hashed btree) feature enabled by any chance?

						- Ted
