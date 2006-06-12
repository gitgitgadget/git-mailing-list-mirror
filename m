From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: svn to git, N-squared?
Date: Mon, 12 Jun 2006 09:57:28 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0606120942140.5498@g5.osdl.org>
References: <20060612043949.20992.qmail@science.horizon.com> 
 <9e4733910606120832xaf74e77pad7f70df864541fc@mail.gmail.com> 
 <Pine.LNX.4.64.0606120843340.5498@g5.osdl.org> 
 <9e4733910606120855p1cec9acfy62dadb89c11756b4@mail.gmail.com> 
 <Pine.LNX.4.64.0606120906210.5498@g5.osdl.org> 
 <9e4733910606120922g181a5aaal623fd3f29b839f4c@mail.gmail.com>
 <9e4733910606120932k5b6f7acfra3f3a26168454f47@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "linux@horizon.com" <linux@horizon.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 12 18:57:49 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FppjR-00056A-6q
	for gcvg-git@gmane.org; Mon, 12 Jun 2006 18:57:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751090AbWFLQ5i (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Jun 2006 12:57:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751418AbWFLQ5i
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Jun 2006 12:57:38 -0400
Received: from smtp.osdl.org ([65.172.181.4]:62665 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751090AbWFLQ5h (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 12 Jun 2006 12:57:37 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k5CGvTgt020334
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 12 Jun 2006 09:57:30 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k5CGvSuJ027915;
	Mon, 12 Jun 2006 09:57:29 -0700
To: Jon Smirl <jonsmirl@gmail.com>
In-Reply-To: <9e4733910606120932k5b6f7acfra3f3a26168454f47@mail.gmail.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.75__
X-MIMEDefang-Filter: osdl$Revision: 1.135 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21717>



On Mon, 12 Jun 2006, Jon Smirl wrote:
> > 
> > 64 files in tmp.
> > But the SVN repository itself has 411,000 files in it. Split between
> > two directories.
> 
> I'm doing all of this on ext3. I have plenty of free disk space so I
> can make another partition and switch to a new file system after I
> install the new RAM. What would be the best one to try? Doing that
> would provide a data point to determine if this is a problem with file
> system performance or the misuse of file systems.

I'm sure there are better filesystems to try for this kind of insane 
schenario, but at the same time, I really cannot imaging that the 411,000 
files is a "normal" thing. There _must_ be some way to have SVN not do 
that in the first place (or git-svnimport).

Is this what happened when the SVN people started using fsfs? 

			Linus
