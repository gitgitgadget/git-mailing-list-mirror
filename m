From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: cvs diff -l equivalent?
Date: Wed, 30 Jul 2008 14:25:22 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0807301424271.3277@nehalem.linux-foundation.org>
References: <20080730082030.GA12555@cuci.nl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: "Stephen R. van den Berg" <srb@cuci.nl>
X-From: git-owner@vger.kernel.org Wed Jul 30 23:30:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KOJF6-0005MS-Kl
	for gcvg-git-2@gmane.org; Wed, 30 Jul 2008 23:29:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753296AbYG3V2w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jul 2008 17:28:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753482AbYG3V2v
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Jul 2008 17:28:51 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:56796 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751929AbYG3V2u (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 30 Jul 2008 17:28:50 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m6ULSMcq002297
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 30 Jul 2008 14:28:23 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m6ULSLcB018130;
	Wed, 30 Jul 2008 14:28:22 -0700
In-Reply-To: <20080730082030.GA12555@cuci.nl>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Spam-Status: No, hits=-3.41 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90859>



On Wed, 30 Jul 2008, Stephen R. van den Berg wrote:

> Someone popped this question on me.  The closest I got was:
> 
>    git diff .
> 
> But that still recurses.  Any solutions without patching?

Not without patching, no. When generating a patch, git diff always 
recurses.

I suspect adding some kind of "-l" flag would be about five lines of code, 
though, so if you really need it... Hint, hint.

		Linus
