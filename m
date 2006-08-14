From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Multiple refs from the same remote in one git fetch
Date: Mon, 14 Aug 2006 00:34:44 -0700
Message-ID: <7v64gvg48b.fsf@assigned-by-dhcp.cox.net>
References: <7vzme7g8wt.fsf@assigned-by-dhcp.cox.net>
	<20060814063309.GD21963@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 14 09:34:58 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GCWyI-0007gz-Do
	for gcvg-git@gmane.org; Mon, 14 Aug 2006 09:34:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751918AbWHNHeq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 14 Aug 2006 03:34:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751919AbWHNHeq
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Aug 2006 03:34:46 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:3982 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S1751918AbWHNHeq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Aug 2006 03:34:46 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060814073445.YGXC6711.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 14 Aug 2006 03:34:45 -0400
To: "Michael S. Tsirkin" <mst@mellanox.co.il>
In-Reply-To: <20060814063309.GD21963@mellanox.co.il> (Michael S. Tsirkin's
	message of "Mon, 14 Aug 2006 09:33:09 +0300")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25328>

"Michael S. Tsirkin" <mst@mellanox.co.il> writes:

> On a more theoretical level, in a shared repository
> development style, one might imagine several people who want
> the branch to be called differently.

A shared repository in git context usually means the repository
"everybody pushes into and pulls _from_".  We are talking about
pulling into a repository -- and even if you are using a shared
repository you do not share a repository you pull into.

A shared repository style" does not mean anarchy; helping to
name the same thing with multiple branch names at the central
site is not something we would want to encourage anyway.
