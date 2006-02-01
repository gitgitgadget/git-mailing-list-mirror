From: Junio C Hamano <junkio@cox.net>
Subject: Re: [Census] So who uses git?
Date: Tue, 31 Jan 2006 21:42:47 -0800
Message-ID: <7vy80vmy7c.fsf@assigned-by-dhcp.cox.net>
References: <1138446030.9919.112.camel@evo.keithp.com>
	<7vzmlgt5zt.fsf@assigned-by-dhcp.cox.net>
	<1138529385.9919.185.camel@evo.keithp.com>
	<43DCA495.9040301@gorzow.mm.pl> <20060130225107.GA3857@limbo.home>
	<Pine.LNX.4.64.0601311314030.7301@g5.osdl.org>
	<20060131220148.GA19411@steel.home> <20060201013901.GA16832@mail.com>
	<Pine.LNX.4.64.0601311747360.7301@g5.osdl.org>
	<7v64nzollt.fsf@assigned-by-dhcp.cox.net>
	<20060201045337.GC25753@mail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 01 06:43:02 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F4Ala-0000ua-F5
	for gcvg-git@gmane.org; Wed, 01 Feb 2006 06:42:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030398AbWBAFmv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Feb 2006 00:42:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030389AbWBAFmu
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Feb 2006 00:42:50 -0500
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:10685 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S1030398AbWBAFmt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Feb 2006 00:42:49 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060201053945.QGAT20050.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 1 Feb 2006 00:39:45 -0500
To: Ray Lehtiniemi <rayl@mail.com>
In-Reply-To: <20060201045337.GC25753@mail.com> (Ray Lehtiniemi's message of
	"Tue, 31 Jan 2006 21:53:37 -0700")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15387>

Ray Lehtiniemi <rayl@mail.com> writes:

> what if the user wants to change the mode bits of an assume-unchanged
> file with the twiddled permissions, but forgets to clear the flag
> first?  seems like that change is likely to get lost, especially if the
> new mode is read-only....

No problem, since we only record u+x bit and nothing else.  Most
importantly, we do not record any of the +w bits.
