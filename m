From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-commit: allow From: line to be entered in commit message
Date: Fri, 13 Jan 2006 11:39:17 -0800
Message-ID: <7vhd877w9m.fsf@assigned-by-dhcp.cox.net>
References: <20060112093700.1d3d25db.seanlkml@sympatico.ca>
	<20060112190031.GH14196@ca-server1.us.oracle.com>
	<7vhd89mc0y.fsf@assigned-by-dhcp.cox.net>
	<20060113065855.GJ14196@ca-server1.us.oracle.com>
	<7vpsmwbo9s.fsf@assigned-by-dhcp.cox.net>
	<20060113191231.GM14196@ca-server1.us.oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 13 20:39:33 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ExUle-0008RD-Ss
	for gcvg-git@gmane.org; Fri, 13 Jan 2006 20:39:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422862AbWAMTjT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 13 Jan 2006 14:39:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422863AbWAMTjT
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Jan 2006 14:39:19 -0500
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:2957 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S1422862AbWAMTjS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jan 2006 14:39:18 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060113193641.UHWB20050.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 13 Jan 2006 14:36:41 -0500
To: Joel Becker <Joel.Becker@oracle.com>
In-Reply-To: <20060113191231.GM14196@ca-server1.us.oracle.com> (Joel Becker's
	message of "Fri, 13 Jan 2006 11:12:31 -0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14640>

Joel Becker <Joel.Becker@oracle.com> writes:

> 	Am I correct in assuming that "From:" lines will override the
> environment when using git-applymbox?  If so, I guess leaving
> GIT_AUTHOR_* in my environment permanently will be ok.

That's what I do.  Although I use git-am not git-applymbox, both
of them are designed to work that way.
