From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC] send-pack: allow skipping delta when sending pack
Date: Sun, 21 May 2006 02:40:46 -0700
Message-ID: <7vpsi7yau9.fsf@assigned-by-dhcp.cox.net>
References: <20060521054827.GA18530@coredump.intra.peff.net>
	<7vy7wvx5o9.fsf@assigned-by-dhcp.cox.net>
	<20060521081435.GA4526@coredump.intra.peff.net>
	<7vlksvzsmd.fsf@assigned-by-dhcp.cox.net>
	<20060521084313.GA12825@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 21 11:43:04 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FhkQc-00009i-VI
	for gcvg-git@gmane.org; Sun, 21 May 2006 11:40:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932331AbWEUJks (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 21 May 2006 05:40:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932352AbWEUJks
	(ORCPT <rfc822;git-outgoing>); Sun, 21 May 2006 05:40:48 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:58825 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S932331AbWEUJkr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 May 2006 05:40:47 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060521094047.ZOIA15069.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 21 May 2006 05:40:47 -0400
To: Jeff King <peff@peff.net>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20446>

Jeff King <peff@peff.net> writes:

> What do you suggest for this performance issue, then?
> A manual no-delta trigger, or just going to get a cup of coffee while
> pushing (my tests showed 5-6x slowdown from deltifying)?

In the short term, give --depth to send-pack, would be better
than nothing.

I agree we should be able to do better.  But let me grab some
sleep now first ;-).
