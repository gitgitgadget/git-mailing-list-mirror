From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Git 1.3.2 on Solaris
Date: Tue, 16 May 2006 20:49:54 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0605162047380.10823@g5.osdl.org>
References: <4973.1147836384@lotus.CS.Berkeley.EDU>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Stefan Pfetzing <stefan.pfetzing@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed May 17 05:50:36 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FgD3N-0002wD-9n
	for gcvg-git@gmane.org; Wed, 17 May 2006 05:50:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751188AbWEQDuE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 16 May 2006 23:50:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751213AbWEQDuE
	(ORCPT <rfc822;git-outgoing>); Tue, 16 May 2006 23:50:04 -0400
Received: from smtp.osdl.org ([65.172.181.4]:32433 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751188AbWEQDuC (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 May 2006 23:50:02 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k4H3nttH000725
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 16 May 2006 20:49:56 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k4H3nsBc001028;
	Tue, 16 May 2006 20:49:54 -0700
To: Jason Riedy <ejr@EECS.Berkeley.EDU>
In-Reply-To: <4973.1147836384@lotus.CS.Berkeley.EDU>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.74__
X-MIMEDefang-Filter: osdl$Revision: 1.134 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20159>



On Tue, 16 May 2006, Jason Riedy wrote:
> 
> But for recommending and using git on these systems _now_...

Yes. For that, I would literally suggest having people install the GNU 
tools (and/or a recent enough perl) somewhere early in the path.

If you use the git wrapper, for example, you can already depend on the 
fact that it will prepend the git installation directory to the path, so 
while the GNU tools might not _normally_ be on the path, if you put them 
in the same directory as your git install, you'll automatically get them 
as long as you use the "git cmd" format (rather than the "git-cmd" 
format).

		Linus
