From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: How to get bash to shut up about SIGPIPE?
Date: Thu, 28 Apr 2005 15:16:44 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504281515330.18901@ppc970.osdl.org>
References: <Pine.LNX.4.58.0504281121430.18901@ppc970.osdl.org>
 <20050428233104.3e606ba9.froese@gmx.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>, Petr Baudis <pasky@ucw.cz>
X-From: git-owner@vger.kernel.org Fri Apr 29 00:10:40 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DRHCR-0000dx-DH
	for gcvg-git@gmane.org; Fri, 29 Apr 2005 00:09:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262281AbVD1WPE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Apr 2005 18:15:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262284AbVD1WPE
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Apr 2005 18:15:04 -0400
Received: from fire.osdl.org ([65.172.181.4]:12464 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262281AbVD1WPA (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Apr 2005 18:15:00 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3SMEks4018543
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 28 Apr 2005 15:14:46 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3SMEjj4015097;
	Thu, 28 Apr 2005 15:14:45 -0700
To: Edgar Toernig <froese@gmx.de>
In-Reply-To: <20050428233104.3e606ba9.froese@gmx.de>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Thu, 28 Apr 2005, Edgar Toernig wrote:
> 
> Try this:

Nope. No difference what-so-ever.

Side note: it's timing-dependent, so apparently especially on SMP, 
sometimes it doesn't complain, and then I think soemthing worked. Then I 
try again, and it's always back.

I've made a bug-report against bash.

		Linus
