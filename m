From: Greg KH <greg@kroah.com>
Subject: Re: bisect gives strange answer
Date: Thu, 4 Aug 2005 10:26:35 -0700
Message-ID: <20050804172635.GA14144@kroah.com>
References: <7v8xzi42bm.fsf@assigned-by-dhcp.cox.net> <E1E0a4e-0000vu-69@approximate.corpus.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 04 19:32:59 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E0jYF-0003GV-Uh
	for gcvg-git@gmane.org; Thu, 04 Aug 2005 19:30:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261795AbVHDR3x (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 4 Aug 2005 13:29:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261203AbVHDR14
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Aug 2005 13:27:56 -0400
Received: from mail.kroah.org ([69.55.234.183]:11676 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261821AbVHDR1D (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 4 Aug 2005 13:27:03 -0400
Received: from [192.168.0.10] (c-24-22-115-24.hsd1.or.comcast.net [24.22.115.24])
	(authenticated)
	by perch.kroah.org (8.11.6/8.11.6) with ESMTP id j74HQow10978;
	Thu, 4 Aug 2005 10:26:50 -0700
Received: from greg by echidna.kroah.org with local (masqmail 0.2.19)
 id 1E0jUJ-3hH-00; Thu, 04 Aug 2005 10:26:35 -0700
To: Sanjoy Mahajan <sanjoy@mrao.cam.ac.uk>
Content-Disposition: inline
In-Reply-To: <E1E0a4e-0000vu-69@approximate.corpus.cam.ac.uk>
User-Agent: Mutt/1.5.8i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 04, 2005 at 03:23:28AM -0400, Sanjoy Mahajan wrote:
> > Could you try this please?
> 
> Thanks, it now finishes with the diff that I expected:
> 
> 3d3c2ae1101c1f2dff7e2f9d514769779dbd2737 is first bad commit
> diff-tree 3d3c2ae1101c1f2dff7e2f9d514769779dbd2737 (from a18bcb7450840f07a772a45229de4811d930f461)
> Author: Greg KH <gregkh@suse.de>
> Date:   Wed Jul 6 09:09:38 2005 -0700
> 
>     [PATCH] PCI: fix !CONFIG_HOTPLUG pci build problem
>     
>     Here's a patch to fix the build issue when CONFIG_HOTPLUG is not enabled
>     in 2.6.13-rc2.
>     
>     Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
>     Signed-off-by: Linus Torvalds <torvalds@osdl.org>

By any chance, is this patch causing you problems?

Just curious :)

greg k-h
