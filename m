From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git-status too verbose?
Date: Tue, 7 Mar 2006 10:22:28 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0603071020530.3573@g5.osdl.org>
References: <38b80e980603040952j15152a21h2c903bd011d7e905@mail.gmail.com>
 <7vacc36r4v.fsf@assigned-by-dhcp.cox.net> <440D503E.8090007@op5.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, Eric Jaffe <jaffe.eric@gmail.com>,
	Carl Worth <cworth@cworth.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 07 19:23:16 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FGgpa-0000sl-Ht
	for gcvg-git@gmane.org; Tue, 07 Mar 2006 19:22:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751468AbWCGSWn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 7 Mar 2006 13:22:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751485AbWCGSWn
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Mar 2006 13:22:43 -0500
Received: from smtp.osdl.org ([65.172.181.4]:47586 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751468AbWCGSWn (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 7 Mar 2006 13:22:43 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k27IMVDZ029957
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 7 Mar 2006 10:22:31 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k27IMSc6000884;
	Tue, 7 Mar 2006 10:22:28 -0800
To: Andreas Ericsson <ae@op5.se>
In-Reply-To: <440D503E.8090007@op5.se>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.68__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17345>



On Tue, 7 Mar 2006, Andreas Ericsson wrote:
> > 
> > I agree that it would be useful if we had a tool that showed the
> > two status that matter for each file, grouped together on one
> > line, e.g.
> > 
> > 			HEAD->index	index->files
> > 	------------------------------------------------
> > 	hello.c		unmodified      modified
> >         world.c		modified	unmodified
> > 	frotz.c		new		unmodified
> >         ...
> > 	garbage.c~	???		n/a
> > 
> > for the current index file and the current HEAD commit.
> > 
> 
> Could we have 'same' or some such instead of 'unmodified'? It's a bit close to
> 'modified' for the eye to find it quickly.

I really _really_ hate that table anyway.

What I want to know is "what is committed", and "what is not".

That table makes it really really hard to see what you are committing, if 
you have a hundred files changed that are _not_ being committed. The 
actual committed information will be interspersed in the files you're not 
interested in, and vice versa.

The current commit message is a million times superior, even if it might 
not be as _pretty_.

		Linus
