From: Paul Mackerras <paulus@samba.org>
Subject: Re: FFmpeg considering GIT
Date: Mon, 7 May 2007 22:13:44 +1000
Message-ID: <17983.6136.147062.346626@cargo.ozlabs.ibm.com>
References: <loom.20070502T111026-882@post.gmane.org>
	<20070503180016.GB21333@informatik.uni-freiburg.de>
	<20070503200013.GG4489@pasky.or.cz>
	<loom.20070504T143538-533@post.gmane.org>
	<87y7k4lahq.wl%cworth@cworth.org>
	<20070505133543.GC3379@diana.vm.bytemark.co.uk>
	<alpine.LFD.0.98.0705051019580.3819@woody.linux-foundation.org>
	<alpine.LFD.0.98.0705051511020.17381@woody.linux-foundation.org>
	<alpine.LFD.0.98.0705051524300.17381@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Karl Hasselstr?m <kha@treskal.com>,
	Junio C Hamano <junkio@cox.net>,
	Carl Worth <cworth@cworth.org>,
	Michael Niedermayer <michaelni@gmx.at>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon May 07 14:13:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hl26D-0001cQ-20
	for gcvg-git@gmane.org; Mon, 07 May 2007 14:13:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933506AbXEGMNt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 7 May 2007 08:13:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933629AbXEGMNt
	(ORCPT <rfc822;git-outgoing>); Mon, 7 May 2007 08:13:49 -0400
Received: from ozlabs.org ([203.10.76.45]:44123 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933506AbXEGMNt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 May 2007 08:13:49 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id 06D53DDE1C; Mon,  7 May 2007 22:13:48 +1000 (EST)
In-Reply-To: <alpine.LFD.0.98.0705051524300.17381@woody.linux-foundation.org>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46453>

Linus Torvalds writes:

> Finally, it realy _should_ check that the first 7 characters of the commit 
> log (the ones it ignores by just asking for substring 7..) are actually 
> the exact characters "commit ", but I'll blame my lack of comfort with the 
> language again.

I have thought about rewriting it in a different language, but I
haven't found anything that really appeals.  I don't want to go to
C/GTK or C/Qt since that would make it hard to port to Windows and
MacOS AFAIK.  Python/Tk would be a possibility, but I have never
learnt python and I'm actually not all that comfortable with having to
do things the object-oriented way.

Any suggestions?

Tcl/Tk does come with a comprehensive set of man pages, usually
installed either in section n or sections 3tcl and 3tk.  So you can do
"man string" to find out how to do string manipulations, for instance.
The syntax is quite regular and is explained in the "Tcl" man page.

Paul.
