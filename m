From: Greg KH <greg@kroah.com>
Subject: Re: Updated git HOWTO for kernel hackers
Date: Wed, 22 Jun 2005 16:09:05 -0700
Message-ID: <20050622230905.GA7873@kroah.com>
References: <42B9E536.60704@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jun 23 01:07:53 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DlEJa-0004KT-7C
	for gcvg-git@gmane.org; Thu, 23 Jun 2005 01:07:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262572AbVFVXM6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 22 Jun 2005 19:12:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262580AbVFVXMt
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Jun 2005 19:12:49 -0400
Received: from mail.kroah.org ([69.55.234.183]:60300 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262572AbVFVXJS (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 22 Jun 2005 19:09:18 -0400
Received: from [192.168.0.10] (c-24-22-112-187.hsd1.or.comcast.net [24.22.112.187])
	(authenticated)
	by perch.kroah.org (8.11.6/8.11.6) with ESMTP id j5MN9Ai12527;
	Wed, 22 Jun 2005 16:09:10 -0700
Received: from greg by echidna.kroah.org with local (masqmail 0.2.19)
 id 1DlELB-24G-00; Wed, 22 Jun 2005 16:09:05 -0700
To: Jeff Garzik <jgarzik@pobox.com>, torvalds@osdl.org
Content-Disposition: inline
In-Reply-To: <42B9E536.60704@pobox.com>
User-Agent: Mutt/1.5.8i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 22, 2005 at 06:24:54PM -0400, Jeff Garzik wrote:
> 10) don't forget to download tags from time to time.
> 
> git-pull-script only downloads sha1-indexed object data, and the 
> requested remote head.  This misses updates to the .git/refs/tags/ and 
> .git/refs/heads directories.  It is advisable to update your kernel .git 
> directories periodically with a full rsync command, to make sure you got 
> everything:
> 
> $ cd linux-2.6
> $ rsync -a --delete --verbose --stats --progress \
> rsync://rsync.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git/
> \          <- word-wrapped backslash; sigh
>     .git/

Ok, this is annoying.  Is there some reason why git doesn't pull the
tags in properly when doing a merge?  Chris and I just hit this when I
pulled his 2.6.12.1 tree and and was wondering where the tag went.

thanks,

greg k-h
