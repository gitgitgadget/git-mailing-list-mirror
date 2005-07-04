From: "David S. Miller" <davem@davemloft.net>
Subject: Re: expensive local git clone
Date: Mon, 04 Jul 2005 15:49:33 -0700 (PDT)
Message-ID: <20050704.154933.104033112.davem@davemloft.net>
References: <20050704204235.GE21128@pasky.ji.cz>
	<20050704.140043.112609056.davem@davemloft.net>
	<7v7jg6i72c.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: torvalds@osdl.org, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 05 00:50:30 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DpZlK-0006Jl-W2
	for gcvg-git@gmane.org; Tue, 05 Jul 2005 00:50:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261728AbVGDWtm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 4 Jul 2005 18:49:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261727AbVGDWtm
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Jul 2005 18:49:42 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:20430
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S261730AbVGDWti (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Jul 2005 18:49:38 -0400
Received: from localhost ([127.0.0.1] ident=davem)
	by sunset.davemloft.net with esmtp (Exim 4.50)
	id 1DpZkr-0000kr-NS; Mon, 04 Jul 2005 15:49:33 -0700
To: junkio@cox.net
In-Reply-To: <7v7jg6i72c.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

From: Junio C Hamano <junkio@cox.net>
Date: Mon, 04 Jul 2005 14:40:11 -0700

> >>>>> "DSM" == David S Miller <davem@davemloft.net> writes:
> 
> DSM> I keep hoping git-clone-script is going to be a good way
> DSM> to clone two local trees.  Is my hope misguided?  :-)
> 
> Something along these lines?

Looks interesting.  Any particular reason to use "cpio"
instead of "cp"?
