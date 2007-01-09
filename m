From: Theodore Tso <tytso@mit.edu>
Subject: Re: [DRAFT] Branching and merging with git
Date: Tue, 9 Jan 2007 11:58:28 -0500
Message-ID: <20070109165828.GB9153@thunk.org>
References: <20061116221701.4499.qmail@science.horizon.com> <20070103170411.GB5491@thunk.org> <20070107234411.GD18009@fieldses.org> <7vzm8uz7pz.fsf@assigned-by-dhcp.cox.net> <20070108023511.GI18009@fieldses.org> <20070108140305.GE32756@thunk.org> <20070109024125.GD1686@fieldses.org> <45A3564E.7080003@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "J. Bruce Fields" <bfields@fieldses.org>,
	Junio C Hamano <junkio@cox.net>, linux@horizon.com,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 09 17:59:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H4KJV-0006Xx-V6
	for gcvg-git@gmane.org; Tue, 09 Jan 2007 17:59:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932204AbXAIQ7D (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 9 Jan 2007 11:59:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932233AbXAIQ7C
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Jan 2007 11:59:02 -0500
Received: from thunk.org ([69.25.196.29]:45705 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932204AbXAIQ7A (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jan 2007 11:59:00 -0500
Received: from root (helo=candygram.thunk.org)
	by thunker.thunk.org with local-esmtps 
	(tls_cipher TLS-1.0:RSA_AES_256_CBC_SHA:32)  (Exim 4.50 #1 (Debian))
	id 1H4KNR-0003UU-Hb; Tue, 09 Jan 2007 12:03:09 -0500
Received: from tytso by candygram.thunk.org with local (Exim 4.62)
	(envelope-from <tytso@thunk.org>)
	id 1H4KIu-0003DL-VI; Tue, 09 Jan 2007 11:58:28 -0500
To: Andreas Ericsson <ae@op5.se>
Content-Disposition: inline
In-Reply-To: <45A3564E.7080003@op5.se>
User-Agent: Mutt/1.5.12-2006-07-14
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36377>

On Tue, Jan 09, 2007 at 09:46:06AM +0100, Andreas Ericsson wrote:
> I think the document is fine as it is, but could probably start off with 
> a link to the tutorial, quickstart or a revised version of everyday.txt, 
> stating that "here's something you might want to read if you prefer to 
> experiment. If you think something goes wrong, come back here and find 
> out why".

If what we're going to do is a "git user's manual", I'd recommend
keeping the 2-3 pages in the manual, and do it via a link to some
other document.  One of the issues with the git documentation is that
it's *too* branchy, and some the branches go off to some truly scary
low-level implementation detail.  If we are going to assume that isn't
going to change (and I am glad that the low-level details are
documented, and am not advocating that they be deleted), then keeping
a user-friendly QuickStart in the main document might not be a bad
decision.

						- Ted
