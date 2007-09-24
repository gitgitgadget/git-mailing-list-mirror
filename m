From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: The msysGit Herald, issue 2
Date: Mon, 24 Sep 2007 08:44:49 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0709240840310.3579@woody.linux-foundation.org>
References: <Pine.LNX.4.64.0709232153230.28395@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: msysgit@googlegroups.com, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Sep 24 17:45:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IZq7m-00061B-Jd
	for gcvg-git-2@gmane.org; Mon, 24 Sep 2007 17:45:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758952AbXIXPp1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Sep 2007 11:45:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756235AbXIXPp1
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Sep 2007 11:45:27 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:55268 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756103AbXIXPp0 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 24 Sep 2007 11:45:26 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l8OFiniU027648
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 24 Sep 2007 08:44:51 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l8OFinoP004445;
	Mon, 24 Sep 2007 08:44:49 -0700
In-Reply-To: <Pine.LNX.4.64.0709232153230.28395@racer.site>
X-Spam-Status: No, hits=-2.739 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.39__
X-MIMEDefang-Filter: lf$Revision: 1.185 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59056>



On Sun, 23 Sep 2007, Johannes Schindelin wrote:
>
> > 6) What was the most frustrating moment when working with Git?
> 
> Just the other day, I wanted to fetch a set of changes from a public
> repo into my test repo in order to cherry-pick from them - and it
> automatically fetched all the tags. But, the heck, I don't want them tags
> here, just the commits. I just can't figure out how to avoid the automatic
> fetching of tags.

The way this was *supposed* to work is that if you are not fetching a 
"tracking branch", it should not fetch any tags.

Maybe this got broken lately?

Or maybe you did fetch a tracking branch?

Anyway, I fetch stuff all the time, and if git were to fetch the tags too, 
I'd be *really* unhappy. So either the people I work with are just good 
people, or more likely it still works the way it's supposed to work: if 
you just fetch into FETCH_HEAD (by explicitly giving the remote repository 
name, and not using tracking branches), it should not fetch tags for you.

			Linus
