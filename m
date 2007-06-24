From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Darcs
Date: Sun, 24 Jun 2007 16:21:05 -0700 (PDT)
Message-ID: <alpine.LFD.0.98.0706241618490.3593@woody.linux-foundation.org>
References: <cecbdd220706232232w77a609faxf0e6b2dc37f0d1f4@mail.gmail.com> 
 <alpine.LFD.0.98.0706241030540.3593@woody.linux-foundation.org>
 <46a038f90706241345m4b5ecb80p9f4ec840993023e0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Bu Bacoo <bubacoo@gmail.com>, git@vger.kernel.org
To: Martin Langhoff <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 25 01:21:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I2bOQ-0002Xi-56
	for gcvg-git@gmane.org; Mon, 25 Jun 2007 01:21:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751422AbXFXXVO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 24 Jun 2007 19:21:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751418AbXFXXVO
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Jun 2007 19:21:14 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:56364 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751226AbXFXXVN (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 24 Jun 2007 19:21:13 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l5ONLAB5003455
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 24 Jun 2007 16:21:11 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l5ONL57J023009;
	Sun, 24 Jun 2007 16:21:05 -0700
In-Reply-To: <46a038f90706241345m4b5ecb80p9f4ec840993023e0@mail.gmail.com>
X-Spam-Status: No, hits=-2.561 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.12__
X-MIMEDefang-Filter: osdl$Revision: 1.181 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50842>



On Mon, 25 Jun 2007, Martin Langhoff wrote:
> 
> The darcs commandset (init, push, pull) is what git, hg and bzr have
> today in common.

I really think the credit goes to BK, not darcs. 

BK is why a lot of git commands look like they do: I didn't want to 
re-implement BK, but I definitely wanted to reimplement the flow. At least 
for common stuff.

The fact that darcs may have been more usable than other open source scm's 
says more about the other open source scm's than it says about darcs. 

arch/tla in particular was (is?) horribly messy. I tried to look at it 
before starting git, but even just a cursory look convinced me to look 
away..

		Linus
