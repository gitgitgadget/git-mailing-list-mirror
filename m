From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git-shortlog script
Date: Sat, 4 Jun 2005 16:47:41 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0506041645490.1876@ppc970.osdl.org>
References: <42A22C20.10002@pobox.com> <Pine.LNX.4.58.0506041642530.1876@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>,
	Linux Kernel <linux-kernel@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jun 05 01:43:10 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DeiHp-000755-Iw
	for gcvg-git@gmane.org; Sun, 05 Jun 2005 01:42:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261437AbVFDXpy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 4 Jun 2005 19:45:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261439AbVFDXpy
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Jun 2005 19:45:54 -0400
Received: from fire.osdl.org ([65.172.181.4]:422 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261437AbVFDXpn (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 4 Jun 2005 19:45:43 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j54NjbjA018561
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 4 Jun 2005 16:45:38 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j54NjaGu010269;
	Sat, 4 Jun 2005 16:45:37 -0700
To: Jeff Garzik <jgarzik@pobox.com>
In-Reply-To: <Pine.LNX.4.58.0506041642530.1876@ppc970.osdl.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Sat, 4 Jun 2005, Linus Torvalds wrote:
> 
> Btw, it shows how broken your merge script is: you don't fill in the 
> AUTHOR field properly for some reason:

Oh, and the reason you didn't notice is that "git-whatchanged" normally 
ignores merges. Do 

	git-rev-list --pretty HEAD ^v2.6.12-rc5 | git-shortlog | less -S

to see what I'm talking about ("show shortlog of all the changes since
v2.6.12-rc5").

		Linus
