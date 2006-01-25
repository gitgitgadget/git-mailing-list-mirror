From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] rev-{list,parse}: allow -<n> as shorthand for --max-count=<n>
Date: Wed, 25 Jan 2006 01:52:48 -0800
Message-ID: <7v8xt4ws5r.fsf@assigned-by-dhcp.cox.net>
References: <20060124072946.GA9468@Muzzle>
	<7vd5iicauh.fsf@assigned-by-dhcp.cox.net>
	<20060125063325.GA7953@mail.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jan 25 10:53:26 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F1hL3-00059Q-Ta
	for gcvg-git@gmane.org; Wed, 25 Jan 2006 10:53:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751091AbWAYJwu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 25 Jan 2006 04:52:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751092AbWAYJwu
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Jan 2006 04:52:50 -0500
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:43963 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S1751091AbWAYJwt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jan 2006 04:52:49 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060125095002.KERB17437.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 25 Jan 2006 04:50:02 -0500
To: Eric Wong <normalperson@yhbt.net>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15127>

Eric Wong <normalperson@yhbt.net> writes:

> I don't agree with POSIX on this point, and I don't see why git should
> be bound to POSIX, especially at the UI level just because it's POSIX.

Unfortunately, it does not matter in the real world that you and
I both do not particularly like "head -n 4".  We will see more
people who feel "-n 4" more familiar than "-4", unlike old
fashioned people like myself.

> ...  Heck, I've
> been wanting GNU getopt_long() option parsing in git for a while...

We find somebody who wants to do this every now and then, it
seems.  Last time somebody brought this up in late May 2005, we
were still a "too rapidly moving" target, adding and changing
options every other day, and the actual implementation went
nowhere while the discussion was reasonably healthy.  If I
recall the discussion correctly, argp instead of GNU getopt was
the list favorite back then...
