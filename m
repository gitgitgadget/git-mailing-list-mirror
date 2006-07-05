From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Additional merge-base tests
Date: Tue, 04 Jul 2006 17:24:33 -0700
Message-ID: <7v1wt0gapq.fsf@assigned-by-dhcp.cox.net>
References: <44A9E6AE.10508@gmail.com>
	<7v3bdhoraa.fsf@assigned-by-dhcp.cox.net> <44AA0DAE.1060308@gmail.com>
	<7vpsgllsnp.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0607041019580.29667@wbgn013.biozentrum.uni-wuerzburg.de>
	<7v8xn9gjh5.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0607050021330.29667@wbgn013.biozentrum.uni-wuerzburg.de>
	<44AAF49F.6090008@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 05 02:24:53 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FxvC9-00005f-NE
	for gcvg-git@gmane.org; Wed, 05 Jul 2006 02:24:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932356AbWGEAYf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 4 Jul 2006 20:24:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932361AbWGEAYf
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Jul 2006 20:24:35 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:32998 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S932356AbWGEAYe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Jul 2006 20:24:34 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060705002434.BDVH554.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 4 Jul 2006 20:24:34 -0400
To: gitzilla@gmail.com,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <44AAF49F.6090008@gmail.com> (A. Large Angry's message of "Tue,
	04 Jul 2006 16:07:11 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23331>

A Large Angry SCM <gitzilla@gmail.com> writes:

>
> It works[*] and it does what using the timestamp was trying to
> do. Namely, work from "more recent" (or "closer") commits toward
> "older" (or "farther") commits until you've gone past the point you
> care about.

If you really really care, now we have clear_commit_marks() with
get_merge_bases() infrastructure in, you _could_ run another
round of get_merge_bases() on the commit on the result list to
see which ones are reachable from others by performing an
equivalent of fast-forward/already-up-to-date check.
