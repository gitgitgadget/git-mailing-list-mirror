From: Junio C Hamano <junkio@cox.net>
Subject: Re: Barebone Porcelain.  Where to stop?
Date: Mon, 18 Jul 2005 17:10:36 -0700
Message-ID: <7vy883lkoz.fsf@assigned-by-dhcp.cox.net>
References: <7vek9yirdi.fsf@assigned-by-dhcp.cox.net>
	<42DB32F1.5020900@gmail.com> <tnx3bqcxvkm.fsf@arm.com>
	<7v8y04q6sj.fsf@assigned-by-dhcp.cox.net>
	<42DC17C5.80000@tuxrocks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Catalin Marinas <catalin.marinas@gmail.com>,
	Bryan Larsen <bryan.larsen@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 19 02:10:56 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DufhE-0006Lf-3P
	for gcvg-git@gmane.org; Tue, 19 Jul 2005 02:10:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261539AbVGSAKm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 18 Jul 2005 20:10:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261670AbVGSAKm
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Jul 2005 20:10:42 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:46292 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S261539AbVGSAKk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jul 2005 20:10:40 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050719001037.OFLJ17043.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 18 Jul 2005 20:10:37 -0400
To: Frank Sorenson <frank@tuxrocks.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Frank Sorenson <frank@tuxrocks.com> writes:

> Is this something we want to consider, or am I out in left field? :)

I do not think so.  You just more clearly and explicitly stated
what I wanted to see; we share the same vision of the ideal
world.

I do however think your sights are probably focused at somewhere
a lot further then mine ;-).  C level interfaces to those
aggregated common operations would happen once after we identify
what kind of common operations are useful to have, prototyping
them (most likely in scripting environment), and if it turns out
to be useful and performance critical.  I personally do not
think we are there yet.
