From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Updated git HOWTO for kernel hackers
Date: Wed, 22 Jun 2005 16:25:08 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0506221623210.11175@ppc970.osdl.org>
References: <42B9E536.60704@pobox.com> <20050622230905.GA7873@kroah.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jeff Garzik <jgarzik@pobox.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jun 23 01:23:29 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DlEYP-0007Uk-ON
	for gcvg-git@gmane.org; Thu, 23 Jun 2005 01:22:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262581AbVFVX2P (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 22 Jun 2005 19:28:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262151AbVFVXXi
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Jun 2005 19:23:38 -0400
Received: from smtp.osdl.org ([65.172.181.4]:41962 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261486AbVFVXXN (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 22 Jun 2005 19:23:13 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j5MNN3jA001672
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 22 Jun 2005 16:23:03 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j5MNN2QB012294;
	Wed, 22 Jun 2005 16:23:02 -0700
To: Greg KH <greg@kroah.com>
In-Reply-To: <20050622230905.GA7873@kroah.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.111 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Wed, 22 Jun 2005, Greg KH wrote:
> 
> Ok, this is annoying.  Is there some reason why git doesn't pull the
> tags in properly when doing a merge?  Chris and I just hit this when I
> pulled his 2.6.12.1 tree and and was wondering where the tag went.

Tags are private in git (the same way branches are), which means that you
can have a million of your own tags and never disturb anybody else.

But, like branches, it means that if you want a tag, you need to know the 
tag you want, and download it the same way you download a branch.

		Linus
