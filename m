From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] diff-tree -c: show a merge commit a bit more sensibly.
Date: Tue, 24 Jan 2006 17:15:44 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0601241655090.10804@evo.osdl.org>
References: <7vwtgqas0y.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 24 23:16:22 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F1WSK-0000ob-J2
	for gcvg-git@gmane.org; Tue, 24 Jan 2006 23:16:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750774AbWAXWP7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 Jan 2006 17:15:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750775AbWAXWP7
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jan 2006 17:15:59 -0500
Received: from smtp.osdl.org ([65.172.181.4]:3257 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750774AbWAXWP6 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 Jan 2006 17:15:58 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k0OMFsDZ010407
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 24 Jan 2006 14:15:54 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k0OMFqws024118;
	Tue, 24 Jan 2006 14:15:53 -0800
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vwtgqas0y.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=-3 required=5 tests=PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.66__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15109>



On Tue, 24 Jan 2006, Junio C Hamano wrote:
>
> A new option '-c' to diff-tree changes the way a merge commit is
> displayed when generating a patch output.  It shows a "combined
> diff" (hence the option letter 'c'), which looks like this:

Thank you!

Can you make this the default for "git-whatchanged" too? That way, merges 
that have manual fixups will actually show up in the whatchanged output.

Also, it would be perhaps even nicer if it had a "dense" version, which 
only showed the chunks that had differences from more than one parent. 
Chunks that have diffs from just one parent obviously had no conflicts in 
that chunk, so they are much less interesting than a chunk that was 
different from more than one parent..

			Linus
