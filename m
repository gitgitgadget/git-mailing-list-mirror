From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] rev-{list,parse}: optionally allow -<n> as shorthand for --max-count=<n>
Date: Sun, 29 Jan 2006 12:15:29 -0800
Message-ID: <7v64o2kcym.fsf@assigned-by-dhcp.cox.net>
References: <20060124072946.GA9468@Muzzle>
	<7vd5iicauh.fsf@assigned-by-dhcp.cox.net>
	<20060125063325.GA7953@mail.yhbt.net> <20060129134056.GA3428@Muzzle>
	<20060129134720.GB3428@Muzzle>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jan 29 21:15:37 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F3IxR-0000Qg-Dw
	for gcvg-git@gmane.org; Sun, 29 Jan 2006 21:15:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751155AbWA2UPc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 29 Jan 2006 15:15:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751156AbWA2UPb
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Jan 2006 15:15:31 -0500
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:4540 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S1751155AbWA2UPb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Jan 2006 15:15:31 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060129201318.GFTZ17838.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 29 Jan 2006 15:13:18 -0500
To: Eric Wong <normalperson@yhbt.net>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15241>

Eric Wong <normalperson@yhbt.net> writes:

> This will only be enabled if POSIX_SHMOSIX is defined at compile-time.

Maybe a better name would be POSIX_ME_HARDER ^W oops, POSIXLY_CORRECT
to disable this?
