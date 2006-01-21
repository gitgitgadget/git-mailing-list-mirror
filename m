From: Petr Baudis <pasky@suse.cz>
Subject: Re: cg-update bug?
Date: Sat, 21 Jan 2006 21:35:19 +0100
Message-ID: <20060121203519.GN28365@pasky.or.cz>
References: <dqo6fs$sr$1@sea.gmane.org> <dqtih0$i80$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 21 21:33:58 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F0PQn-0007bN-L1
	for gcvg-git@gmane.org; Sat, 21 Jan 2006 21:33:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932324AbWAUUdv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 Jan 2006 15:33:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932326AbWAUUdv
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Jan 2006 15:33:51 -0500
Received: from w241.dkm.cz ([62.24.88.241]:64214 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S932324AbWAUUdu (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 21 Jan 2006 15:33:50 -0500
Received: (qmail 9560 invoked by uid 2001); 21 Jan 2006 21:35:19 +0100
To: walt <wa1ter@myrealbox.com>
Content-Disposition: inline
In-Reply-To: <dqtih0$i80$1@sea.gmane.org>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15018>

Dear diary, on Sat, Jan 21, 2006 at 04:03:59PM CET, I got a letter
where walt <wa1ter@myrealbox.com> said that...
> walt wrote:
> > ...there is no -v flag for cg-update.  Could it be added
> > so I can get the old behavior back?
> 
> Thanks for adding the flag, Petr.  I tried it on git and
> the kernel this morning, and in each case cg-update -v
> printed the name of only one file.  From looking at the
> logs I'm pretty sure there were multiple files updated,
> not just one.  Does it print all filenames for you?

It prints all the filenames for me, but only the fetched ones. If you
fetched without merge earlier, it will list only the newly fetched
stuff. That is rather confusing, so now I added also cg-merge -v and
cg-update will pass its -v to cg-merge instead of cg-fetch.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Of the 3 great composers Mozart tells us what it's like to be human,
Beethoven tells us what it's like to be Beethoven and Bach tells us
what it's like to be the universe.  -- Douglas Adams
