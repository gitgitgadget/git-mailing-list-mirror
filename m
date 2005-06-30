From: Nicolas Pitre <nico@cam.org>
Subject: Re: verify_pack.c vs verify-pack.c
Date: Thu, 30 Jun 2005 16:35:45 -0400 (EDT)
Message-ID: <Pine.LNX.4.63.0506301631480.1667@localhost.localdomain>
References: <Pine.LNX.4.63.0506301336460.1667@localhost.localdomain>
 <7vy88r1tcp.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 30 22:34:30 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Do5jc-0004Hm-9w
	for gcvg-git@gmane.org; Thu, 30 Jun 2005 22:34:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263108AbVF3UkM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 30 Jun 2005 16:40:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263035AbVF3UgV
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Jun 2005 16:36:21 -0400
Received: from relais.videotron.ca ([24.201.245.36]:25977 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP id S263114AbVF3Uft
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Jun 2005 16:35:49 -0400
Received: from xanadu.home ([24.200.213.96]) by VL-MO-MR011.ip.videotron.ca
 (iPlanet Messaging Server 5.2 HotFix 1.21 (built Sep  8 2003))
 with ESMTP id <0IIW00MLIZVLNT@VL-MO-MR011.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 30 Jun 2005 16:35:45 -0400 (EDT)
In-reply-to: <7vy88r1tcp.fsf@assigned-by-dhcp.cox.net>
X-X-Sender: nico@localhost.localdomain
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Thu, 30 Jun 2005, Junio C Hamano wrote:

> >>>>> "NP" == Nicolas Pitre <nico@cam.org> writes:
> 
> NP> This is confusing.  Isn't possible to rename git-verify-pack to, say, 
> NP> git-fsck-pack instead?
> 
> Yes it is possible (I am not attached to the name).  The
> question is what to name it.

... or you could rename verify_pack.c to pack-check.c or whatever.

> BTW, is there a filesystem that would house the source to the
> core GIT that do not like names that differ only in underscore
> and dash?

Probably not.  It is just weird in a ls output that's all.  Certainly 
not a big issue.


Nicolas
