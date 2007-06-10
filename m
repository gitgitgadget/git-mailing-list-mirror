From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: fatal: serious inflate inconsistency
Date: Sat, 9 Jun 2007 17:30:38 -0700 (PDT)
Message-ID: <alpine.LFD.0.98.0706091727050.20321@woody.linux-foundation.org>
References: <alpine.LFD.0.99.0706080931330.12885@xanadu.home>
 <20070608135054.GK2335@cip.informatik.uni-erlangen.de>
 <20070608153722.GL2335@cip.informatik.uni-erlangen.de>
 <alpine.LFD.0.98.0706080959570.4205@woody.linux-foundation.org>
 <20070608182412.GQ2335@cip.informatik.uni-erlangen.de>
 <alpine.LFD.0.98.0706081136480.4205@woody.linux-foundation.org>
 <alpine.LFD.0.98.0706081202580.4205@woody.linux-foundation.org>
 <20070608193319.GS2335@cip.informatik.uni-erlangen.de>
 <20070608204557.GA18840@fiberbit.xs4all.nl> <20070609001333.GA4058@cip.informatik.uni-erlangen.de>
 <20070609211213.GA18761@cip.informatik.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Marco Roeland <marco.roeland@xs4all.nl>,
	Nicolas Pitre <nico@cam.org>, GIT <git@vger.kernel.org>,
	Michael Gernoth <simigern@cip.informatik.uni-erlangen.de>
To: Thomas Glanzmann <thomas@glanzmann.de>
X-From: git-owner@vger.kernel.org Sun Jun 10 02:31:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HxBL4-000654-8q
	for gcvg-git@gmane.org; Sun, 10 Jun 2007 02:31:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751363AbXFJAbZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 9 Jun 2007 20:31:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751304AbXFJAbZ
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Jun 2007 20:31:25 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:57408 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751289AbXFJAbY (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 9 Jun 2007 20:31:24 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l5A0UjFr017919
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 9 Jun 2007 17:30:46 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l5A0UcS9015005;
	Sat, 9 Jun 2007 17:30:39 -0700
In-Reply-To: <20070609211213.GA18761@cip.informatik.uni-erlangen.de>
X-Spam-Status: No, hits=-2.744 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.12__
X-MIMEDefang-Filter: osdl$Revision: 1.181 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49645>



On Sat, 9 Jun 2007, Thomas Glanzmann wrote:
>
> the machine that had the issues just got down because of a broken power
> supply and took half the rack with it. So it was definitive a hardware
> fault. Sorry for all the trouble. And the bottom line is: It was _not_
> git, it was broken hardware!

Good. That was one of the design goals for git (ie the "you know you can 
trust the data" thing relies on very strong protection at all levels, 
even in the presense of disk/memory/cpu corruption).

I think we have a pretty good record on this: the only real git-induced 
corruption I can remember was the embarrassing bug with use-after-free of 
the CRLF auto-translation. But let's not get complacent.

		Linus
