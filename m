From: David Miller <davem@davemloft.net>
Subject: Re: git send-email woes
Date: Mon, 25 Sep 2006 14:17:40 -0700 (PDT)
Message-ID: <20060925.141740.122618728.davem@davemloft.net>
References: <20060924224316.GA28051@uranus.ravnborg.org>
	<20060925183221.GE2490@uranus.ravnborg.org>
	<7v7izrzpk2.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: sam@ravnborg.org, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 25 23:18:34 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GRxpt-0007BL-Gb
	for gcvg-git@gmane.org; Mon, 25 Sep 2006 23:17:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751287AbWIYVRy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 25 Sep 2006 17:17:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751371AbWIYVRy
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Sep 2006 17:17:54 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:59846
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1751287AbWIYVRx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Sep 2006 17:17:53 -0400
Received: from localhost (localhost [127.0.0.1])
	by sunset.davemloft.net (Postfix) with ESMTP id 1486FAE4257;
	Mon, 25 Sep 2006 14:17:41 -0700 (PDT)
To: junkio@cox.net
In-Reply-To: <7v7izrzpk2.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27754>

From: Junio C Hamano <junkio@cox.net>
Date: Mon, 25 Sep 2006 12:58:21 -0700

> Sam Ravnborg <sam@ravnborg.org> writes:
> 
> > The patches in quistion did not have a "Signed-off-by: tag so
> > that mail address has been from the author instead.
> > And this mail address was still invalid as per RFC2822.
> 
> I do not think it takes Signed-off-by: as author in any case
> (and I do not think it should -- if it did so it is a bug).
> 
> Maybe something like this?

That looks like it would do the trick.
