From: Joel Becker <Joel.Becker@oracle.com>
Subject: Re: git-commit: allow From: line to be entered in commit message
Date: Fri, 13 Jan 2006 11:12:31 -0800
Message-ID: <20060113191231.GM14196@ca-server1.us.oracle.com>
References: <20060112093700.1d3d25db.seanlkml@sympatico.ca> <20060112190031.GH14196@ca-server1.us.oracle.com> <7vhd89mc0y.fsf@assigned-by-dhcp.cox.net> <20060113065855.GJ14196@ca-server1.us.oracle.com> <7vpsmwbo9s.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 13 20:12:49 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ExULo-0001VC-HM
	for gcvg-git@gmane.org; Fri, 13 Jan 2006 20:12:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422819AbWAMTMh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 13 Jan 2006 14:12:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422834AbWAMTMh
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Jan 2006 14:12:37 -0500
Received: from rgminet01.oracle.com ([148.87.122.30]:33416 "EHLO
	rgminet01.oracle.com") by vger.kernel.org with ESMTP
	id S1422819AbWAMTMh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jan 2006 14:12:37 -0500
Received: from rgmsgw02.us.oracle.com (rgmsgw02.us.oracle.com [138.1.186.52])
	by rgminet01.oracle.com (Switch-3.1.6/Switch-3.1.6) with ESMTP id k0DJCW5R009065;
	Fri, 13 Jan 2006 12:12:32 -0700
Received: from rgmsgw02.us.oracle.com (localhost.localdomain [127.0.0.1])
	by rgmsgw02.us.oracle.com (Switch-3.1.7/Switch-3.1.7) with ESMTP id k0DJCVjx013514;
	Fri, 13 Jan 2006 12:12:31 -0700
Received: from ca-server1.us.oracle.com (ca-server1.us.oracle.com [139.185.48.5])
	by rgmsgw02.us.oracle.com (Switch-3.1.7/Switch-3.1.7) with ESMTP id k0DJCUi9013489
	(version=TLSv1/SSLv3 cipher=DES-CBC3-SHA bits=168 verify=NO);
	Fri, 13 Jan 2006 12:12:31 -0700
Received: from jlbec by ca-server1.us.oracle.com with local (Exim 4.60)
	(envelope-from <joel.becker@oracle.com>)
	id 1ExULf-0002Eu-Kz; Fri, 13 Jan 2006 11:12:31 -0800
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vpsmwbo9s.fsf@assigned-by-dhcp.cox.net>
X-Burt-Line: Trees are cool.
X-Red-Smith: Ninety feet between bases is perhaps as close as man has ever come to perfection.
User-Agent: Mutt/1.5.11
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14637>

On Thu, Jan 12, 2006 at 11:06:07PM -0800, Junio C Hamano wrote:
> Joel Becker <Joel.Becker@oracle.com> writes:
> 
> > Well, I'm wary of putting
> > GIT_AUTHOR_EMAIL=joel.becker@oracle.com as a permanent part of my
> > environment, for fear of overriding some other authors at some point.
> 
> The weakest default comes from .git/config so you could have
> this in your .git/config:
> 
> 	[user]
>         	name = Joel Becker 
>                 email = Joel.Becker@oracle.com

	This configuration is something I have the opportunity to forget
every time I call git-clone.  So I still need to leave it in the
environment permanently.
	Am I correct in assuming that "From:" lines will override the
environment when using git-applymbox?  If so, I guess leaving
GIT_AUTHOR_* in my environment permanently will be ok.

Joel

-- 

"War doesn't determine who's right; war determines who's left."

Joel Becker
Principal Software Developer
Oracle
E-mail: joel.becker@oracle.com
Phone: (650) 506-8127
