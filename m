From: Junio C Hamano <junkio@cox.net>
Subject: Re: [howto] Kernel hacker's guide to git, updated
Date: Fri, 30 Sep 2005 04:55:04 -0700
Message-ID: <7v64si4von.fsf@assigned-by-dhcp.cox.net>
References: <433BC9E9.6050907@pobox.com> <20050929200252.GA31516@redhat.com>
	<433C4B6D.6030701@pobox.com> <7virwjegb5.fsf@assigned-by-dhcp.cox.net>
	<433D1E5D.20303@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 30 13:55:20 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ELJTz-0006IC-SG
	for gcvg-git@gmane.org; Fri, 30 Sep 2005 13:55:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751443AbVI3LzI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 30 Sep 2005 07:55:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751441AbVI3LzI
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Sep 2005 07:55:08 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:31899 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S1751440AbVI3LzG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Sep 2005 07:55:06 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050930115503.SADV4527.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 30 Sep 2005 07:55:03 -0400
To: Jeff Garzik <jgarzik@pobox.com>
In-Reply-To: <433D1E5D.20303@pobox.com> (Jeff Garzik's message of "Fri, 30 Sep
	2005 07:15:41 -0400")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9554>

Jeff Garzik <jgarzik@pobox.com> writes:

> ...  Once the 'git fetch --tags' changes make it into the
> official repository (are they there already?), I'll remove all
> the remaining direct references to running rsync.

Sounds like a thinly veiled threat and/or very effective
prodding ;-).

It is not there yet only because I simply have not got around to
it, but it will happen before 0.99.8.

I suspect the version Linus posted has a funny interaction with
'git-pull'; 'git pull --tags' by mistake, or intentionally to
file a bug report to annoy me ;-), would create an Octopus out
of those tags, if I am not mistaken.

> 2) What is the easiest way to obtain a list of changes present in 
> repository B, that are not present in repository A?  I used to use 
> git-changes-script [hacked cg-log script] for this:

I think I still have the copy you sent to the list.  If you do
not mind me placing in the master branch just holler -- better
yet please send a patch with commit log and signoff to add the
latest, and I will apply it.

-jc
