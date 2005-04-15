From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Yet another base64 patch
Date: Thu, 14 Apr 2005 17:44:09 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504141743360.7211@ppc970.osdl.org>
References: <425DEF64.60108@zytor.com> <20050414022413.GB18655@64m.dyndns.org>
 <425E0174.4080404@zytor.com> <20050414024228.GC18655@64m.dyndns.org>
 <425E0D62.9000401@zytor.com> <Pine.LNX.4.58.0504140038450.7211@ppc970.osdl.org>
 <425EA152.4090506@zytor.com> <Pine.LNX.4.58.0504141042450.7211@ppc970.osdl.org>
 <20050414191157.GA27696@outpost.ds9a.nl> <425EC3B4.6090908@zytor.com>
 <20050414214756.GA31249@outpost.ds9a.nl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "H. Peter Anvin" <hpa@zytor.com>, Christopher Li <git@chrisli.org>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 15 02:39:04 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DMErJ-0005A8-Al
	for gcvg-git@gmane.org; Fri, 15 Apr 2005 02:38:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261685AbVDOAmV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Apr 2005 20:42:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261686AbVDOAmV
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Apr 2005 20:42:21 -0400
Received: from fire.osdl.org ([65.172.181.4]:35276 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261685AbVDOAmS (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 Apr 2005 20:42:18 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3F0gCs4025305
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 14 Apr 2005 17:42:13 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3F0gBe0029825;
	Thu, 14 Apr 2005 17:42:12 -0700
To: bert hubert <ahu@ds9a.nl>
In-Reply-To: <20050414214756.GA31249@outpost.ds9a.nl>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Thu, 14 Apr 2005, bert hubert wrote:
> 
> It is too easy to get into a O(N^2) situation. Git may be able to deal with
> it but you may hurt yourself when making backups, or if you ever want to
> share your tree (possibly with yourself) over the network.

Even something as simple as "ls -l" has been known to have O(n**2)  
behaviour for big directories.

		Linus
