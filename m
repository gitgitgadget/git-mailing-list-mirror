From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] gitweb: export options
Date: Sun, 17 Sep 2006 01:53:17 -0700
Message-ID: <7v64fm7u2q.fsf@assigned-by-dhcp.cox.net>
References: <20060916192750.GA27008@moooo.ath.cx>
	<20060916223027.GA32679@moooo.ath.cx>
	<20060916223101.GB32679@moooo.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 17 10:53:24 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GOsOw-0003wl-Ir
	for gcvg-git@gmane.org; Sun, 17 Sep 2006 10:53:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932318AbWIQIxT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Sep 2006 04:53:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932321AbWIQIxT
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Sep 2006 04:53:19 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:54406 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S932318AbWIQIxS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Sep 2006 04:53:18 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060917085318.NDDV6711.fed1rmmtao04.cox.net@fed1rmimpo01.cox.net>;
          Sun, 17 Sep 2006 04:53:18 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id PLt51V00E1kojtg0000000
	Sun, 17 Sep 2006 04:53:06 -0400
To: Matthias Lederhofer <matled@gmx.net>
In-Reply-To: <20060916223101.GB32679@moooo.ath.cx> (Matthias Lederhofer's
	message of "Sun, 17 Sep 2006 00:31:01 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27168>

Matthias Lederhofer <matled@gmx.net> writes:

> $export_ok: If this variable evaluates to true it is checked
> if a file with this name exists in the repository.  If it
> does not exist the repository cannot be viewed from gitweb.
> (Similar to git-daemon-export-ok for git-daemon).
>
> $strict_export: If this variable evaluates to true only
> repositories listed on the project-list-page of gitweb can
> be accessed.

Is this replacement for your earlier two patches?

        [PATCH] gitweb: export-ok option
        [PATCH] gitweb: option 'strict export'

What's the difference between this and the previous two?

I am asking this question because I am lazy and do not want to
review two sets of similar patches ;-).
