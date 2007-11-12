From: Theodore Tso <tytso@mit.edu>
Subject: Re: [PATCH,RFC 1/2] Make the list of common commands more exclusive
Date: Mon, 12 Nov 2007 10:20:18 -0500
Message-ID: <20071112152018.GA20772@thunk.org>
References: <20071111235819.GB7392@thunk.org> <1194829077-14320-1-git-send-email-tytso@mit.edu> <7vzlxk8apz.fsf@gitster.siamese.dyndns.org> <20071112062222.GA17462@thunk.org> <4738292E.2020103@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Mon Nov 12 16:21:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Irb5i-0001YI-DZ
	for gcvg-git-2@gmane.org; Mon, 12 Nov 2007 16:20:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751700AbXKLPUa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Nov 2007 10:20:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751437AbXKLPUa
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Nov 2007 10:20:30 -0500
Received: from thunk.org ([69.25.196.29]:60410 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750733AbXKLPU3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Nov 2007 10:20:29 -0500
Received: from root (helo=closure.thunk.org)
	by thunker.thunk.org with local-esmtps 
	(tls_cipher TLS-1.0:RSA_AES_256_CBC_SHA:32)  (Exim 4.50 #1 (Debian))
	id 1IrbFg-0005q5-HW; Mon, 12 Nov 2007 10:31:04 -0500
Received: from tytso by closure.thunk.org with local (Exim 4.67)
	(envelope-from <tytso@thunk.org>)
	id 1Irb5H-0005Pj-2B; Mon, 12 Nov 2007 10:20:19 -0500
Content-Disposition: inline
In-Reply-To: <4738292E.2020103@op5.se>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64635>

On Mon, Nov 12, 2007 at 11:21:34AM +0100, Andreas Ericsson wrote:
>
> git format-patch could probably go in, but skip the others. I've never
> used git cherry in my entire life and it's not, strictly speaking,
> necessary for users to have it. There are other and easier ways to
> find the same information.

How useful it is depends on the project, definitely.  The Linux kernel
doesn't have the "what's cooking" emails, and is very fast-moving, so
a day after you submit your patch set via e-mail, and then you do a
pull, and several hundred commits come spilling down from upstream,
git-cherry is incredibly useful to see what was accepted and what
wasn't.  :-)

> I'd keep cherry-pick though. It's incredibly useful, and especially
> when a commit ends up on the wrong branch which is something newbies
> are likely to do when they start trying out the topic-branch workflow.
> I still do it sometimes, but hardly ever stop thinking about it since
> it's so easy to fix thanks to cherry-pick.

How often cherry-pick is useful is probably also very project
specific, and depends on how branchy a project happens to be, and how
aggressively patches get merged into the master development line.  For
a project that is extremely linear, with few branches, cherry-pick is
less useful; I didn't have any occasion to use it for quite a while,
and certainly not while I was a git beginner.

							- Ted
