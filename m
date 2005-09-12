From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Redirect cd output to /dev/null, was: git-clone seems dead
Date: Sun, 11 Sep 2005 18:47:30 -0700
Message-ID: <7vwtlnm4zx.fsf@assigned-by-dhcp.cox.net>
References: <vhp64t7v5ff.fsf@ebar091.ebar.dtu.dk>
	<7vd5nfs9y0.fsf@assigned-by-dhcp.cox.net>
	<20050911220421.GA14593@athame.dynamicro.on.ca>
	<20050911230136.GA15224@athame.dynamicro.on.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 12 03:48:12 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EEdPz-0002OG-Pm
	for gcvg-git@gmane.org; Mon, 12 Sep 2005 03:47:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751129AbVILBrd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Sep 2005 21:47:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751130AbVILBrd
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Sep 2005 21:47:33 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:51192 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S1751129AbVILBrc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Sep 2005 21:47:32 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050912014730.HMBU3414.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 11 Sep 2005 21:47:30 -0400
To: Greg Louis <glouis@dynamicro.ca>
In-Reply-To: <20050911230136.GA15224@athame.dynamicro.on.ca> (Greg Louis's
	message of "Sun, 11 Sep 2005 19:01:36 -0400")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8361>

I recall somebody else had trouble when we say 'cd blah' in our
script and the CDPATH in the user's environment interfere and
took us elsewhere.

I do not have any problem with people who have CDPATH defined as
a plain shell variable (not exported) in their interactive
shells, but I really do not see a point of having CDPATH as an
environment variable, exported to be honored by any unsuspecting
shell scripts.

Until somebody convinces me that CDPATH in the environment is a
good idea, I do not have much sympathy to people with such an
environment.
