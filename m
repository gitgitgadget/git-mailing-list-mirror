From: Petr Baudis <pasky@suse.cz>
Subject: Re: Problem in update from the linux-2.6 repository
Date: Mon, 7 Nov 2005 23:23:53 +0100
Message-ID: <20051107222353.GV1431@pasky.or.cz>
References: <1131380293.5824.139.camel@blade> <1131401931.5824.149.camel@blade>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 07 23:24:39 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EZFPD-00082O-Ua
	for gcvg-git@gmane.org; Mon, 07 Nov 2005 23:24:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965557AbVKGWX5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 7 Nov 2005 17:23:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965556AbVKGWX4
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Nov 2005 17:23:56 -0500
Received: from w241.dkm.cz ([62.24.88.241]:42958 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S965554AbVKGWX4 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 7 Nov 2005 17:23:56 -0500
Received: (qmail 26494 invoked by uid 2001); 7 Nov 2005 23:23:53 +0100
To: Marcel Holtmann <marcel@holtmann.org>
Content-Disposition: inline
In-Reply-To: <1131401931.5824.149.camel@blade>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11284>

  Hi,

Dear diary, on Mon, Nov 07, 2005 at 11:18:51PM CET, I got a letter
where Marcel Holtmann <marcel@holtmann.org> told me that...
> > I run into a weird problem when trying to update my clone of the
> > linux-2.6 repository from Linus:
> > 
> > ---
> > # cg-update -f
> > 17:09:00 URL:http://www.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git/HEAD [41/41] -> "refs/heads/.origin-fetching" [1]
> > Getting alternates list
> > Getting pack list
> > error: Unable to find 2ed5e6d09e266bd2288d49aaaf240ed8c468c13c under http://www.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git/
> > 
> > Cannot obtain needed object 2ed5e6d09e266bd2288d49aaaf240ed8c468c13c
> > while processing commit 0000000000000000000000000000000000000000.
> > cg-fetch: objects fetch failed
> > ---
> 
> forget about this thing. The reason for this problem was the kernel.org
> mirroring and the repository wasn't in a sane state. However it would be
> great if we can detect this somehow.

  well, we did detect this and error out. ;-) What else would you like
GIT/Cogito to do? Anything particular that could make this less
confusing?

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
