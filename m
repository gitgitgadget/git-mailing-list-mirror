From: Junio C Hamano <junkio@cox.net>
Subject: Re: git reveals a bug in (some versions) BSD diff
Date: Fri, 12 Aug 2005 09:30:42 -0700
Message-ID: <7vk6irw219.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0508121424500.24891@wgmdd8.biozentrum.uni-wuerzburg.de>
	<7vd5ojxiny.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0508121801310.26333@wgmdd8.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 12 18:31:05 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E3cQh-0006yV-N5
	for gcvg-git@gmane.org; Fri, 12 Aug 2005 18:30:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750911AbVHLQap (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 12 Aug 2005 12:30:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751222AbVHLQap
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Aug 2005 12:30:45 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:47813 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S1750911AbVHLQao (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Aug 2005 12:30:44 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050812163044.RYWQ3209.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 12 Aug 2005 12:30:44 -0400
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0508121801310.26333@wgmdd8.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Fri, 12 Aug 2005 18:04:19 +0200
	(CEST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> I'd prefer to deprecate that diff program by telling so in the test. 
> Something along the lines "blabla. If this fails, chances are you have a 
> borked diff. Try GNU diff..."

Wouldn't it give the people with broken diff a false impression
that their "git diff" actually produces a good result when it
does not?
