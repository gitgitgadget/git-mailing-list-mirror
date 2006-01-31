From: Joel Becker <Joel.Becker@oracle.com>
Subject: Re: [Census] So who uses git?
Date: Tue, 31 Jan 2006 14:55:14 -0800
Message-ID: <20060131225514.GC2812@ca-server1.us.oracle.com>
References: <46a038f90601251810m1086d353ne8c7147edee4962a@mail.gmail.com> <Pine.LNX.4.64.0601272345540.2909@evo.osdl.org> <46a038f90601272133o53438987ka6b97c21d0cdf921@mail.gmail.com> <1138446030.9919.112.camel@evo.keithp.com> <7vzmlgt5zt.fsf@assigned-by-dhcp.cox.net> <20060130185822.GA24487@hpsvcnb.fc.hp.com> <Pine.LNX.4.63.0601311127250.25248@wbgn013.biozentrum.uni-wuerzburg.de> <Pine.LNX.4.64.0601310926330.7301@g5.osdl.org> <1138734110.18852.26.camel@evo.keithp.com> <Pine.LNX.4.64.0601311110210.7301@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Keith Packard <keithp@keithp.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Carl Baldwin <cnb@fc.hp.com>, Junio C Hamano <junkio@cox.net>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Feb 01 00:02:13 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F44Vf-00088T-1u
	for gcvg-git@gmane.org; Wed, 01 Feb 2006 00:02:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750929AbWAaXCA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 31 Jan 2006 18:02:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750932AbWAaXCA
	(ORCPT <rfc822;git-outgoing>); Tue, 31 Jan 2006 18:02:00 -0500
Received: from rgminet01.oracle.com ([148.87.113.118]:46559 "EHLO
	rgminet01.oracle.com") by vger.kernel.org with ESMTP
	id S1750927AbWAaXB6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Jan 2006 18:01:58 -0500
Received: from rgmsgw02.us.oracle.com (rgmsgw02.us.oracle.com [138.1.186.52])
	by rgminet01.oracle.com (Switch-3.1.6/Switch-3.1.6) with ESMTP id k0VMtF3f031100;
	Tue, 31 Jan 2006 15:55:15 -0700
Received: from rgmsgw02.us.oracle.com (localhost.localdomain [127.0.0.1])
	by rgmsgw02.us.oracle.com (Switch-3.1.7/Switch-3.1.7) with ESMTP id k0VMtFXg000600;
	Tue, 31 Jan 2006 15:55:15 -0700
Received: from ca-server1.us.oracle.com (ca-server1.us.oracle.com [139.185.48.5])
	by rgmsgw02.us.oracle.com (Switch-3.1.7/Switch-3.1.7) with ESMTP id k0VMtEe7000587
	(version=TLSv1/SSLv3 cipher=DES-CBC3-SHA bits=168 verify=NO);
	Tue, 31 Jan 2006 15:55:15 -0700
Received: from jlbec by ca-server1.us.oracle.com with local (Exim 4.60)
	(envelope-from <joel.becker@oracle.com>)
	id 1F44P4-0001CE-Eq; Tue, 31 Jan 2006 14:55:14 -0800
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0601311110210.7301@g5.osdl.org>
X-Burt-Line: Trees are cool.
X-Red-Smith: Ninety feet between bases is perhaps as close as man has ever come to perfection.
User-Agent: Mutt/1.5.11
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15359>

On Tue, Jan 31, 2006 at 11:21:52AM -0800, Linus Torvalds wrote:
> Now, I do agree. I don't actually like hiding the index too much. 
> Understanding the index is _invaluable_ whenever you're doing a merge with 
> conflicts, and understanding what tools are available to you to resolve 
> those conflicts.

	This is precisely the experience I've had explaining GIT to
folks moving to it.  The simplest workflow (clone; hack one file, commit
one file) is so similar to CVS/Subversion/Anything that it's immediately
understood.  But when pull, push, merge, and any non-linear history are
discussed, I have to describe the index and the commit/tree layout.
Once I do, they get it.

> So I'm actually of the "revel in the index" camp (as could probably be 
> guessed by the original tutorial).

	I'm going to second this, from a real-world "explain it to
others" standpoint.

Joel

-- 

"Every day I get up and look through the Forbes list of the richest
 people in America. If I'm not there, I go to work."
        - Robert Orben

Joel Becker
Principal Software Developer
Oracle
E-mail: joel.becker@oracle.com
Phone: (650) 506-8127
