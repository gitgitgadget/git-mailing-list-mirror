From: Junio C Hamano <junkio@cox.net>
Subject: Re: openbsd version?
Date: Thu, 13 Oct 2005 00:47:26 -0700
Message-ID: <7vpsq9504x.fsf@assigned-by-dhcp.cox.net>
References: <8664s5gxl9.fsf@blue.stonehenge.com>
	<Pine.LNX.4.64.0510100939320.14597@g5.osdl.org>
	<7vvf0542fs.fsf@assigned-by-dhcp.cox.net>
	<864q7pdvcn.fsf@blue.stonehenge.com>
	<7vll113yjs.fsf@assigned-by-dhcp.cox.net>
	<20051010210007.GJ8383MdfPADPa@greensroom.kotnet.org>
	<7vzmph1225.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Randal L. Schwartz" <merlyn@stonehenge.com>
X-From: git-owner@vger.kernel.org Thu Oct 13 09:50:37 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EPxof-0006nh-Gb
	for gcvg-git@gmane.org; Thu, 13 Oct 2005 09:47:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750763AbVJMHr3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 13 Oct 2005 03:47:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750786AbVJMHr3
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Oct 2005 03:47:29 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:13509 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S1750763AbVJMHr2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Oct 2005 03:47:28 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051013074711.TQBP29333.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 13 Oct 2005 03:47:11 -0400
To: Sven Verdoolaege <skimo@kotnet.org>
In-Reply-To: <7vzmph1225.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Mon, 10 Oct 2005 14:42:42 -0700")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10065>

Junio C Hamano <junkio@cox.net> writes:

> Sven Verdoolaege <skimo@kotnet.org> writes:
>
>> I think you mean 
>>
>> $ git-update-ref refs/heads/mybranch mybranch^
>
> Of course you are right.  Thanks.

And I am an idiot.  I did that myself again, and ended up
wasting 30 minutes or so, scratching my head.

Maybe there should be a safety measure built into git-update-ref
that says single-level name (i.e. not starting with refs/) gets
warning unless all uppercase or something silly like that to
protect idiots like myself.  Hmmm.
