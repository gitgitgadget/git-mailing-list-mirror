From: Greg KH <greg@kroah.com>
Subject: Re: [git pasky] tarball question
Date: Fri, 22 Apr 2005 11:23:53 -0700
Message-ID: <20050422182353.GA599@kroah.com>
References: <1114180303.29271.25.camel@nosferatu.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT Mailing Lists <git@vger.kernel.org>, Petr Baudis <pasky@ucw.cz>
X-From: git-owner@vger.kernel.org Fri Apr 22 20:20:26 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DP2kz-0004uQ-5Q
	for gcvg-git@gmane.org; Fri, 22 Apr 2005 20:20:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262103AbVDVSYS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Apr 2005 14:24:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262104AbVDVSYS
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Apr 2005 14:24:18 -0400
Received: from mail.kroah.org ([69.55.234.183]:12699 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262103AbVDVSYP (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 22 Apr 2005 14:24:15 -0400
Received: from [192.168.0.10] (c-24-22-118-199.hsd1.or.comcast.net [24.22.118.199])
	(authenticated)
	by perch.kroah.org (8.11.6/8.11.6) with ESMTP id j3MIO8i01039;
	Fri, 22 Apr 2005 11:24:08 -0700
Received: from greg by echidna.kroah.org with local (masqmail 0.2.19)
 id 1DP2oj-09t-00; Fri, 22 Apr 2005 11:23:53 -0700
To: Martin Schlemmer <azarah@nosferatu.za.org>
Content-Disposition: inline
In-Reply-To: <1114180303.29271.25.camel@nosferatu.lan>
User-Agent: Mutt/1.5.8i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 22, 2005 at 04:31:43PM +0200, Martin Schlemmer wrote:
> Hi,
> 
> I understand why you have the git-pasky-0.6.x.tar.bz2 tarballs with
> the .git database included as well (btw, great stuff renaming it to
> something more distributable), but its going to be a pita for users of
> source based distro's like us (Gentoo), as well as our mirrors if it
> gets much bigger. (Already asked r3pek to add it to portage).

Ah good, I was already makeing a ebuild for it, I'll let others do it
then :)

> How about ripping the .git directory from the next release, and just
> have a un-numbered tarball (like you used to) that have the latest
> snapshot of the .git directory for those that want to do git-pasky
> development?  Should even make things easier your side, as you could
> just do a cron to update it one a day/whatever.

Why?  The .git directory doesn't hurt anything that gentoo would do, we
would just update the ebuild for the major releases.

thanks,

greg k-h
