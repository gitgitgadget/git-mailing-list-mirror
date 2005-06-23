From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Updated git HOWTO for kernel hackers
Date: Wed, 22 Jun 2005 17:29:17 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0506221724140.11175@ppc970.osdl.org>
References: <42B9E536.60704@pobox.com> <20050622230905.GA7873@kroah.com>
 <Pine.LNX.4.58.0506221623210.11175@ppc970.osdl.org> <42B9FCAE.1000607@pobox.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Greg KH <greg@kroah.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jun 23 02:23:14 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DlFUC-0002HB-Sn
	for gcvg-git@gmane.org; Thu, 23 Jun 2005 02:22:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261933AbVFWA2B (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 22 Jun 2005 20:28:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261927AbVFWA2B
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Jun 2005 20:28:01 -0400
Received: from smtp.osdl.org ([65.172.181.4]:22926 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261764AbVFWA1V (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 22 Jun 2005 20:27:21 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j5N0RCjA006489
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 22 Jun 2005 17:27:13 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j5N0RB1l015526;
	Wed, 22 Jun 2005 17:27:12 -0700
To: Jeff Garzik <jgarzik@pobox.com>
In-Reply-To: <42B9FCAE.1000607@pobox.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.111 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Wed, 22 Jun 2005, Jeff Garzik wrote:
>
> > But, like branches, it means that if you want a tag, you need to know the 
> > tag you want, and download it the same way you download a branch.
> 
> Still -- that's interesting data that no script currently tracks.  You 
> gotta fall back to rsync.

Something like

	git-ssh/http-pull -w tags/<tagname> tags/<tagname> <url>

_should_ hopefully work now (and the "-a" flag should mean that you also 
get all the objects needed for the tag).

I've not tested it, as usual, but it should work as of today thanks to 
Daniel Barkalow fixing the pulling of arbitrary objects.

		Linus
