From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: Updated git HOWTO for kernel hackers
Date: Thu, 23 Jun 2005 00:23:10 -0400 (EDT)
Message-ID: <Pine.LNX.4.21.0506230019440.30848-100000@iabervon.org>
References: <42B9E536.60704@pobox.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jun 23 06:18:58 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DlJAc-00055z-KW
	for gcvg-git@gmane.org; Thu, 23 Jun 2005 06:18:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262050AbVFWEYo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 23 Jun 2005 00:24:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262079AbVFWEYo
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Jun 2005 00:24:44 -0400
Received: from iabervon.org ([66.92.72.58]:773 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S262050AbVFWEYl (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 23 Jun 2005 00:24:41 -0400
Received: from barkalow (helo=localhost)
	by iabervon.org with local-esmtp (Exim 2.12 #2)
	id 1DlJF8-0000cU-00; Thu, 23 Jun 2005 00:23:10 -0400
To: Jeff Garzik <jgarzik@pobox.com>
In-Reply-To: <42B9E536.60704@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Wed, 22 Jun 2005, Jeff Garzik wrote:

> 5) check in your own modifications (e.g. do some hacking, or apply a patch)
> 
> # go to repo
> $ cd linux-2.6
> 
> # make some modifications
> $ patch -sp1 < /tmp/my.patch
> $ diffstat -p1 < /tmp/my.patch
> 
> # NOTE: add '--add' and/or '--remove' if files were added or removed
> $ git-update-cache <list of all files changed>

There's actually "git add" for when you add a file (if you're actually
developing with git, rather than just applying patching with it). No
script, so far as I can tell, for removing a file, though.

	-Daniel
*This .sig left intentionally blank*

