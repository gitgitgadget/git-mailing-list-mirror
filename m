From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Questions on 'cvs migration guide''
Date: Thu, 18 Aug 2005 21:33:24 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0508182130050.3412@g5.osdl.org>
References: <46a038f9050818201717f9ed93@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: GIT <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Aug 19 06:34:37 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E5yZP-0002JF-8i
	for gcvg-git@gmane.org; Fri, 19 Aug 2005 06:33:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932541AbVHSEd2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 19 Aug 2005 00:33:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932546AbVHSEd2
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Aug 2005 00:33:28 -0400
Received: from smtp.osdl.org ([65.172.181.4]:36583 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932541AbVHSEd1 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 19 Aug 2005 00:33:27 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j7J4XPjA007374
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 18 Aug 2005 21:33:25 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j7J4XO8j028131;
	Thu, 18 Aug 2005 21:33:24 -0700
To: Martin Langhoff <martin.langhoff@gmail.com>
In-Reply-To: <46a038f9050818201717f9ed93@mail.gmail.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.45__
X-MIMEDefang-Filter: osdl$Revision: 1.114 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Fri, 19 Aug 2005, Martin Langhoff wrote:
>
> In the section 'Emulating CVS behaviour', where the team setup is
> described with a team 'merger'. What is not clear is how to deal with
> project-wide branches. Should they be created in the master repo, and
> everyone clone a new repo from it?

Just make them another branch in the master repo. Whether people will 
clone a whole new repo for it, or have just one repo and switch between 
local branches in their own local (single) repo is their personal choice. 
Some people may well prefer to have all different branches checked out in 
different places (ie have one repository per branch) others may prefer to 
work with one repository and just switch.

> And yet another question: the teammember who is pulling must 'switch'
> the merging repo to the right branch, pull from the corresponding
> remote repos of each teammember, and push to the public view of the
> repo. Is that right?

.. yes. Or alternatively, just keep the repo at that branch (and if such a 
person works on multiple branches, he/she can thus just keep multiple 
repos). 

		Linus
