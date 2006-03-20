From: Junio C Hamano <junkio@cox.net>
Subject: Re: efficient cloning
Date: Mon, 20 Mar 2006 15:49:26 -0800
Message-ID: <7vfylcismx.fsf@assigned-by-dhcp.cox.net>
References: <m3r74ykue7.fsf@lugabout.cloos.reno.nv.us>
	<7vbqw1nakz.fsf@assigned-by-dhcp.cox.net>
	<7vu09tjy38.fsf@assigned-by-dhcp.cox.net>
	<200603201730.19373.Josef.Weidendorfer@gmx.de>
	<7voe00iupp.fsf@assigned-by-dhcp.cox.net>
	<20060320232101.GQ18185@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 21 00:49:54 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FLU8G-0007hp-SF
	for gcvg-git@gmane.org; Tue, 21 Mar 2006 00:49:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750719AbWCTXt3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 20 Mar 2006 18:49:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750785AbWCTXt3
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Mar 2006 18:49:29 -0500
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:22964 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S1750719AbWCTXt3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Mar 2006 18:49:29 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060320234625.FQIL17006.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 20 Mar 2006 18:46:25 -0500
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20060320232101.GQ18185@pasky.or.cz> (Petr Baudis's message of
	"Tue, 21 Mar 2006 00:21:01 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17772>

Petr Baudis <pasky@suse.cz> writes:

> I still don't get what's wrong on what I'm proposing. I'm not seeing the
> disadvantages, if there are any.

The only thing I think there is is that I do not get what you
are proposing ;-), since I am not paying full attention while at
day-job.

If you are proposing to root --use-separate-remote not at
refs/remotes but refs/remotes/origin/, I think it makes kind of
sense.  It would make tons of sense _if_ dealing more than one
remote repository is the norm, but otherwise you would have an
extra level of directory refs/remotes which almost always have
only one subdirectory 'origin' and nothing else, which is
pointless.

I am not sure if you are also advocating to map (somehow) origin
to remotes/origin/master (or whatever branch remote's HEAD
points at), but if so I am not quite sure what its semantics
would be.  Which remote branch would you pick (that would not
necessarily be "master") and where are you going to record that
and when.  It all sounds to me complicating things
unnecessarily.
