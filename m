From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [ANNOUNCE] git-pasky-0.7
Date: Sat, 23 Apr 2005 20:45:35 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504232044040.2344@ppc970.osdl.org>
References: <20050424005923.GA8859@pasky.ji.cz> <1114306009.27940.23.camel@nosferatu.lan>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Petr Baudis <pasky@ucw.cz>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 24 05:39:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DPXxU-0003iC-6O
	for gcvg-git@gmane.org; Sun, 24 Apr 2005 05:39:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262243AbVDXDnt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Apr 2005 23:43:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262244AbVDXDnt
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Apr 2005 23:43:49 -0400
Received: from fire.osdl.org ([65.172.181.4]:9367 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262243AbVDXDnr (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 23 Apr 2005 23:43:47 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3O3has4031450
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 23 Apr 2005 20:43:37 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3O3hZbu027789;
	Sat, 23 Apr 2005 20:43:36 -0700
To: Martin Schlemmer <azarah@nosferatu.za.org>
In-Reply-To: <1114306009.27940.23.camel@nosferatu.lan>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Sun, 24 Apr 2005, Martin Schlemmer wrote:
> 
> Over here gitmerge-file.sh is looking for a 'merge' command not present.

It's usually packaged up with RCS. So in that sense git does need RCS,
although it's really only the traditional three-way merge program it
wants.

Do "yum install rcs" and you should get it (or whatever your local 
alternative is).

		Linus
