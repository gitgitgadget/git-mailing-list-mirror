From: David Kastrup <dak@gnu.org>
Subject: Re: "git stash" is not known to git
Date: Mon, 30 Jul 2007 12:24:51 +0200
Message-ID: <86lkcytci4.fsf@lola.quinscape.zz>
References: <86bqduutz4.fsf@lola.quinscape.zz> <vpqwswi2pkw.fsf@bauges.imag.fr> <863az6uscz.fsf@lola.quinscape.zz> <20070730100609.GB8829@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 30 12:25:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IFSR9-00028J-3t
	for gcvg-git@gmane.org; Mon, 30 Jul 2007 12:25:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753195AbXG3KZL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 30 Jul 2007 06:25:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753053AbXG3KZL
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Jul 2007 06:25:11 -0400
Received: from main.gmane.org ([80.91.229.2]:49952 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752438AbXG3KZJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jul 2007 06:25:09 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IFSQv-0004WF-5t
	for git@vger.kernel.org; Mon, 30 Jul 2007 12:25:01 +0200
Received: from pd95b0fdb.dip0.t-ipconnect.de ([217.91.15.219])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 30 Jul 2007 12:25:01 +0200
Received: from dak by pd95b0fdb.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 30 Jul 2007 12:25:01 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: pd95b0fdb.dip0.t-ipconnect.de
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.51 (gnu/linux)
Cancel-Lock: sha1:Ru7LZ+mII7Y9ChV2OeiRDQe6OXY=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54221>

Jeff King <peff@peff.net> writes:

> Since I seem to recall you working some symlink magic with your
> installation in a recent message, that might be related. Is it just
> git-stash, or are other scripts failing (try "git status")?

Hmpf.  On another system (git version 1.5.3.rc3.48.g0d59d) this works.
I don't have the system at hand right now where it doesn't.  So it
would be my guess that either I have not called the install-symlinks
target recently enough, or its implementation on that system has been
broken for some time.

I'll have to check this evening.

On the other hand, I am quite sure that while "git stash" did not
work, "git-stash" had no problem.

So something bogus in git's PATH lookup would definitely appear to be
going on: it should be hard to get the symlinks messed up badly enough
to have one work and not the other.

More this evening.

-- 
David Kastrup
