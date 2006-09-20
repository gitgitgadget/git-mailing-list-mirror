From: Junio C Hamano <junkio@cox.net>
Subject: Re: git pull for update of netdev fails.
Date: Wed, 20 Sep 2006 09:05:58 -0700
Message-ID: <7vhcz2jzfd.fsf@assigned-by-dhcp.cox.net>
References: <20060920080308.673a1e93@localhost.localdomain>
	<Pine.LNX.4.64.0609200816400.4388@g5.osdl.org>
	<20060920155431.GO8259@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Stephen Hemminger <shemminger@osdl.org>,
	Jeff Garzik <jgarzik@pobox.com>, git@vger.kernel.org,
	Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Wed Sep 20 18:07:01 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GQ4aK-0008MK-F4
	for gcvg-git@gmane.org; Wed, 20 Sep 2006 18:06:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751711AbWITQGA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Sep 2006 12:06:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751704AbWITQGA
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Sep 2006 12:06:00 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:3807 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S1751705AbWITQGA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Sep 2006 12:06:00 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060920160559.ZFYJ12581.fed1rmmtao02.cox.net@fed1rmimpo01.cox.net>;
          Wed, 20 Sep 2006 12:05:59 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id Qg5k1V00c1kojtg0000000
	Wed, 20 Sep 2006 12:05:45 -0400
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20060920155431.GO8259@pasky.or.cz> (Petr Baudis's message of
	"Wed, 20 Sep 2006 17:54:31 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27356>

Petr Baudis <pasky@suse.cz> writes:

> Dear diary, on Wed, Sep 20, 2006 at 05:28:08PM CEST, I got a letter
> where Linus Torvalds <torvalds@osdl.org> said that...
>> However, you can tell git that Jeff is being difficult by marking such 
>> branches individually as being rebased.
>
> This is really a wrong way of describing the problem - I'd say that Git
> is being difficult here. The point is, the subsystem maintainers need to
> maintain stacks of patches and rebase against the main kernel branch
> regularily, and they want to still publish their current state. So it's
> not really any of them being strange or difficult, but Git being so
> because it has no seamless support for tracking those branches.

Seamless support is there and Linus described how without
breaking the usual "if not fast forward you may lose some
patches so be extra careful" safety valve.

I do not see what your problem is.
