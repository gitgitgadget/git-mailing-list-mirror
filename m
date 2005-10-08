From: Junio C Hamano <junkio@cox.net>
Subject: Re: Seeing various mode changes on cygwin
Date: Sat, 08 Oct 2005 16:36:17 -0700
Message-ID: <7vzmpjoa32.fsf@assigned-by-dhcp.cox.net>
References: <20051008180023.GC28875@diku.dk>
	<7vfyrbrgdw.fsf@assigned-by-dhcp.cox.net>
	<20051008213612.GA5794@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 09 01:39:27 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EOOGh-00043M-NQ
	for gcvg-git@gmane.org; Sun, 09 Oct 2005 01:38:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932180AbVJHXgT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 8 Oct 2005 19:36:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932186AbVJHXgT
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Oct 2005 19:36:19 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:31735 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S932180AbVJHXgS (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Oct 2005 19:36:18 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051008233611.QPGL9394.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 8 Oct 2005 19:36:11 -0400
To: Alex Riesen <raa.lkml@gmail.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9857>

Alex Riesen <raa.lkml@gmail.com> writes:

> These are not real attributes, cygwin emulates them from the names,
> like .exe will always be 0755, for example.

Ouch.  Is this true in general, or only on FAT-derived
filesystems?

We may need to worry about this on the core side after all.
Some people need to mount FAT even on Linux systems, 
