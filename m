From: Matt McCutchen <hashproduct@verizon.net>
Subject: Re: How to switch kernel customizations from 2.6.15.6 to 2.6.16?
Date: Wed, 29 Mar 2006 22:47:55 -0500
Message-ID: <1143690475.2524.7.camel@mattlaptop.metaesthetics.net>
References: <1143596622.2481.10.camel@mattlaptop.metaesthetics.net>
	<7vmzfac7gn.fsf@assigned-by-dhcp.cox.net>
	<1143687710.2524.1.camel@mattlaptop.metaesthetics.net>
	<7vy7ys4nwk.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 30 05:48:05 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FOo8i-0000RG-QZ
	for gcvg-git@gmane.org; Thu, 30 Mar 2006 05:48:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750727AbWC3Dr6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 29 Mar 2006 22:47:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751302AbWC3Dr6
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Mar 2006 22:47:58 -0500
Received: from vms040pub.verizon.net ([206.46.252.40]:19312 "EHLO
	vms040pub.verizon.net") by vger.kernel.org with ESMTP
	id S1750727AbWC3Dr5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Mar 2006 22:47:57 -0500
Received: from [192.168.1.5] ([151.200.44.96])
 by vms040.mailsrvcs.net (Sun Java System Messaging Server 6.2-4.02 (built Sep
 9 2005)) with ESMTPA id <0IWX00LZX97WUM63@vms040.mailsrvcs.net> for
 git@vger.kernel.org; Wed, 29 Mar 2006 21:47:57 -0600 (CST)
In-reply-to: <7vy7ys4nwk.fsf@assigned-by-dhcp.cox.net>
To: Junio C Hamano <junkio@cox.net>
X-Mailer: Evolution 2.6.0 (2.6.0-1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18190>

On Wed, 2006-03-29 at 19:22 -0800, Junio C Hamano wrote:
> It should have been 
> 
>         $ git format-patch --stdout origin master | git am -3

Thanks!  My kernel is finally merged and is building as I write!  It
turns out that parts of my commits #2-#4 had already been addressed
between 2.6.15.6 and 2.6.16.  I had to merge #2 with what had already
been done, and #3 and #4 became unnecessary.
-- 
Matt McCutchen
hashproduct@verizon.net
http://hashproduct.metaesthetics.net/
