From: Joel Becker <Joel.Becker@oracle.com>
Subject: Re: /bin/sh portability question
Date: Fri, 23 Sep 2005 12:57:06 -0700
Message-ID: <20050923195706.GV27375@ca-server1.us.oracle.com>
References: <20050923075058.GA25473@bohr.gbar.dtu.dk> <43345C17.7060402@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Peter Eriksen <s022018@student.dtu.dk>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 23 21:58:55 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EItfe-0000XI-2X
	for gcvg-git@gmane.org; Fri, 23 Sep 2005 21:57:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751029AbVIWT5T (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 23 Sep 2005 15:57:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751121AbVIWT5T
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Sep 2005 15:57:19 -0400
Received: from agminet02.oracle.com ([141.146.126.229]:51441 "EHLO
	agminet02.oracle.com") by vger.kernel.org with ESMTP
	id S1751029AbVIWT5T (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Sep 2005 15:57:19 -0400
Received: from rgmsgw04.us.oracle.com (rgmsgw04.us.oracle.com [138.1.186.54])
	by agminet02.oracle.com (Switch-3.1.7/Switch-3.1.7) with ESMTP id j8NJx0dQ000921;
	Fri, 23 Sep 2005 14:59:01 -0500
Received: from rgmsgw04.us.oracle.com (localhost.localdomain [127.0.0.1])
	by rgmsgw04.us.oracle.com (Switch-3.1.7/Switch-3.1.7) with ESMTP id j8NJv7BX026010;
	Fri, 23 Sep 2005 13:57:07 -0600
Received: from ca-server1.us.oracle.com (ca-server1.us.oracle.com [139.185.118.41])
	by rgmsgw04.us.oracle.com (Switch-3.1.7/Switch-3.1.7) with ESMTP id j8NJv6NJ026003
	(version=TLSv1/SSLv3 cipher=DES-CBC3-SHA bits=168 verify=NO);
	Fri, 23 Sep 2005 13:57:07 -0600
Received: from jlbec by ca-server1.us.oracle.com with local (Exim 4.52)
	id 1EItfO-0005rV-Qg; Fri, 23 Sep 2005 12:57:06 -0700
To: "H. Peter Anvin" <hpa@zytor.com>
Content-Disposition: inline
In-Reply-To: <43345C17.7060402@zytor.com>
X-Burt-Line: Trees are cool.
X-Red-Smith: Ninety feet between bases is perhaps as close as man has ever come to perfection.
User-Agent: Mutt/1.5.10i
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9199>

On Fri, Sep 23, 2005 at 12:48:39PM -0700, H. Peter Anvin wrote:
> Peter Eriksen wrote:
> >      path=$(dirname $0)
> > ...
> >      ./git.sh: syntax error at line 4: `path=$' unexpected
> 
> I think $(foo) is required by POSIX.

	I believe that Solaris and others (AIX IIRC) have /bin/sh linked
to /bin/ksh, and it behaves as the POSIX shell when run as /bin/ksh, but
behaves as a much more true-to-bourne shell when run as /bin/sh.

Joel

-- 

"Nearly all men can stand adversity, but if you really want to
 test a man's character, give him power."
	- Abraham Lincoln

Joel Becker
Principal Software Developer
Oracle
E-mail: joel.becker@oracle.com
Phone: (650) 506-8127
