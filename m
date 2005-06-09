From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: gitk-1.1 out
Date: Thu, 9 Jun 2005 07:22:07 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0506090721450.2286@ppc970.osdl.org>
References: <17053.35147.52729.794561@cargo.ozlabs.ibm.com>
 <Pine.LNX.4.58.0506080743040.2286@ppc970.osdl.org>
 <17063.51611.467615.685723@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 09 16:32:21 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DgNpN-0007O3-Ip
	for gcvg-git@gmane.org; Thu, 09 Jun 2005 16:16:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262407AbVFIOUN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 9 Jun 2005 10:20:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262410AbVFIOUN
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Jun 2005 10:20:13 -0400
Received: from smtp.osdl.org ([65.172.181.4]:50916 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262407AbVFIOUH (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 9 Jun 2005 10:20:07 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j59EK2jA005254
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 9 Jun 2005 07:20:03 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j59EK2Lw003757;
	Thu, 9 Jun 2005 07:20:02 -0700
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <17063.51611.467615.685723@cargo.ozlabs.ibm.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Thu, 9 Jun 2005, Paul Mackerras wrote:
> 
> > I realize that that may sound silly, but a tree that has many branches can 
> > validly be used with gitk with something like this:
> > 
> > 	gitk $(ls .git/refs/heads)
> 
> Um, did I break that when I changed to using git-rev-list instead of
> git-rev-tree?

No, I fixed git-rev-list to do multiple heads.

		Linus
