From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Fix git to be (more) ANSI C99 compliant.
Date: Wed, 21 Jun 2006 04:15:26 -0700
Message-ID: <7vodwmzrn5.fsf@assigned-by-dhcp.cox.net>
References: <1150609831500-git-send-email-octo@verplant.org>
	<Pine.LNX.4.64.0606180946090.5498@g5.osdl.org>
	<20060619212116.GL1331@verplant.org>
	<7vac8860z9.fsf@assigned-by-dhcp.cox.net>
	<4497AED4.5060505@lsrfire.ath.cx>
	<7vr71kcien.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Wed Jun 21 13:15:33 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ft0gG-0002gm-Gs
	for gcvg-git@gmane.org; Wed, 21 Jun 2006 13:15:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932065AbWFULP2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 21 Jun 2006 07:15:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932067AbWFULP2
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Jun 2006 07:15:28 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:46293 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S932065AbWFULP1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Jun 2006 07:15:27 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060621111527.JHTR22974.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 21 Jun 2006 07:15:27 -0400
To: git@vger.kernel.org
In-Reply-To: <7vr71kcien.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Tue, 20 Jun 2006 01:58:56 -0700")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22262>

Junio C Hamano <junkio@cox.net> writes:

> I think applying the patch in question on top of Florian's 11172e
> would be the most sensible, since that is currently the tip of ff/c99
> topic branch whose early parts have been merged to "next" and
> the tip to "pu".  When Linus feels as sympathetic as I do, we
> can pull the rest of ff/c99 branch to "next" and then eventually
> to "master" and the patch will be merged together without
> introducing the nonsense casts.

Now, without asking Linus about this further, I felt sympathetic
enough to decide that void-pointer arithmetic avoidance is not
so bad (touches only 70 lines or so in 19 files); tonight's
"next" should be compilable with the default Solaris compiler.
