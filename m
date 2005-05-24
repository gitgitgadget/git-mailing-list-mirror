From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: gitweb wishlist
Date: Tue, 24 May 2005 11:52:56 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0505241146500.2307@ppc970.osdl.org>
References: <1116626652.12975.118.camel@dhcp-188> <Pine.LNX.4.58.0505201604460.2206@ppc970.osdl.org>
 <428E745C.30304@zytor.com> <Pine.LNX.4.58.0505201702170.2206@ppc970.osdl.org>
 <4292A08A.5050108@cobite.com> <Pine.LNX.4.58.0505232048190.2307@ppc970.osdl.org>
 <Pine.LNX.4.58.0505240110580.2307@ppc970.osdl.org>
 <20050524161745.GA9537@cip.informatik.uni-erlangen.de>
 <Pine.LNX.4.58.0505240929051.2307@ppc970.osdl.org>
 <Pine.LNX.4.58.0505240943080.2307@ppc970.osdl.org>
 <20050524182951.GB9537@cip.informatik.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue May 24 20:49:56 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DaeT8-000543-9c
	for gcvg-git@gmane.org; Tue, 24 May 2005 20:49:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261372AbVEXSvF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 May 2005 14:51:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261389AbVEXSvF
	(ORCPT <rfc822;git-outgoing>); Tue, 24 May 2005 14:51:05 -0400
Received: from fire.osdl.org ([65.172.181.4]:47768 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261372AbVEXSu4 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 May 2005 14:50:56 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j4OIoqjA013397
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 24 May 2005 11:50:53 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j4OIopZT011328;
	Tue, 24 May 2005 11:50:51 -0700
To: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>
In-Reply-To: <20050524182951.GB9537@cip.informatik.uni-erlangen.de>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Tue, 24 May 2005, Thomas Glanzmann wrote:
>
> Hello,
> 
> >  - name translation doesn't exist (so all of Peters changesets get 
> >    reported as author "hpa <hpa>")
> 
> I pick that up.

Note that one advantage of the unconverted output is that while it's
unreadable and not very helpful, it _is_ the raw output from CVS. Again,
that means that everybody will convert the same CVS archive into exactly
the same git tree, and that means (among other things) that you can then
immediately merge between the trees.

Perhaps more interestingly, it should also mean that you can _continue_ to 
use CVS, then re-convert it at a later date, and I think you should be 
able to merge with somebody who has been using git in the meantime.

In contrast, if you have fancy name translation, the converted tree will 
obviously depend on your translation rules.

I dunno. Maybe the advantages of having nice names outweigh the 
disadvantage of possibly generating incompatible trees.

			Linus
