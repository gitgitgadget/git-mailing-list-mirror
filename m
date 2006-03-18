From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] 3% tighter packs for free
Date: Sat, 18 Mar 2006 11:24:37 -0800
Message-ID: <7vhd5vwo7e.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0603172205490.4889@localhost.localdomain>
	<7vwtesxloi.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0603181315060.4889@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 18 20:24:55 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FKh2g-0000rH-UC
	for gcvg-git@gmane.org; Sat, 18 Mar 2006 20:24:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750797AbWCRTYj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 18 Mar 2006 14:24:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750820AbWCRTYj
	(ORCPT <rfc822;git-outgoing>); Sat, 18 Mar 2006 14:24:39 -0500
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:50119 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S1750797AbWCRTYj (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Mar 2006 14:24:39 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060318192135.YYFB17838.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 18 Mar 2006 14:21:35 -0500
To: Nicolas Pitre <nico@cam.org>
In-Reply-To: <Pine.LNX.4.64.0603181315060.4889@localhost.localdomain> (Nicolas
	Pitre's message of "Sat, 18 Mar 2006 13:23:37 -0500 (EST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17702>

Nicolas Pitre <nico@cam.org> writes:

> Tried that long ago.  As BLK_SIZE is increased the adler32 cost, which 
> has to be computed for every offset in the target buffer, increases 
> accordingly.  So you end up with both worse compression and more CPU 
> usage.

Ah, I was not paying enough attention.  I did not realize
destination scanning was done for every byte.
