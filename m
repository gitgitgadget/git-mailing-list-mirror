From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Diffs "from" working directory
Date: Mon, 21 Nov 2005 21:33:41 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0511212124160.13959@g5.osdl.org>
References: <200511201817.15780.blaisorblade@yahoo.it>  <20051120174359.GA24177@fieldses.org>
  <Pine.LNX.4.64.0511201010490.13959@g5.osdl.org>  <20051120205855.GA30346@fieldses.org>
  <4381287F.5080402@citi.umich.edu> <b0943d9e0511211328j7c062c07s@mail.gmail.com>
 <4382A972.1010801@citi.umich.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Catalin Marinas <catalin.marinas@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 22 06:34:48 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EeQmt-0005lG-70
	for gcvg-git@gmane.org; Tue, 22 Nov 2005 06:33:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932314AbVKVFds (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 22 Nov 2005 00:33:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932328AbVKVFds
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Nov 2005 00:33:48 -0500
Received: from smtp.osdl.org ([65.172.181.4]:64409 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932314AbVKVFdr (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 22 Nov 2005 00:33:47 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id jAM5XinO000733
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 21 Nov 2005 21:33:44 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id jAM5Xf7x023634;
	Mon, 21 Nov 2005 21:33:43 -0800
To: Chuck Lever <cel@citi.umich.edu>
In-Reply-To: <4382A972.1010801@citi.umich.edu>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.55__
X-MIMEDefang-Filter: osdl$Revision: 1.127 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12527>



On Tue, 22 Nov 2005, Chuck Lever wrote:
> 
> for some reason i was under the impression that it would parse the
> Signed-off-by: fields in the patch description, and take the first one as the
> patch author.

The first sign-off really isn't necessarily the author.

It might be a company sign-off (many companies don't want any random 
engineer to send out patches), but much more commonly it's a trivial patch 
that somebody else signs off on, even if the original patcher didn't (see 
case (b) in the sign-off-rules: you can sign of on somebody elses work if 
you know it's under the GPL).

So the fact that there was a sign-off procedure doesn't automatically mean 
that the author will be the first sign-off person, although in _practice_ 
that obviously would likely always be the most common case by far.

(Another reason is that some people actually add the sign-offs above 
previous ones. It happens, although if I notice, I try to point it out).

So authorship really is totally separate from sign-off, and all _my_ tools 
take the authorship from the first "From:" line at the top of the message 
body or from the email itself.

			Linus
