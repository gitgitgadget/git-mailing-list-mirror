From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: Documentation (mainly user-manual) patches
Date: Sat, 19 May 2007 00:13:57 -0400
Message-ID: <20070519041357.GA2679@fieldses.org>
References: <20070518033746.GB30144@fieldses.org> <20070518045634.GU4489@pasky.or.cz> <20070518134316.GA21925@fieldses.org> <20070519040212.GC3141@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Petr Baudis <pasky@suse.cz>, Junio C Hamano <junkio@cox.net>,
	git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat May 19 06:14:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HpGKW-00075h-O0
	for gcvg-git@gmane.org; Sat, 19 May 2007 06:14:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750893AbXESEOE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 19 May 2007 00:14:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755302AbXESEOE
	(ORCPT <rfc822;git-outgoing>); Sat, 19 May 2007 00:14:04 -0400
Received: from mail.fieldses.org ([66.93.2.214]:35041 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750893AbXESEOD (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 May 2007 00:14:03 -0400
Received: from bfields by fieldses.org with local (Exim 4.67)
	(envelope-from <bfields@fieldses.org>)
	id 1HpGKL-0002Re-O7; Sat, 19 May 2007 00:13:57 -0400
Content-Disposition: inline
In-Reply-To: <20070519040212.GC3141@spearce.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47710>

On Sat, May 19, 2007 at 12:02:12AM -0400, Shawn O. Pearce wrote:
> request-pull also does nice things like include the fetch URL, and
> the branch name, and in a nice format that makes it very easy to
> copy and paste into a "git pull" (or "git fetch") command line[*1*],
> so its slightly more than just the shortlog.  ;-)

I know, but that's not hard to do by hand.  Which doesn't, of course,
mean I won't screw it up....

But, actually, I tried it just now and it only gave the url:

	The following changes since commit 164b19893ab5bc66b531a26480149a0dff082969:
	  Michael Hendricks (1):
		Document core.excludesfile for git-add

	are found in the git repository at:

		git://linux-nfs.org/~bfields/git.git

How's it supposed to figure out the branch name?  (And I'm not sure
about that "change since commit..." stuff--that seems like slight
overkill.)

--b.
