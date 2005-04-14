From: Petr Baudis <pasky@ucw.cz>
Subject: Re: Misc fixes for git-pasky
Date: Fri, 15 Apr 2005 00:49:34 +0200
Message-ID: <20050414224934.GO22699@pasky.ji.cz>
References: <1113518277.8609.8.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 15 00:46:48 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DMD6T-00029C-S8
	for gcvg-git@gmane.org; Fri, 15 Apr 2005 00:46:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261621AbVDNWtv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Apr 2005 18:49:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261620AbVDNWtv
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Apr 2005 18:49:51 -0400
Received: from w241.dkm.cz ([62.24.88.241]:24269 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261621AbVDNWtg (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 Apr 2005 18:49:36 -0400
Received: (qmail 16683 invoked by uid 2001); 14 Apr 2005 22:49:34 -0000
To: Pavel Roskin <proski@gnu.org>
Content-Disposition: inline
In-Reply-To: <1113518277.8609.8.camel@dv>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Fri, Apr 15, 2005 at 12:37:57AM CEST, I got a letter
where Pavel Roskin <proski@gnu.org> told me that...
> Hi, Petr!
> 
> The attached patch against current git-pasky does following:

Hum. It does too much at once, that means I cannot apply it easily. :-(

> * README: spell checked

Good. :-)

> * cache.h: Include unistd.h.  Needed for close() definition.  While
> current zlib.h header includes unistd.h, it's not guaranteed to be so in
> other zlib versions.

Sounds good.

> * read-cache.c: Avoid C++ comments.  C comments are more readable for C
> programmers.  Besides, we don't want git to be so unportable that "gcc
> -pedantic" cannot compile it.

I don't really care about this too much, although I personally prefer
the old-style comments. // comments are C99 so -pedantic by itself
should have no right to complain about it.

> * show-diff.c: Fix handling of more than one option of the command line.

What exactly does it fix? The current code seems fine to my sleepy
brain.

> Add new option "-c" to omit checksums for modified files.  Expand help.

How is the -c option useful?

Could you please send your patch with the correct inline settings on the
attachment (or just in the mail body) and signed off?

Thanks,

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
