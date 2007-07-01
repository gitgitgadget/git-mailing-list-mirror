From: Theodore Tso <tytso@mit.edu>
Subject: Re: Start deprecating "git-command" in favor of "git command"
Date: Sat, 30 Jun 2007 23:00:19 -0400
Message-ID: <20070701030019.GB28917@thunk.org>
References: <20070701004517.31176.qmail@science.horizon.com> <2b05065b0706301848o21cf9e90g14f759a99196dcf2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: eschvoca <eschvoca@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 01 05:00:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I4pfw-0000RZ-PY
	for gcvg-git@gmane.org; Sun, 01 Jul 2007 05:00:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755051AbXGADAf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 30 Jun 2007 23:00:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755038AbXGADAe
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Jun 2007 23:00:34 -0400
Received: from THUNK.ORG ([69.25.196.29]:47453 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755018AbXGADAe (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jun 2007 23:00:34 -0400
Received: from root (helo=candygram.thunk.org)
	by thunker.thunk.org with local-esmtps 
	(tls_cipher TLS-1.0:RSA_AES_256_CBC_SHA:32)  (Exim 4.50 #1 (Debian))
	id 1I4pne-0005lw-8E; Sat, 30 Jun 2007 23:08:34 -0400
Received: from tytso by candygram.thunk.org with local (Exim 4.63)
	(envelope-from <tytso@thunk.org>)
	id 1I4pff-0006Oe-Fz; Sat, 30 Jun 2007 23:00:19 -0400
Content-Disposition: inline
In-Reply-To: <2b05065b0706301848o21cf9e90g14f759a99196dcf2@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51269>

On Sat, Jun 30, 2007 at 09:48:26PM -0400, eschvoca wrote:
> By removing the dash I would miss out on man pages too.

The man pages are something that needs careful consideration.  Some
man programs use the PATH as a hint to figure out which man page to
show --- i.e., if /usr/local/bin/git-log is in the path then it's
likely that the man page you want to show is the one in
/usr/local/man/man1/git-log.1.

If we don't install git-log in the PATH, for some setups people won't
be able to see the man page for git-log.

						- Ted
