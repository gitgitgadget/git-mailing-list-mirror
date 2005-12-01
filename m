From: Junio C Hamano <junkio@cox.net>
Subject: Re: keeping remote repo checked out?
Date: Wed, 30 Nov 2005 18:43:10 -0800
Message-ID: <7vacflmta9.fsf@assigned-by-dhcp.cox.net>
References: <m3k6et9rdw.fsf@lugabout.cloos.reno.nv.us>
	<7vbr051ad1.fsf@assigned-by-dhcp.cox.net>
	<m38xv5r50x.fsf@lugabout.cloos.reno.nv.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 01 03:51:57 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EheVz-0004O2-2m
	for gcvg-git@gmane.org; Thu, 01 Dec 2005 03:49:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932065AbVLACtG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 30 Nov 2005 21:49:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932066AbVLACtG
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Nov 2005 21:49:06 -0500
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:30206 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S932065AbVLACtF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Nov 2005 21:49:05 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051201024203.VXDW17838.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 30 Nov 2005 21:42:03 -0500
To: James Cloos <cloos@jhcloos.com>
In-Reply-To: <m38xv5r50x.fsf@lugabout.cloos.reno.nv.us> (James Cloos's message
	of "Wed, 30 Nov 2005 20:15:58 -0500")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13037>

James Cloos <cloos@jhcloos.com> writes:

>>>>>> "Junio" == Junio C Hamano <junkio@cox.net> writes:
>
> Junio> Creative use of hooks/post-update would solve that.
>
> I'll have to look into that.

Documentation/howto/rebuild-from-update-hook.txt may help.

I push into the master repository, and its post-update hook
checks out the updated "master" head to rebuild the HTML
documentation that is shown at

	http://kernel.org/pub/software/scm/git/docs/

The checkout happens not in the master repository but in a
separate repository by pulling into the latter, since the master
is a naked repository without a working tree associated with it.
