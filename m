From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Rebase semantic and cherry-pick
Date: Wed, 29 Mar 2006 18:54:12 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0603291852140.27203@g5.osdl.org>
References: <1143596622.2481.10.camel@mattlaptop.metaesthetics.net>
 <Pine.LNX.4.64.0603281749060.15714@g5.osdl.org> <7vlkutc36w.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0603291102440.15714@g5.osdl.org> <e0fe1h$d5r$1@sea.gmane.org>
 <7vwtec7j37.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: jnareb@gmail.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 30 04:54:28 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FOnIk-0008Nu-U4
	for gcvg-git@gmane.org; Thu, 30 Mar 2006 04:54:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750958AbWC3CyU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 29 Mar 2006 21:54:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750967AbWC3CyU
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Mar 2006 21:54:20 -0500
Received: from smtp.osdl.org ([65.172.181.4]:14254 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750951AbWC3CyT (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 29 Mar 2006 21:54:19 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k2U2sECo010937
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 29 Mar 2006 18:54:14 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k2U2sCN3027288;
	Wed, 29 Mar 2006 18:54:13 -0800
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vwtec7j37.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.71__
X-MIMEDefang-Filter: osdl$Revision: 1.133 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18185>



On Wed, 29 Mar 2006, Junio C Hamano wrote:

> Jakub Narebski <jnareb@gmail.com> writes:
> 
> > Perhaps if possible also have
> >
> > git cherry-pick --whole-branch branchname
> >
> > meaning
> >
> > git cherry-pick branchname:begining..branchname:HEAD
> 
> There is no branchname:beginning in git.

Well, in this case you don't need it. You just do

	git cherry-pick HEAD..branch

and it just magically does the right thing.

For consistency reasons, we should probably allow that to be written as 
just "..branch", the same way we can write "branch.." to mean "everything 
in HEAD but not in "branch".

		Linus
