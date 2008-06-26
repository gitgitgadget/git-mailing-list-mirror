From: Petr Baudis <pasky@suse.cz>
Subject: Re: git-diff/git-format-patch safe for GNU (or POSIX) patch?
Date: Thu, 26 Jun 2008 15:44:00 +0200
Message-ID: <20080626134400.GC12567@machine.or.cz>
References: <58230.213.203.159.164.1214476059.squirrel@upmail.polettix.it> <20080626103607.GA16525@diana.vm.bytemark.co.uk> <58284.213.203.159.164.1214480989.squirrel@upmail.polettix.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Flavio Poletti <flavio@polettix.it>
X-From: git-owner@vger.kernel.org Thu Jun 26 15:45:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBrmZ-0005aJ-0F
	for gcvg-git-2@gmane.org; Thu, 26 Jun 2008 15:45:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755641AbYFZNoI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Jun 2008 09:44:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753333AbYFZNoI
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Jun 2008 09:44:08 -0400
Received: from w241.dkm.cz ([62.24.88.241]:41446 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752621AbYFZNoG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jun 2008 09:44:06 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id DF7281E4C025; Thu, 26 Jun 2008 15:44:00 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <58284.213.203.159.164.1214480989.squirrel@upmail.polettix.it>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86451>

On Thu, Jun 26, 2008 at 01:49:49PM +0200, Flavio Poletti wrote:
> Thanks for the feedback! I wonder if this feature of patch "ignoring"
> stuff it doesn't understand is a GNU feature or a POSIX feature, but I'm
> abusing your patience here. (Incidentally, I also saw that POSIX has no
> "unified" format, but this "ignoring" feature might apply in a wider
> sense).

As you say, POSIX does not specify unified diffs at all. I'm not sure if
patch's policy is as relaxed for other formats and I didn't find
any mention of this relaxed policy in the SUS spec, but unified diffs
with extraneous information intertwined are extremely widespread; about
any VCSes out there append extra information to the diffs.

Incidentally, does anyone actually know about _any_ other patch tool in
the wild that is _not_ based on the original Larry Wall's patch?

-- 
				Petr "Pasky" Baudis
The last good thing written in C++ was the Pachelbel Canon. -- J. Olson
