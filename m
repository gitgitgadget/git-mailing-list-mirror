From: Joel Becker <Joel.Becker@oracle.com>
Subject: Re: git versus CVS (versus bk)
Date: Mon, 31 Oct 2005 13:30:03 -0800
Message-ID: <20051031213003.GN11488@ca-server1.us.oracle.com>
References: <Pine.LNX.4.64.0510301720390.14972@x2.ybpnyarg> <Pine.LNX.4.64.0510301811390.27915@g5.osdl.org> <Pine.LNX.4.63.0510311111340.2916@wbgn013.biozentrum.uni-wuerzburg.de> <Pine.LNX.4.64.0510310804400.27915@g5.osdl.org> <20051031195010.GM11488@ca-server1.us.oracle.com> <46a038f90510311228v50743158q80d79e963bd503ce@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	walt <wa1ter@myrealbox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 31 22:31:49 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EWhEX-0005Vk-RA
	for gcvg-git@gmane.org; Mon, 31 Oct 2005 22:30:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932535AbVJaVaX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 31 Oct 2005 16:30:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932540AbVJaVaX
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Oct 2005 16:30:23 -0500
Received: from agminet03.oracle.com ([141.146.126.230]:62497 "EHLO
	agminet03.oracle.com") by vger.kernel.org with ESMTP
	id S932535AbVJaVaW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Oct 2005 16:30:22 -0500
Received: from rgmsgw02.us.oracle.com (rgmsgw02.us.oracle.com [138.1.186.52])
	by agminet03.oracle.com (Switch-3.1.7/Switch-3.1.7) with ESMTP id j9VLU5vm022009;
	Mon, 31 Oct 2005 15:30:05 -0600
Received: from rgmsgw02.us.oracle.com (localhost.localdomain [127.0.0.1])
	by rgmsgw02.us.oracle.com (Switch-3.1.7/Switch-3.1.7) with ESMTP id j9VLU4w1014590;
	Mon, 31 Oct 2005 14:30:04 -0700
Received: from ca-server1.us.oracle.com (ca-server1.us.oracle.com [139.185.118.41])
	by rgmsgw02.us.oracle.com (Switch-3.1.7/Switch-3.1.7) with ESMTP id j9VLU40F014562
	(version=TLSv1/SSLv3 cipher=DES-CBC3-SHA bits=168 verify=NO);
	Mon, 31 Oct 2005 14:30:04 -0700
Received: from jlbec by ca-server1.us.oracle.com with local (Exim 4.53)
	id 1EWhEB-0005zb-SV; Mon, 31 Oct 2005 13:30:03 -0800
To: Martin Langhoff <martin.langhoff@gmail.com>
Content-Disposition: inline
In-Reply-To: <46a038f90510311228v50743158q80d79e963bd503ce@mail.gmail.com>
X-Burt-Line: Trees are cool.
X-Red-Smith: Ninety feet between bases is perhaps as close as man has ever come to perfection.
User-Agent: Mutt/1.5.10i
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10889>

On Tue, Nov 01, 2005 at 09:28:30AM +1300, Martin Langhoff wrote:
> You can do a diff that spans all the commits and apply it with a new
> commit msg. With cogito:
> 
>    cg-diff -r from:to | patch -p1

	I'm well aware of this, my question was rather one of
applicability.  First, do we want it to work this way, losing the
history.  Second, you'd like the process to be all encompasing if you go
this route.

    ((cd old-repo && cg-diff -r from) | patch -p1) && cg-commit

or any equivalent.  Why should I have to muck with patch and diff, when
I can have a 'pull-as-one' operation.  Sure, it's a wrapper, but if its
the intended mode of development, let's make it a first-class citizen.

Joel

-- 

Life's Little Instruction Book #157 

	"Take time to smell the roses."

Joel Becker
Principal Software Developer
Oracle
E-mail: joel.becker@oracle.com
Phone: (650) 506-8127
