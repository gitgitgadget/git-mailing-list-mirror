From: Junio C Hamano <junkio@cox.net>
Subject: Re: [howto] Kernel hacker's guide to git, updated
Date: Fri, 30 Sep 2005 00:37:09 -0700
Message-ID: <7vslvn6m6y.fsf@assigned-by-dhcp.cox.net>
References: <433BC9E9.6050907@pobox.com>
	<200509292108.11092.oliver@neukum.org>
	<1128022473.14595.6.camel@cashmere.sps.mot.com>
	<200509292138.26183.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 30 09:38:45 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ELFSJ-0004ef-RR
	for gcvg-git@gmane.org; Fri, 30 Sep 2005 09:37:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751202AbVI3HhM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 30 Sep 2005 03:37:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751419AbVI3HhM
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Sep 2005 03:37:12 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:34971 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S1751202AbVI3HhL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Sep 2005 03:37:11 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050930073704.PJLT24014.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 30 Sep 2005 03:37:04 -0400
To: Oliver Neukum <oliver@neukum.org>
In-Reply-To: <200509292138.26183.oliver@neukum.org> (Oliver Neukum's message
	of "Thu, 29 Sep 2005 21:38:25 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9544>

Oliver Neukum <oliver@neukum.org> writes:

> Am Donnerstag, 29. September 2005 21:34 schrieb Jon Loeliger:
>> On Thu, 2005-09-29 at 14:08, Oliver Neukum wrote:
>> 
>> > Unfortunately, following the instructions to the letter produces this:
>> > oliver@oenone:~/linux-2.6> git checkout
>> > usage: read-tree (<sha> | -m <sha1> [<sha2> <sha3>])
>> 
>> Yeah.  See if you still have a .git/HEADS that symlinks
>> to a valid place or not...?
>
> oliver@oenone:~/linux-2.6> ls -la .git/
> insgesamt 14
> drwxrwxr-x    6 oliver users  224 2005-09-29 21:06 .
> drwxr-xr-x    3 oliver users   72 2005-09-29 20:45 ..
> -rw-rw-r--    1 oliver users   19 2005-05-02 01:02 description
> lrwxrwxrwx    1 oliver users   17 2005-09-29 21:06 HEAD -> refs/heads/master
> -rw-------    1 oliver users   32 2005-09-29 21:06 index

I wonder what that 32-byte small file called 'index' is doing
there.  If this is the kernel tree, its index file should weigh
about 1.7MB if I recall correctly.
