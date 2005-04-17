From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] Use libcurl to use HTTP to get repositories
Date: Sat, 16 Apr 2005 21:36:46 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504162135420.7211@ppc970.osdl.org>
References: <20050416172952.3bf34bab.pj@sgi.com>
 <Pine.LNX.4.21.0504162033060.30848-100000@iabervon.org> <20050416174544.5ca28322.pj@sgi.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org,
	pasky@ucw.cz
X-From: git-owner@vger.kernel.org Sun Apr 17 06:31:23 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DN1RH-0004Sl-W5
	for gcvg-git@gmane.org; Sun, 17 Apr 2005 06:31:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261254AbVDQEe5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Apr 2005 00:34:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261255AbVDQEe5
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Apr 2005 00:34:57 -0400
Received: from fire.osdl.org ([65.172.181.4]:59289 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261254AbVDQEe4 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 17 Apr 2005 00:34:56 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3H4Yms4006492
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 16 Apr 2005 21:34:49 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3H4YlGo007203;
	Sat, 16 Apr 2005 21:34:48 -0700
To: Paul Jackson <pj@sgi.com>
In-Reply-To: <20050416174544.5ca28322.pj@sgi.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Sat, 16 Apr 2005, Paul Jackson wrote:

> Daniel wrote:
> > I'm working off of Linus's tree when not working on scripts, and it
> > doesn't have that section at all.
> 
> Ah so - nevermind my README comments then.

Well, actually, I suspect that something like this should go to Pasky. I
really see my repo as purely a "internal git datastructures", and when it
gets to "how do we interact with other peoples web-sites", I suspect 
Pasky's tree is better.

		Linus
