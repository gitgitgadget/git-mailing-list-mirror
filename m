From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] git builtin "push"
Date: Sun, 30 Apr 2006 14:05:33 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0604301405070.2922@g5.osdl.org>
References: <Pine.LNX.4.64.0604292111570.9901@g5.osdl.org> <445516F5.1090204@garzik.org>
 <Pine.LNX.4.64.0604301303010.5231@g5.osdl.org> <BAYC1-PASMTP037751CEC096DA29400513AEB00@CEZ.ICE>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: jeff@garzik.org, junkio@cox.net, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 30 23:06:51 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FaJ7w-0000ao-NH
	for gcvg-git@gmane.org; Sun, 30 Apr 2006 23:06:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751219AbWD3VGe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 30 Apr 2006 17:06:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751220AbWD3VGe
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Apr 2006 17:06:34 -0400
Received: from smtp.osdl.org ([65.172.181.4]:43974 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751219AbWD3VGd (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 30 Apr 2006 17:06:33 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k3UL5ZtH019745
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 30 Apr 2006 14:05:35 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k3UL5XSv011030;
	Sun, 30 Apr 2006 14:05:34 -0700
To: sean <seanlkml@sympatico.ca>
In-Reply-To: <BAYC1-PASMTP037751CEC096DA29400513AEB00@CEZ.ICE>
X-Spam-Status: No, hits=-3 required=5 tests=PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.74__
X-MIMEDefang-Filter: osdl$Revision: 1.134 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19356>



On Sun, 30 Apr 2006, sean wrote:

> On Sun, 30 Apr 2006 13:07:42 -0700 (PDT)
> Linus Torvalds <torvalds@osdl.org> wrote:
> 
> > The way it works is that
> > 
> > 	"git push repo"
> > 
> > with no branch specs will update all branches that are IN COMMON between 
> > your tree and the repository you're pushing to. In other words, it's meant 
> > to sync up the branches that you have already pushed.
> 
> True, as long as you don't have any Push: lines in your .git/remotes/repo
> file.  Any such lines act just like you gave them on the command line
> which afaik effectively removes the ability to say "update all branches
> we have in common".

Ok, so my built-in version "fixes" that "feature". 

		Linus
