From: Joel Becker <Joel.Becker@oracle.com>
Subject: Re: git-commit: allow From: line to be entered in commit message
Date: Thu, 12 Jan 2006 22:58:55 -0800
Message-ID: <20060113065855.GJ14196@ca-server1.us.oracle.com>
References: <20060112093700.1d3d25db.seanlkml@sympatico.ca> <20060112190031.GH14196@ca-server1.us.oracle.com> <7vhd89mc0y.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 13 07:59:08 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ExItq-0006Ta-Bs
	for gcvg-git@gmane.org; Fri, 13 Jan 2006 07:59:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161401AbWAMG67 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 13 Jan 2006 01:58:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161479AbWAMG67
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Jan 2006 01:58:59 -0500
Received: from agminet01.oracle.com ([141.146.126.228]:64591 "EHLO
	agminet01.oracle.com") by vger.kernel.org with ESMTP
	id S1161401AbWAMG67 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jan 2006 01:58:59 -0500
Received: from rgmsgw02.us.oracle.com (rgmsgw02.us.oracle.com [138.1.186.52])
	by agminet01.oracle.com (Switch-3.1.7/Switch-3.1.7) with ESMTP id k0D6wtlS001379;
	Fri, 13 Jan 2006 00:58:56 -0600
Received: from rgmsgw02.us.oracle.com (localhost.localdomain [127.0.0.1])
	by rgmsgw02.us.oracle.com (Switch-3.1.7/Switch-3.1.7) with ESMTP id k0D6wtcM021459;
	Thu, 12 Jan 2006 23:58:55 -0700
Received: from ca-server1.us.oracle.com (ca-server1.us.oracle.com [139.185.48.5])
	by rgmsgw02.us.oracle.com (Switch-3.1.7/Switch-3.1.7) with ESMTP id k0D6ws5u021453
	(version=TLSv1/SSLv3 cipher=DES-CBC3-SHA bits=168 verify=NO);
	Thu, 12 Jan 2006 23:58:55 -0700
Received: from jlbec by ca-server1.us.oracle.com with local (Exim 4.60)
	(envelope-from <joel.becker@oracle.com>)
	id 1ExItj-0000RA-M5; Thu, 12 Jan 2006 22:58:55 -0800
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vhd89mc0y.fsf@assigned-by-dhcp.cox.net>
X-Burt-Line: Trees are cool.
X-Red-Smith: Ninety feet between bases is perhaps as close as man has ever come to perfection.
User-Agent: Mutt/1.5.11
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14617>

On Thu, Jan 12, 2006 at 12:22:53PM -0800, Junio C Hamano wrote:
> Committing somebody else's changes by hand ought to be a rare
> event.  Otherwise that is an indication that there needs to be a
>...
> Most of the time when I use "git commit", I'll be committing my
> own changes; I do not want to see "From: me" every time I
> commit.

	Well, I'm wary of putting
GIT_AUTHOR_EMAIL=joel.becker@oracle.com as a permanent part of my
environment, for fear of overriding some other authors at some point.
On the other hand, if I don't put it in the environment, I get a bogus
author line (jlbec@thisbox.oracle.com).  So I end up having to
hand-write the AUTHOR_EMAIL lines on each commit line; not a solution
I'm happy with.
	This way, I'd have a chance to edit it and be sure :-)

Joel
 

-- 

Life's Little Instruction Book #274

	"Leave everything a little better than you found it."

Joel Becker
Principal Software Developer
Oracle
E-mail: joel.becker@oracle.com
Phone: (650) 506-8127
