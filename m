From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Careful object writing..
Date: Tue, 3 May 2005 15:37:36 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0505031531270.26698@ppc970.osdl.org>
References: <Pine.LNX.4.58.0505031204030.26698@ppc970.osdl.org>
 <20050503200034.GA16104@delft.aura.cs.cmu.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed May 04 00:36:09 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DT5zD-0003yO-Pe
	for gcvg-git@gmane.org; Wed, 04 May 2005 00:35:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261880AbVECWhl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 May 2005 18:37:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261865AbVECWgl
	(ORCPT <rfc822;git-outgoing>); Tue, 3 May 2005 18:36:41 -0400
Received: from fire.osdl.org ([65.172.181.4]:56504 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261880AbVECWfi (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 May 2005 18:35:38 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j43MZZs4026895
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 3 May 2005 15:35:36 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j43MZYf0021178;
	Tue, 3 May 2005 15:35:35 -0700
To: Jan Harkes <jaharkes@cs.cmu.edu>, Peter Anvin <hpa@zytor.com>
In-Reply-To: <20050503200034.GA16104@delft.aura.cs.cmu.edu>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Tue, 3 May 2005, Jan Harkes wrote:
> 
> I tried to pull in the latest version of your tree, but it doesn't look
> like this commit has propagated to rsync.kernel.org yet.

Hmm.. It's still not there a few hours later. I wonder what the mirroring
rules are. Or maybe mirroring is just broken right now. Peter?

One change introduced by me is that the new objects changed from 0664
(-rw-rw-r--) to (0444) -r--r--r-- due to the object writing rules. Maybe
the mirroring decides that such objects shouldn't be mirrored, since they
are "private"?

Or maybe it's just that Peter has shut down mirroring in preparation for 
the imminent memory upgrade on master.kernel.org. 

			Linus
