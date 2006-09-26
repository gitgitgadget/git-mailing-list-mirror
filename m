From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Cleaned up git-daemon virtual hosting support.
Date: Mon, 25 Sep 2006 21:11:28 -0700
Message-ID: <7vd59jw9lb.fsf@assigned-by-dhcp.cox.net>
References: <E1GRhhk-0004O6-GP@jdl.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 26 06:12:04 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GS4IR-000673-OW
	for gcvg-git@gmane.org; Tue, 26 Sep 2006 06:11:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750761AbWIZELb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Sep 2006 00:11:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750876AbWIZELb
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Sep 2006 00:11:31 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:13556 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S1750761AbWIZELa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Sep 2006 00:11:30 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060926041129.BMYZ6711.fed1rmmtao04.cox.net@fed1rmimpo01.cox.net>;
          Tue, 26 Sep 2006 00:11:29 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id SsBS1V00u1kojtg0000000
	Tue, 26 Sep 2006 00:11:27 -0400
To: Jon Loeliger <jdl@jdl.com>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27765>

> Added --host=host_or_ipaddr option suport.

I wonder if --listen= might be more appropriate name:

        "Listen a.b.c.d:port" (Apache),
        "ListenAddress" (ssh daemon).
        "--listen-host=" (svnserve).

I wanted to find an example or two who uses "bind" but I think
listen is more popular.

> This is on top of my previous patch in the next branch.
> This makes virtual host support way, way less stupid.
> I'll follow up with another patch to clean up the small leaks.

Thanks.
