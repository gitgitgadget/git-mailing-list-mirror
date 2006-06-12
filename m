From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: svn to git, N-squared?
Date: Mon, 12 Jun 2006 09:41:59 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0606120938490.5498@g5.osdl.org>
References: <20060612043949.20992.qmail@science.horizon.com> 
 <9e4733910606120832xaf74e77pad7f70df864541fc@mail.gmail.com> 
 <Pine.LNX.4.64.0606120843340.5498@g5.osdl.org> 
 <9e4733910606120855p1cec9acfy62dadb89c11756b4@mail.gmail.com> 
 <Pine.LNX.4.64.0606120906210.5498@g5.osdl.org>
 <9e4733910606120922g181a5aaal623fd3f29b839f4c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "linux@horizon.com" <linux@horizon.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 12 18:42:46 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FppUm-0001qV-JO
	for gcvg-git@gmane.org; Mon, 12 Jun 2006 18:42:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751024AbWFLQmM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Jun 2006 12:42:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751619AbWFLQmM
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Jun 2006 12:42:12 -0400
Received: from smtp.osdl.org ([65.172.181.4]:8389 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751024AbWFLQmK (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 12 Jun 2006 12:42:10 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k5CGg0gt019370
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 12 Jun 2006 09:42:01 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k5CGfxFc027381;
	Mon, 12 Jun 2006 09:42:00 -0700
To: Jon Smirl <jonsmirl@gmail.com>
In-Reply-To: <9e4733910606120922g181a5aaal623fd3f29b839f4c@mail.gmail.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.75__
X-MIMEDefang-Filter: osdl$Revision: 1.135 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21715>



On Mon, 12 Jun 2006, Jon Smirl wrote:
>
> 64 files in tmp.
> But the SVN repository itself has 411,000 files in it. Split between
> two directories.

Ouch. That sounds like it. 

> Is there some pack equivalent for svn that I haven't found yet?

Is this literally what SVN does normally? That's just insane. I mean, even 
git tried to at least hash out the files (and yeah, admittedly even that 
worked less well than I was hoping for, but I at least fixed it within 
just a few weeks through the pack mechanism).

Or is that 411,000 files a result of how git-svnimport does things, rather 
than some basic SVN approach to live: does it perhaps end up checking out 
each file under an individual temporary name?

			Linus
