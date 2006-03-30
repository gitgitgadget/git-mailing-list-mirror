From: Matt McCutchen <hashproduct@verizon.net>
Subject: Re: How to switch kernel customizations from 2.6.15.6 to 2.6.16?
Date: Thu, 30 Mar 2006 16:50:59 -0500
Message-ID: <1143755459.2487.12.camel@mattlaptop.metaesthetics.net>
References: <1143596622.2481.10.camel@mattlaptop.metaesthetics.net>
	<7vmzfac7gn.fsf@assigned-by-dhcp.cox.net>
	<1143687710.2524.1.camel@mattlaptop.metaesthetics.net>
	<Pine.LNX.4.64.0603300919280.27203@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 30 23:51:26 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FP52o-0008Cc-Ug
	for gcvg-git@gmane.org; Thu, 30 Mar 2006 23:51:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751014AbWC3VvD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 30 Mar 2006 16:51:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751016AbWC3VvD
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Mar 2006 16:51:03 -0500
Received: from vms040pub.verizon.net ([206.46.252.40]:19944 "EHLO
	vms040pub.verizon.net") by vger.kernel.org with ESMTP
	id S1751014AbWC3VvB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Mar 2006 16:51:01 -0500
Received: from [192.168.1.5] ([68.239.98.224])
 by vms040.mailsrvcs.net (Sun Java System Messaging Server 6.2-4.02 (built Sep
 9 2005)) with ESMTPA id <0IWY00JM8ND0UPE6@vms040.mailsrvcs.net> for
 git@vger.kernel.org; Thu, 30 Mar 2006 15:51:01 -0600 (CST)
In-reply-to: <Pine.LNX.4.64.0603300919280.27203@g5.osdl.org>
To: Linus Torvalds <torvalds@osdl.org>
X-Mailer: Evolution 2.6.0 (2.6.0-1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18207>

On Thu, 2006-03-30 at 09:32 -0800, Linus Torvalds wrote:
> The beauty of git should be (and maybe that's not entirely true simply 
> because of practical concerns) that there really need not be any notion of 
> "more official".

I understand this, and it is one of several reasons why I prefer git to
other version control systems.  However, I thought there would be a
single official kernel repository even if git didn't require it.  Junio
explained to me that both yours and the stable one are official for
different purposes.  I think I will use the stable one because it is
current enough for my needs.

>  - the more fundamental one is that when you start mixing branches, you 
>    have to be very careful if you expect the upstream projects to pull the 
>    changes _back_. [...]

True.  It might help several branches coordinate development if a commit
could be marked as "equivalent" to another commit so that, if both were
involved in a merge, one could be thrown out.

-- 
Matt McCutchen
hashproduct@verizon.net
http://hashproduct.metaesthetics.net/
