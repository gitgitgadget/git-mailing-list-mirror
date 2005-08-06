From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: gitk "hyperlinks" (was Re: Display of merges in gitk)
Date: Sat, 6 Aug 2005 09:20:16 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0508060919150.3258@g5.osdl.org>
References: <17130.56620.137642.941175@cargo.ozlabs.ibm.com>
 <Pine.LNX.4.58.0508050658260.3258@g5.osdl.org> <Pine.LNX.4.58.0508050710460.3258@g5.osdl.org>
 <17140.47152.672091.474748@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Kay Sievers <kay.sievers@vrfy.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Aug 06 18:21:55 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E1RPe-0000WM-42
	for gcvg-git@gmane.org; Sat, 06 Aug 2005 18:20:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262230AbVHFQU2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 6 Aug 2005 12:20:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263242AbVHFQU2
	(ORCPT <rfc822;git-outgoing>); Sat, 6 Aug 2005 12:20:28 -0400
Received: from smtp.osdl.org ([65.172.181.4]:20203 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262230AbVHFQU0 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 6 Aug 2005 12:20:26 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j76GKHjA021509
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 6 Aug 2005 09:20:18 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j76GKG1g021623;
	Sat, 6 Aug 2005 09:20:17 -0700
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <17140.47152.672091.474748@cargo.ozlabs.ibm.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.113 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Sat, 6 Aug 2005, Paul Mackerras wrote:
> Linus Torvalds writes:
> > 
> >  - "clickable" SHA1's in commit messages would be really really cool if 
> >    something like that is even possible with tcl/tk.
> 
> Done, and it was even pretty easy.  It took only about a dozen lines.

Looks good also. I assume the mouse can't change when it hovers? 

> Good idea.  Also done. :)  It's on master.kernel.org now in my gitk.git
> directory.  Hopefully Junio will pull it into git soon.  The current
> version also squishes the graph horizontally if it gets too wide
> (i.e. more than half the width of the top-left pane).

Yeah, that looks weird when the lines start turning soft ans squiggly.

		Linus
