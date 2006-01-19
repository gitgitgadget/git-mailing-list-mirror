From: Joel Becker <Joel.Becker@oracle.com>
Subject: Re: /etc in git?
Date: Thu, 19 Jan 2006 08:54:58 -0800
Message-ID: <20060119165458.GF4380@ca-server1.us.oracle.com>
References: <b476569a0601181943y6a14e703k1b521a7edb9e2e2@mail.gmail.com> <7vlkxckf7o.fsf@assigned-by-dhcp.cox.net> <b476569a0601182040w581b72b7xbb99845da4085646@mail.gmail.com> <7v64ogkdtu.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Adam Hunt <kinema@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 19 17:55:39 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ezd41-00017L-7r
	for gcvg-git@gmane.org; Thu, 19 Jan 2006 17:55:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932487AbWASQzF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 Jan 2006 11:55:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932483AbWASQzF
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jan 2006 11:55:05 -0500
Received: from agminet01.oracle.com ([141.146.126.228]:56125 "EHLO
	agminet01.oracle.com") by vger.kernel.org with ESMTP
	id S932572AbWASQzD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jan 2006 11:55:03 -0500
Received: from rgmsgw02.us.oracle.com (rgmsgw02.us.oracle.com [138.1.186.52])
	by agminet01.oracle.com (Switch-3.1.7/Switch-3.1.7) with ESMTP id k0JGswaF000809;
	Thu, 19 Jan 2006 10:54:59 -0600
Received: from rgmsgw02.us.oracle.com (localhost.localdomain [127.0.0.1])
	by rgmsgw02.us.oracle.com (Switch-3.1.7/Switch-3.1.7) with ESMTP id k0JGswxq007939;
	Thu, 19 Jan 2006 09:54:58 -0700
Received: from ca-server1.us.oracle.com (ca-server1.us.oracle.com [139.185.48.5])
	by rgmsgw02.us.oracle.com (Switch-3.1.7/Switch-3.1.7) with ESMTP id k0JGsvvk007924
	(version=TLSv1/SSLv3 cipher=DES-CBC3-SHA bits=168 verify=NO);
	Thu, 19 Jan 2006 09:54:57 -0700
Received: from jlbec by ca-server1.us.oracle.com with local (Exim 4.60)
	(envelope-from <joel.becker@oracle.com>)
	id 1Ezd3q-0005oC-7j; Thu, 19 Jan 2006 08:54:58 -0800
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7v64ogkdtu.fsf@assigned-by-dhcp.cox.net>
X-Burt-Line: Trees are cool.
X-Red-Smith: Ninety feet between bases is perhaps as close as man has ever come to perfection.
User-Agent: Mutt/1.5.11
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14914>

On Wed, Jan 18, 2006 at 09:05:01PM -0800, Junio C Hamano wrote:
> You are much better off to keep /usr/src/rootstuff/.git (and
> working tree files are /usr/src/rootstuff/etc/hosts and
> friends), have a build procedure (read: Makefile) there, and
> version control that source directory.  I usually have 'install'
> and 'diff' target in that Makefile, so that I can do this:

	A while back I wrote CVSMan, which tries to be berkeley sup(8)
with CVS as the transport.  I think git would work well here, but I
haven't yet generalized the code to support non-CVS SCMs (I certainly
have wanted to, it's the only thing I use CVS for anymore).
	Like GIT, CVS doesn't do perms well.  However, CVSMan handles
the perms via .cvsperms files.

Joel

-- 

"What does it say about a society's priorities when the time you
 spend in meetings on Monday is greater than the total number of
 hours you spent sleeping over the weekend?"
	- Nat Friedman

Joel Becker
Principal Software Developer
Oracle
E-mail: joel.becker@oracle.com
Phone: (650) 506-8127
