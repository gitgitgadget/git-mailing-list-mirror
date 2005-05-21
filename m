From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: checkout-cache -f: a better way?
Date: Fri, 20 May 2005 21:45:53 -0400
Message-ID: <428E92D1.80408@pobox.com>
References: <428E5102.60003@pobox.com> <7vacmpsetb.fsf@assigned-by-dhcp.cox.net> <428E73B9.1080907@pobox.com> <7vvf5dqxfq.fsf@assigned-by-dhcp.cox.net> <428E7994.1090402@pobox.com> <Pine.LNX.4.58.0505201841550.2206@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat May 21 03:45:37 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DZJ37-00064B-AS
	for gcvg-git@gmane.org; Sat, 21 May 2005 03:45:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261632AbVEUBqG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 May 2005 21:46:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261636AbVEUBqG
	(ORCPT <rfc822;git-outgoing>); Fri, 20 May 2005 21:46:06 -0400
Received: from mail.dvmed.net ([216.237.124.58]:61114 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S261634AbVEUBqC (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 May 2005 21:46:02 -0400
Received: from cpe-065-184-065-144.nc.res.rr.com ([65.184.65.144] helo=[10.10.10.88])
	by mail.dvmed.net with esmtpsa (Exim 4.51 #1 (Red Hat Linux))
	id 1DZJ3s-0000Ny-UX; Sat, 21 May 2005 01:45:58 +0000
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050328 Fedora/1.7.6-1.2.5
X-Accept-Language: en-us, en
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0505201841550.2206@ppc970.osdl.org>
X-Spam-Score: 0.0 (/)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Linus Torvalds wrote:
> That's what, 20 times faster? 

:)


> More, actually, I suspect, since the "-m" version is not only faster, but
> it doesn't do much IO, so you'll not have tons of dirty pages/inodes etc
> afterwards.

Yep.  A -lot- of writeback would occur, a few seconds after my original 
script completed.

	Jeff


