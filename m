From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Trying to use AUTHOR_DATE
Date: Fri, 29 Apr 2005 21:02:45 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504292101230.2296@ppc970.osdl.org>
References: <B8E391BBE9FE384DAA4C5C003888BE6F035EDE2C@scsmsx401.amr.corp.intel.com>
 <42730061.5010106@zytor.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Luck, Tony" <tony.luck@intel.com>, Edgar Toernig <froese@gmx.de>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 30 05:55:42 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DRj4s-0000aG-Sb
	for gcvg-git@gmane.org; Sat, 30 Apr 2005 05:55:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262502AbVD3EBE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 30 Apr 2005 00:01:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262503AbVD3EBE
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Apr 2005 00:01:04 -0400
Received: from fire.osdl.org ([65.172.181.4]:45481 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262502AbVD3EBD (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 30 Apr 2005 00:01:03 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3U40ks4010840
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 29 Apr 2005 21:00:49 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3U40jLD021230;
	Fri, 29 Apr 2005 21:00:45 -0700
To: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <42730061.5010106@zytor.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Fri, 29 Apr 2005, H. Peter Anvin wrote:
> 
> For gawd's sake people, just grab a copy of the working code in libcurl, 
> and turn it into a standalone .c file.  It'll even let you merge in 
> future fixes, and you could even use autoconf to use libcurl or the 
> standalone code depending on what's available.

I'll happily depend on libcurl, but I put my foot down on that tool of the 
devil called "autoconf".

Any package that starts using autoconf eventually becomes a total mess. 
Don't do it. 

		Linus
