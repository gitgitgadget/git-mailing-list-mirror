From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: ALSA official git repository
Date: Fri, 27 May 2005 19:21:31 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0505271854300.17402@ppc970.osdl.org>
References: <Pine.LNX.4.58.0505271741490.1757@pnote.perex-int.cz>
 <Pine.LNX.4.58.0505270903230.17402@ppc970.osdl.org>
 <Pine.LNX.4.58.0505271941250.1757@pnote.perex-int.cz>
 <Pine.LNX.4.58.0505271113410.17402@ppc970.osdl.org> <20050527135124.0d98c33e.akpm@osdl.org>
 <Pine.LNX.4.58.0505271502240.17402@ppc970.osdl.org> <20050527154625.5490f405.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: perex@suse.cz, linux-kernel@vger.kernel.org, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 28 04:18:12 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DbqtK-0001jW-Iy
	for gcvg-git@gmane.org; Sat, 28 May 2005 04:17:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262673AbVE1CTj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 27 May 2005 22:19:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262670AbVE1CTj
	(ORCPT <rfc822;git-outgoing>); Fri, 27 May 2005 22:19:39 -0400
Received: from fire.osdl.org ([65.172.181.4]:28358 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262669AbVE1CTd (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 27 May 2005 22:19:33 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j4S2JRjA027457
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 27 May 2005 19:19:27 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j4S2JPsX022143;
	Fri, 27 May 2005 19:19:26 -0700
To: Andrew Morton <akpm@osdl.org>
In-Reply-To: <20050527154625.5490f405.akpm@osdl.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Fri, 27 May 2005, Andrew Morton wrote:
> 
> That all assumes that the tools are smart enough to separate the email
> headers from the body :(

Well, _that_ is trivial: the first empty line is the marker between header 
and body. 

This is a stupid awk program to do this:

	/^From: / { name=$0 }
	state==1 { print name; exit }
	/^$/ { state=1 }

Or something. 


		Linus
