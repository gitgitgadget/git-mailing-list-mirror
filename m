From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: gitk-1.1 out
Date: Wed, 8 Jun 2005 07:49:38 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0506080743040.2286@ppc970.osdl.org>
References: <17053.35147.52729.794561@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 08 16:45:44 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dg1mn-00041r-9H
	for gcvg-git@gmane.org; Wed, 08 Jun 2005 16:44:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261261AbVFHOrw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 8 Jun 2005 10:47:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261277AbVFHOrw
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Jun 2005 10:47:52 -0400
Received: from fire.osdl.org ([65.172.181.4]:21677 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261261AbVFHOri (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 8 Jun 2005 10:47:38 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j58ElXjA019672
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 8 Jun 2005 07:47:33 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j58ElWYo023210;
	Wed, 8 Jun 2005 07:47:32 -0700
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <17053.35147.52729.794561@cargo.ozlabs.ibm.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Wed, 1 Jun 2005, Paul Mackerras wrote:
> 
> * Commits that are pointed to by a tag in .git/refs/tags are now
>   marked with a little yellow "luggage label" shape attached to the
>   circle representing the commit.  The tag name is written on the
>   label.

Can you do the same for things in .git/refs/heads? Possibly using another 
color?

I realize that that may sound silly, but a tree that has many branches can 
validly be used with gitk with something like this:

	gitk $(ls .git/refs/heads)

and it results in gitk correctly showing all the different heads, but 
because they aren't marked in the output, it's almost impossible to 
understand what's up.

You can try it out with something like Jeff's tree at 

	rsync://rsync.kernel.org/pub/scm/linux/kernel/git/jgarzik/netdev-2.6.git/

if you want to, but the reason I noticed was that I was trying it out with
the result of "git cvsimport" in a tree that had branches. If it had had
flags for the branches, it would have been an _extremely_ nice
visualization tool, as it was it was just "cool, but I can't tell what
those different tips are" ;)

		Linus
