From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] Add git-relink-script to fix up missing hardlinks
Date: Sun, 26 Jun 2005 15:44:15 -0400
Message-ID: <42BF058F.8010301@pobox.com>
References: <20050626181516.GC20369@mythryan2.michonline.com>	<7v7jghq6lt.fsf@assigned-by-dhcp.cox.net> <7vy88wq5hs.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Ryan Anderson <ryan@michonline.com>, git@vger.kernel.org,
	Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Sun Jun 26 21:44:30 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dmd3G-0006Uu-SW
	for gcvg-git@gmane.org; Sun, 26 Jun 2005 21:44:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261631AbVFZTu5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 26 Jun 2005 15:50:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261585AbVFZTt0
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Jun 2005 15:49:26 -0400
Received: from mail.dvmed.net ([216.237.124.58]:39628 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S261624AbVFZToY (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 26 Jun 2005 15:44:24 -0400
Received: from cpe-065-184-065-144.nc.res.rr.com ([65.184.65.144] helo=[10.10.10.88])
	by mail.dvmed.net with esmtpsa (Exim 4.51 #1 (Red Hat Linux))
	id 1Dmd3D-0006vM-Aa; Sun, 26 Jun 2005 19:44:21 +0000
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vy88wq5hs.fsf@assigned-by-dhcp.cox.net>
X-Spam-Score: 0.0 (/)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> I am a bit puzzled, though, why Jeff was the original requestor
> for this feature --- I thought he handles 50 heads in one
> repository which means there is no multiple repositories to
> relink across.

Sure there are.  Just watching my submissions on the mailing list, you 
can see ones mentioned such as "misc-2.6", "libata-dev", "netdev-2.6", etc.:

[jgarzik@pretzel repo]$ ls -FC
  config-2.4      ethtool/    libata-dev/  netdev-2.6/     sparse/
  config-2.6      git/        linux-2.6/   old-SCM/
  config-2.6-uml  git-tools/  misc-2.6/    scsi-misc-2.6/

And I always keep an unmodified 'vanilla' tree from which everything is 
sourced (and hardlinked to).

It's a categorization system, a namespace.  Top-level repositories are 
broad categories, and branches sub-divide those categories.

	Jeff
