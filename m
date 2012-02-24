From: Jonathan Corbet <corbet@lwn.net>
Subject: Announcing nntpgit
Date: Fri, 24 Feb 2012 13:39:42 -0700
Organization: LWN.net
Message-ID: <20120224133942.49a7a420@dt>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 24 21:59:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S12FC-000719-AG
	for gcvg-git-2@plane.gmane.org; Fri, 24 Feb 2012 21:59:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932217Ab2BXU7x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Feb 2012 15:59:53 -0500
Received: from tex.lwn.net ([70.33.254.29]:36409 "EHLO vena.lwn.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932141Ab2BXU7x (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Feb 2012 15:59:53 -0500
X-Greylist: delayed 1210 seconds by postgrey-1.27 at vger.kernel.org; Fri, 24 Feb 2012 15:59:53 EST
Received: from dt (localhost.localdomain [127.0.0.1])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by vena.lwn.net (Postfix) with ESMTP id 75F87154005D
	for <git@vger.kernel.org>; Fri, 24 Feb 2012 13:39:43 -0700 (MST)
X-Mailer: Claws Mail 3.8.0 (GTK+ 2.24.10; x86_64-redhat-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191477>

When kernel.org went down, it took the mainline kernel commits list with
it. That had a fairly serious and unfortunate effect on my workflow,
which, among other things, depends on knowing what's being merged.  I
hacked up various workarounds, but none of them were as useful or
efficient.

Eventually it occurred to me that what I *really* wanted was the commit
stream as an NNTP feed so I could read it in gnus along with most of the
other lists I follow.  The result was nntpgit, a small Python3 program
that tracks repository branches and makes new commits available as
"articles" to all comers.  I've been working with it for a few weeks now
and I'm quite happy; it works better for me than the old list did.

Should anybody wish to experiment with it, they can do so in two ways.
First, the code is available (GPLv2) from:

	git://git.lwn.net/nntpgit.git

Alternatively, it's running on port 8119 on git.lwn.net.  There are
currently two "newsgroups": lwn.mainline for mainline commits, and
lwn.networking for davem's networking tree.  I expect to add others over
time.

Be warned that this is very early stage software!  It does what I need it
to do and little else.  I've not tested it with any newsreaders other than
gnus, so the chances of interoperability problems with others are
significant.  I'd be happy to accept bug reports, though, and even happier
to take patches.  I hope it's useful to somebody.

jon
