From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: test suite fails if sh != bash || tar != GNU tar
Date: Tue, 10 Jul 2007 20:22:24 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0707102020020.3412@woody.linux-foundation.org>
References: <7154c5c60707101939sc921b07wef1d14f85086947d@mail.gmail.com>
 <Pine.LNX.4.64.0707110347580.4047@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: David Frech <nimblemachines@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jul 11 05:23:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I8SnE-0008UA-1a
	for gcvg-git@gmane.org; Wed, 11 Jul 2007 05:23:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756363AbXGKDWf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Jul 2007 23:22:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756009AbXGKDWf
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Jul 2007 23:22:35 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:47748 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756100AbXGKDWe (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 Jul 2007 23:22:34 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l6B3MThx024367
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 10 Jul 2007 20:22:30 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l6B3MOei019813;
	Tue, 10 Jul 2007 20:22:24 -0700
In-Reply-To: <Pine.LNX.4.64.0707110347580.4047@racer.site>
X-Spam-Status: No, hits=-2.296 required=5 tests=AWL,BAYES_00,MANY_EXCLAMATIONS
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.12__
X-MIMEDefang-Filter: osdl$Revision: 1.181 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52131>



On Wed, 11 Jul 2007, Johannes Schindelin wrote:
> 
> Actually, Ubuntu seems to ship with dash as the default shell, and we had 
> quite some fallout from that change.

Well, part of it was really dash bugs, no? The whole "'shift' on an empty 
argument list" seemed to be a total and outright dash bug, and wasn't 
about relying on bash "features".

But we've had tons of issues with different spacing for "wc -l" etc, so 
yeah, the silly details matter even when there aren't outright bugs in 
tools.

> As for GNU tar, I think that this is easily fixable if you have access to 
> non-GNU tar.  We do not use tar _ever_, except for the test suite, to 
> verify that things are working as expected.
> 
> If you could put in some time to make the tests work, that would be 
> awesome.

Yeah, it would be a good thing to get rid of any bashisms, but to _keep_ 
it working somebody would then need to test every once in a while that it 
still works ;)

		Linus
