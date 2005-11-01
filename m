From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git versus CVS (versus bk)
Date: Mon, 31 Oct 2005 18:23:02 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0510311822080.27915@g5.osdl.org>
References: <Pine.LNX.4.64.0510301720390.14972@x2.ybpnyarg>
 <Pine.LNX.4.64.0510301811390.27915@g5.osdl.org>
 <Pine.LNX.4.63.0510311111340.2916@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0510310804400.27915@g5.osdl.org> <20051031195010.GM11488@ca-server1.us.oracle.com>
 <46a038f90510311228v50743158q80d79e963bd503ce@mail.gmail.com>
 <86hdaxf6wq.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Martin Langhoff <martin.langhoff@gmail.com>,
	Joel Becker <Joel.Becker@oracle.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	walt <wa1ter@myrealbox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 01 03:26:48 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EWlr7-0006LC-PF
	for gcvg-git@gmane.org; Tue, 01 Nov 2005 03:26:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964935AbVKAC0T (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 31 Oct 2005 21:26:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964945AbVKAC0T
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Oct 2005 21:26:19 -0500
Received: from smtp.osdl.org ([65.172.181.4]:17573 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964935AbVKAC0T (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 31 Oct 2005 21:26:19 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id jA12N3W6031779
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 31 Oct 2005 18:23:03 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id jA12N219010586;
	Mon, 31 Oct 2005 18:23:02 -0800
To: "Randal L. Schwartz" <merlyn@stonehenge.com>
In-Reply-To: <86hdaxf6wq.fsf@blue.stonehenge.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.55__
X-MIMEDefang-Filter: osdl$Revision: 1.127 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10919>



On Mon, 31 Oct 2005, Randal L. Schwartz wrote:
> 
> Martin>    cg-diff -r from:to | patch -p1
> 
> What's the easiest way then to toss all that intermediate history?
> I'm thinking of the rcs "-o" switch that "outdates" any deltas in that
> range.

Start a new branch before the sequence you want to clean up. Then, move 
the cleaned-up history to that branch, and eventually you can just delete 
the old one.

		Linus
