From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] git-commit: revamp the git-commit semantics.
Date: Sun, 05 Feb 2006 12:03:45 -0800
Message-ID: <7v64ntindq.fsf@assigned-by-dhcp.cox.net>
References: <7vpsm2hzng.fsf@assigned-by-dhcp.cox.net>
	<e5bfff550602050536j73f1091dq9afae232f574d0b4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 05 21:03:58 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F5q6v-0002hA-Mv
	for gcvg-git@gmane.org; Sun, 05 Feb 2006 21:03:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750708AbWBEUDs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 5 Feb 2006 15:03:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750707AbWBEUDs
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Feb 2006 15:03:48 -0500
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:42166 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S1750708AbWBEUDr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Feb 2006 15:03:47 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060205200114.RSVY26964.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 5 Feb 2006 15:01:14 -0500
To: Marco Costalba <mcostalba@gmail.com>
In-Reply-To: <e5bfff550602050536j73f1091dq9afae232f574d0b4@mail.gmail.com>
	(Marco Costalba's message of "Sun, 5 Feb 2006 14:36:51 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15636>

I was planning to think about the migration strategy _after_ I
get the feeling that everybody who got confused by the current
one thinks this is a good change, and I am glad you did that
work for me ;-).

I think it is sane to add a no-op '--include' to the current
version.

I am not sure if it is worth to take two-phased introduction of
this new "temporary index" thing.  We could:

 * add '--only' that asks for the new "temporary index" thing.

 * initially make '--include' the default, not '--only'.

 * later switch the default to '--only'.
