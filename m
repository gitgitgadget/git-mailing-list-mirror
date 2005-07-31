From: Ryan Anderson <ryan@michonline.com>
Subject: Re: [PATCH 1/3] Add git-send-email-script - tool to send emails from git-format-patch-script
Date: Sun, 31 Jul 2005 04:24:30 -0400
Message-ID: <20050731082430.GG32263@mythryan2.michonline.com>
References: <11227978451100@foobar.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sun Jul 31 10:24:50 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dz97h-0001OS-8q
	for gcvg-git@gmane.org; Sun, 31 Jul 2005 10:24:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261167AbVGaIYc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 31 Jul 2005 04:24:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261840AbVGaIYc
	(ORCPT <rfc822;git-outgoing>); Sun, 31 Jul 2005 04:24:32 -0400
Received: from mail.autoweb.net ([198.172.237.26]:11497 "EHLO mail.autoweb.net")
	by vger.kernel.org with ESMTP id S261167AbVGaIYb (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 31 Jul 2005 04:24:31 -0400
Received: from pcp01184054pcs.strl301.mi.comcast.net ([68.60.186.73] helo=michonline.com)
	by mail.autoweb.net with esmtp (Exim 4.44)
	id 1Dz97X-0005o7-FD; Sun, 31 Jul 2005 04:24:31 -0400
Received: from mythical ([10.254.251.11] ident=Debian-exim)
	by michonline.com with esmtp (Exim 3.35 #1 (Debian))
	id 1Dz9HC-0004rL-00; Sun, 31 Jul 2005 04:34:30 -0400
Received: from ryan by mythical with local (Exim 4.52)
	id 1Dz97W-0001Cl-TK; Sun, 31 Jul 2005 04:24:30 -0400
To: junkio@cox.net, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <11227978451100@foobar.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sun, Jul 31, 2005 at 04:17:25AM -0400, Ryan Anderson wrote:
> This is based off of GregKH's script, send-lots-of-email.pl, and strives to do
> all the nice things a good subsystem maintainer does when forwarding a patch or
> 50 upstream:
> 
> 	All the prior handlers of the patch, as determined by the
> 	Signed-off-by: lines, and/or the author of the commit, are cc:ed on the
> 	email.
> 
> 	All emails are sent as a reply to the previous email, making it easy to
> 	skip a collection of emails that are uninteresting.
> 
> Signed-off-by: Ryan Anderson <ryan@michonline.com>

And yes, I did generate this thread with this script - so I have proof
that it works nicely.

Actually, with this:
	git format-patch -n --mbox -o ../pending/ origin
	git send-email ../pending/
	<answer some questions>

In 2-3 minutes I should have my git tree at
rsync://h4x0r5.com/git-ryan.git/ updated with these changes, and my
SYNOPSIS draft.  (I haven't added the short tutorial that Sam suggested
yet, that's a task for another 4am hackfest.)

-- 
Ryan Anderson
  sometimes Pug Majere
