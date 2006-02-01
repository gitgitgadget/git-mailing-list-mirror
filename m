From: Junio C Hamano <junkio@cox.net>
Subject: Re: Question around git-shell usage in Everyday Git
Date: Wed, 01 Feb 2006 15:30:28 -0800
Message-ID: <7vslr264iz.fsf@assigned-by-dhcp.cox.net>
References: <200602012301.56141.alan@chandlerfamily.org.uk>
	<7vy80u64xf.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 02 00:30:41 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F4RQo-00067L-12
	for gcvg-git@gmane.org; Thu, 02 Feb 2006 00:30:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423026AbWBAXab (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Feb 2006 18:30:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423027AbWBAXab
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Feb 2006 18:30:31 -0500
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:34007 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S1423026AbWBAXaa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Feb 2006 18:30:30 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060201232900.NZIM20441.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 1 Feb 2006 18:29:00 -0500
To: Alan Chandler <alan@chandlerfamily.org.uk>
In-Reply-To: <7vy80u64xf.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Wed, 01 Feb 2006 15:21:48 -0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15464>

Junio C Hamano <junkio@cox.net> writes:

> Do you mean to reuse single directory /home/gitu/ for user A, B, C,
> and hang repositories /home/gitu/{X,Y,Z} for projects?  I'd
> imagine things could be arranged that way.  User A and B but not
> C may be in "projectX" group and /home/gitu/X is writable only
> by projectX group members and such...

OTOH, if you did things the way as you suggested:

>URL:git@host.com:repository.git
>and in ~git/.ssh/authorized_keys putting all the developers
>public keys.

you cannot tell a person using one key to become "git" on that
machine from another person using different key to become the
same "git" on that machine; if you do not care about that
then it is OK.  That would work only when all of your git
repositories are supposed to be accessible by everybody.

But I suspect doing so would not let you have different projects
with different subset of "git" users on your shared machine.
