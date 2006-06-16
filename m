From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Why so much time in the kernel?
Date: Fri, 16 Jun 2006 11:32:42 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0606161132160.5498@g5.osdl.org>
References: <9e4733910606160749t4d7a541ev72a67383e96d86da@mail.gmail.com> 
 <Pine.LNX.4.64.0606160755170.5498@g5.osdl.org> 
 <9e4733910606160825hb538d6fo4c9f1d7d9768e100@mail.gmail.com> 
 <Pine.LNX.4.64.0606160906250.5498@g5.osdl.org>
 <9e4733910606161000t53328571u10a350eca894ccdc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jun 16 20:33:16 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FrJ7l-0004cQ-GK
	for gcvg-git@gmane.org; Fri, 16 Jun 2006 20:32:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751335AbWFPScu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Jun 2006 14:32:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751338AbWFPScu
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Jun 2006 14:32:50 -0400
Received: from smtp.osdl.org ([65.172.181.4]:38281 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751335AbWFPSct (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 16 Jun 2006 14:32:49 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k5GIWigt018644
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 16 Jun 2006 11:32:45 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k5GIWgXB026005;
	Fri, 16 Jun 2006 11:32:43 -0700
To: Jon Smirl <jonsmirl@gmail.com>
In-Reply-To: <9e4733910606161000t53328571u10a350eca894ccdc@mail.gmail.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.76__
X-MIMEDefang-Filter: osdl$Revision: 1.135 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21963>



On Fri, 16 Jun 2006, Jon Smirl wrote:
>
> Is it a crazy idea to read the cvs files, compute an sha1 on each
> expanded delta and then write the delta straight into a pack file? Are
> the cvs and git delta formats the same? What about CVS's forward and
> reverse delta use? While this is going on, track the
> branches/changsets in memory and then finish up by writing these trees
> into the pack file too. This should take no more ram than cvsps needs
> currently.

What you want is parsecvs, which does it much more like that.

		Linus
