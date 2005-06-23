From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Updated git HOWTO for kernel hackers
Date: Wed, 22 Jun 2005 18:56:16 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0506221853280.11175@ppc970.osdl.org>
References: <42B9E536.60704@pobox.com> <20050622230905.GA7873@kroah.com>
 <Pine.LNX.4.58.0506221623210.11175@ppc970.osdl.org> <42B9FCAE.1000607@pobox.com>
 <Pine.LNX.4.58.0506221724140.11175@ppc970.osdl.org> <42BA14B8.2020609@pobox.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Greg KH <greg@kroah.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jun 23 03:51:02 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DlGrf-0002Ww-S3
	for gcvg-git@gmane.org; Thu, 23 Jun 2005 03:50:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261984AbVFWB4H (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 22 Jun 2005 21:56:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262012AbVFWByf
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Jun 2005 21:54:35 -0400
Received: from smtp.osdl.org ([65.172.181.4]:40091 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262005AbVFWByY (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 22 Jun 2005 21:54:24 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j5N1sBjA012052
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 22 Jun 2005 18:54:12 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j5N1sAjm019425;
	Wed, 22 Jun 2005 18:54:11 -0700
To: Jeff Garzik <jgarzik@pobox.com>
In-Reply-To: <42BA14B8.2020609@pobox.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.111 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Wed, 22 Jun 2005, Jeff Garzik wrote:
>
> With BK, tags came with each pull.  With git, you have to go "outside 
> the system" (rsync) just get the new tags.

You don't have to use rsync, and you don't have to go outside the system. 
That was my point: you can use "git-ssh-pull" to pull the tags.

But yes, you have to explicitly ask for them by name, ie the other side 
has to let you know: "Oh, btw, I created a 'xyz' tag for you". And having 
another helper script to hide the details of how git-*-pull handles tags 
is obviously also a good idea, although it's pretty low on my list of 
things to worry about.

		Linus
