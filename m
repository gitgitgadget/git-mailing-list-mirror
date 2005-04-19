From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] write-tree performance problems
Date: Tue, 19 Apr 2005 16:09:27 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504191608230.2274@ppc970.osdl.org>
References: <200504191250.10286.mason@suse.com><Pine.LNX.4.58.0504191017300.19286@ppc970.osdl.org><200504191412.00227.mason@suse.com><Pine.LNX.4.58.0504191143220.19286@ppc970.osdl.org><Pine.LNX.4.62.0504191508060.26365@qynat.qvtvafvgr.pbz>
 <Pine.LNX.4.58.0504191514550.2274@ppc970.osdl.org>
 <Pine.LNX.4.62.0504191557410.26365@qynat.qvtvafvgr.pbz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Chris Mason <mason@suse.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 20 01:04:16 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DO1kg-00019q-Uh
	for gcvg-git@gmane.org; Wed, 20 Apr 2005 01:03:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261735AbVDSXHh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 19 Apr 2005 19:07:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261736AbVDSXHh
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Apr 2005 19:07:37 -0400
Received: from fire.osdl.org ([65.172.181.4]:9416 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261735AbVDSXHe (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 19 Apr 2005 19:07:34 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3JN7Ts4026906
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 19 Apr 2005 16:07:29 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3JN7SGl005601;
	Tue, 19 Apr 2005 16:07:29 -0700
To: David Lang <david.lang@digitalinsight.com>
In-Reply-To: <Pine.LNX.4.62.0504191557410.26365@qynat.qvtvafvgr.pbz>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Tue, 19 Apr 2005, David Lang wrote:
> 
> if you are useing quilt for locally developed patches I fully agree with 
> you, but I was thinking of the case where Andrew is receiving independant 
> patches from lots of people and storing them in quilt for testing, and 
> then sending them on to you. In this case the patches really are 
> independant and it may be useful to continue to treat them this way 
> instead of collapsing them into one 'update from Andrew' feed.

If so, he should set up one repository per quilt patch. 

That would be crazy, but yes, it would allow me to cherry-pick which
one(s) I want to merge with.

But the fact is, that cherry-picking should happen at quilt-time not at
git time.

		Linus
