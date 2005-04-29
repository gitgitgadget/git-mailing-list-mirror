From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Mercurial 0.4b vs git patchbomb benchmark
Date: Fri, 29 Apr 2005 12:50:55 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504291248210.18901@ppc970.osdl.org>
References: <20050426004111.GI21897@waste.org> <Pine.LNX.4.58.0504251859550.18901@ppc970.osdl.org>
 <20050429060157.GS21897@waste.org> <3817.10.10.10.24.1114756831.squirrel@linux1>
 <20050429074043.GT21897@waste.org> <Pine.LNX.4.58.0504290728090.18901@ppc970.osdl.org>
 <20050429163705.GU21897@waste.org> <Pine.LNX.4.58.0504291006450.18901@ppc970.osdl.org>
 <20050429191207.GX21897@waste.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Sean <seanlkml@sympatico.ca>,
	linux-kernel <linux-kernel@vger.kernel.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 29 21:44:21 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DRbPB-0002Ll-Ds
	for gcvg-git@gmane.org; Fri, 29 Apr 2005 21:44:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262913AbVD2TtW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 29 Apr 2005 15:49:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262910AbVD2TtU
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Apr 2005 15:49:20 -0400
Received: from fire.osdl.org ([65.172.181.4]:33157 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262913AbVD2TtD (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 29 Apr 2005 15:49:03 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3TJmus4031868
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 29 Apr 2005 12:48:57 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3TJmtXJ032708;
	Fri, 29 Apr 2005 12:48:56 -0700
To: Matt Mackall <mpm@selenic.com>
In-Reply-To: <20050429191207.GX21897@waste.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Fri, 29 Apr 2005, Matt Mackall wrote:
> 
> Here's an excerpt from http://selenic.com/mercurial/notes.txt on how
> the back-end works.

Any notes on how you maintain repository-level information?

For example, the expense in BK wasn't the single-file history, it was the
_repository_ history, ie the "ChangeSet" file. Which grows quite slowly,
but because it _always_ grows, it ends up being quite big and expensive to
parse after three years.

Ie do you have the git kind of "independent trees/commits", or do you 
create a revision history of those too?

		Linus
