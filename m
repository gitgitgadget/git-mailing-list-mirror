From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Importing Mozilla CVS into git
Date: Thu, 1 Jun 2006 16:48:29 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0606011643290.5498@g5.osdl.org>
References: <9e4733910606011521n106f8f24s6c7053ce51e3791e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 02 01:49:42 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Flwv7-0005ot-Iu
	for gcvg-git@gmane.org; Fri, 02 Jun 2006 01:49:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751023AbWFAXss (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Jun 2006 19:48:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751022AbWFAXss
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Jun 2006 19:48:48 -0400
Received: from smtp.osdl.org ([65.172.181.4]:57222 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751021AbWFAXsl (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 1 Jun 2006 19:48:41 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k51NmY2g015443
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 1 Jun 2006 16:48:34 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k51NmT2G021982;
	Thu, 1 Jun 2006 16:48:32 -0700
To: Jon Smirl <jonsmirl@gmail.com>
In-Reply-To: <9e4733910606011521n106f8f24s6c7053ce51e3791e@mail.gmail.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.75__
X-MIMEDefang-Filter: osdl$Revision: 1.135 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21129>



On Thu, 1 Jun 2006, Jon Smirl wrote:
>
> I've been working on importing the Mozilla CVS into git for the last
> few days. I've fixed up parsecvs so that it can parse the entire
> repository without errors. Now I'm running into problems because there
> are over 300 branches.
> 
> I just run into a problem with git show-branch. Mozilla CVS has a lot
> more than 29 refs, is this something that can be expanded?

Hmm.. Any reason you care about "show-branch --all" in particular?

The algorithm used for show-branch really doesn't scale well, it needs one 
bit per commit per branch, and I didn't realize anybody could ever really 
care.

		Linus
