From: Joel Becker <Joel.Becker@oracle.com>
Subject: Re: [RFC] git-fsck-cache argument processing
Date: Sat, 21 May 2005 15:14:01 -0700
Message-ID: <20050521221401.GR22946@ca-server1.us.oracle.com>
References: <4870.10.10.10.24.1116646732.squirrel@linux1> <20050521150926.GA96606@dspnet.fr.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sean <seanlkml@sympatico.ca>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 22 00:17:54 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DZcFK-0006kE-UI
	for gcvg-git@gmane.org; Sun, 22 May 2005 00:15:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261658AbVEUWQO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 May 2005 18:16:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261661AbVEUWQO
	(ORCPT <rfc822;git-outgoing>); Sat, 21 May 2005 18:16:14 -0400
Received: from rgminet02.oracle.com ([148.87.122.31]:24270 "EHLO
	rgminet02.oracle.com") by vger.kernel.org with ESMTP
	id S261658AbVEUWQM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 May 2005 18:16:12 -0400
Received: from rgmgw3.us.oracle.com (rgmgw3.us.oracle.com [138.1.191.12])
	by rgminet02.oracle.com (Switch-3.1.6/Switch-3.1.7) with ESMTP id j4LME2H1018597;
	Sat, 21 May 2005 16:14:02 -0600
Received: from rgmgw3.us.oracle.com (localhost [127.0.0.1])
	by rgmgw3.us.oracle.com (Switch-3.1.4/Switch-3.1.0) with ESMTP id j4LME2Ou031430;
	Sat, 21 May 2005 16:14:02 -0600
Received: from ca-server1.us.oracle.com (ca-server1.us.oracle.com [139.185.118.41])
	by rgmgw3.us.oracle.com (Switch-3.1.4/Switch-3.1.0) with ESMTP id j4LME2M4031425;
	Sat, 21 May 2005 16:14:02 -0600
Received: from jlbec by ca-server1.us.oracle.com with local (Exim 4.50)
	id 1DZcEL-0002gK-Sv; Sat, 21 May 2005 15:14:01 -0700
To: Olivier Galibert <galibert@pobox.com>
Content-Disposition: inline
In-Reply-To: <20050521150926.GA96606@dspnet.fr.eu.org>
X-Burt-Line: Trees are cool.
X-Red-Smith: Ninety feet between bases is perhaps as close as man has ever come to perfection.
User-Agent: Mutt/1.5.9i
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sat, May 21, 2005 at 05:09:26PM +0200, Olivier Galibert wrote:
> On Fri, May 20, 2005 at 11:38:52PM -0400, Sean wrote:
> >  -?, --help             Give this help list
> 
> Could you make that '-h' please ?

	I generally think supporting -? and -h is the usual thing.  SysV
loves -?, most real folks like -h.

> >  -V, --version          Print program version
> 
> And that '-v'.  -V traditionally means verbose, -v version.  Yes, I
> know there are counter-examples, but statistically...

	I've never seen -V mean verbose.  I just queried all of
coreutils, and as most folks expect, -v means verbose.  Statistically,
I'd be interested in seeing statistics.  I've never used a program where
-V meant verbose.  I've never used a program that had '--verbose' where
'-v' didn't mean verbose.  tar(1), rsync(1), chgrp(1), chown(1), cp(1),
mkdir(1), all use '-v' for verbose.

Joel

-- 

"The nearest approach to immortality on Earth is a government
 bureau."
	- James F. Byrnes

Joel Becker
Senior Member of Technical Staff
Oracle
E-mail: joel.becker@oracle.com
Phone: (650) 506-8127
