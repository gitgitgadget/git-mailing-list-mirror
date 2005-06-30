From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: "git-send-pack"
Date: Thu, 30 Jun 2005 12:04:51 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0506301159120.14331@ppc970.osdl.org>
References: <Pine.LNX.4.58.0506301025510.14331@ppc970.osdl.org>
 <42C438CA.3040507@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jun 30 20:56:29 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Do4Cu-0006Qv-56
	for gcvg-git@gmane.org; Thu, 30 Jun 2005 20:56:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262946AbVF3TD2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 30 Jun 2005 15:03:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262953AbVF3TDY
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Jun 2005 15:03:24 -0400
Received: from smtp.osdl.org ([65.172.181.4]:18328 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262946AbVF3TCz (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 30 Jun 2005 15:02:55 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j5UJ2kjA015754
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 30 Jun 2005 12:02:47 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j5UJ2ji0025795;
	Thu, 30 Jun 2005 12:02:46 -0700
To: A Large Angry SCM <gitzilla@gmail.com>
In-Reply-To: <42C438CA.3040507@gmail.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.111 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Thu, 30 Jun 2005, A Large Angry SCM wrote:
>
> Have you tried something like the following?
> 
> ssh torvalds@master.kernel.org \
> 	'/bin/sh -c "export PATH=/tmp/foo:$PATH ; env"'

The point is that the user does not call "ssh" itself, but git-send-pack 
does it automatically.

And that means that git-send-pack will always do the same thing, for any
host it is given. If one host needs a special PATH, that's an effing pain.

However, Kees Cook points out that it's driver error: I set up my PATH in
.bash_profile, and if I just do it in .bashrc instead it all works.

Danke,

		Linus
