From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-commit: allow From: line to be entered in commit message
Date: Thu, 12 Jan 2006 23:06:07 -0800
Message-ID: <7vpsmwbo9s.fsf@assigned-by-dhcp.cox.net>
References: <20060112093700.1d3d25db.seanlkml@sympatico.ca>
	<20060112190031.GH14196@ca-server1.us.oracle.com>
	<7vhd89mc0y.fsf@assigned-by-dhcp.cox.net>
	<20060113065855.GJ14196@ca-server1.us.oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 13 08:06:16 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ExJ0n-0007XO-RO
	for gcvg-git@gmane.org; Fri, 13 Jan 2006 08:06:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161480AbWAMHGK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 13 Jan 2006 02:06:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161482AbWAMHGJ
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Jan 2006 02:06:09 -0500
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:43473 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S1161480AbWAMHGI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jan 2006 02:06:08 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060113070331.JXXP20050.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 13 Jan 2006 02:03:31 -0500
To: Joel Becker <Joel.Becker@oracle.com>
In-Reply-To: <20060113065855.GJ14196@ca-server1.us.oracle.com> (Joel Becker's
	message of "Thu, 12 Jan 2006 22:58:55 -0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14618>

Joel Becker <Joel.Becker@oracle.com> writes:

> Well, I'm wary of putting
> GIT_AUTHOR_EMAIL=joel.becker@oracle.com as a permanent part of my
> environment, for fear of overriding some other authors at some point.

The weakest default comes from .git/config so you could have
this in your .git/config:

	[user]
        	name = Joel Becker 
                email = Joel.Becker@oracle.com

and you can have GIT_AUTHOR_* override it as necessary.
