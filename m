From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [howto] Kernel hacker's guide to git, updated
Date: Fri, 30 Sep 2005 07:15:41 -0400
Message-ID: <433D1E5D.20303@pobox.com>
References: <433BC9E9.6050907@pobox.com> <20050929200252.GA31516@redhat.com>	<433C4B6D.6030701@pobox.com> <7virwjegb5.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 30 13:17:58 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ELIs4-0001jb-Di
	for gcvg-git@gmane.org; Fri, 30 Sep 2005 13:16:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030276AbVI3LQE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 30 Sep 2005 07:16:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030279AbVI3LQE
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Sep 2005 07:16:04 -0400
Received: from mail.dvmed.net ([216.237.124.58]:58243 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1030276AbVI3LQB (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 30 Sep 2005 07:16:01 -0400
Received: from cpe-069-134-188-146.nc.res.rr.com ([69.134.188.146] helo=[10.10.10.88])
	by mail.dvmed.net with esmtpsa (Exim 4.52 #1 (Red Hat Linux))
	id 1ELIrr-0003Cf-Nb; Fri, 30 Sep 2005 11:15:58 +0000
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
To: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <7virwjegb5.fsf@assigned-by-dhcp.cox.net>
X-Spam-Score: 0.0 (/)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9553>


Thanks for all the comments.  I just updated the KHGtG with the feedback 
I received.  Go to

	http://linux.yyz.us/git-howto.html

and click reload.  Continued criticism^H^H^Hcomments welcome!



Two items of note:

1)
> automatically.  Running the following one-liner every once in a
> while would sync your set of tags with Linus:
> 
> git fetch origin `git-ls-remote --tags origin | sed -ne 's|^.*refs/tags/|tag |p'`

that's way too long and convoluted to deal with.  Once the 'git fetch 
--tags' changes make it into the official repository (are they there 
already?), I'll remove all the remaining direct references to running rsync.


2) What is the easiest way to obtain a list of changes present in 
repository B, that are not present in repository A?  I used to use 
git-changes-script [hacked cg-log script] for this:

	$ cd /repo/netdev-2.6
	$ git-changes-script -L ../linux-2.6

would display all changes in /repo/netdev-2.6 which are not present in 
/repo/linux-2.6.  This is similar to 'git log master..HEAD', except for 
repositories rather than branches.

	Jeff
