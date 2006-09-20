From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 2/2] gitweb: Make git_get_refs_list do work of git_get_references
Date: Wed, 20 Sep 2006 16:14:43 -0700
Message-ID: <7v4pv2f7vg.fsf@assigned-by-dhcp.cox.net>
References: <200609191430.51252.jnareb@gmail.com>
	<200609191433.22878.jnareb@gmail.com>
	<7veju6h0et.fsf@assigned-by-dhcp.cox.net>
	<200609210040.52886.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 21 01:14:53 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GQBHF-0003BD-Hi
	for gcvg-git@gmane.org; Thu, 21 Sep 2006 01:14:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750744AbWITXOq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Sep 2006 19:14:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750817AbWITXOq
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Sep 2006 19:14:46 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:17612 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S1750744AbWITXOp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Sep 2006 19:14:45 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060920231444.TTUF2704.fed1rmmtao03.cox.net@fed1rmimpo01.cox.net>;
          Wed, 20 Sep 2006 19:14:44 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id QnEW1V00W1kojtg0000000
	Wed, 20 Sep 2006 19:14:31 -0400
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <200609210040.52886.jnareb@gmail.com> (Jakub Narebski's message
	of "Thu, 21 Sep 2006 00:40:52 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27428>

Jakub Narebski <jnareb@gmail.com> writes:

> The %refs hash contain also map from peeled (dereferenced) object
> to ref name. The information about derefs is not present in @reflist.
> So the answer is that you can't derive %refs from @reflist. 

There we found one candidate for further interface clean-up ;-).
