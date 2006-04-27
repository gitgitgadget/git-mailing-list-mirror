From: Junio C Hamano <junkio@cox.net>
Subject: Re: bug: git-repack -a -d produces broken pack on NFS
Date: Thu, 27 Apr 2006 15:44:15 -0700
Message-ID: <7vzmi6iqps.fsf@assigned-by-dhcp.cox.net>
References: <20060427213207.GA6709@steel.home>
	<Pine.LNX.4.64.0604271500500.3701@g5.osdl.org>
	<7v4q0ek6i3.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0604271526140.3701@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 28 00:44:23 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FZFDg-0002Qj-7Q
	for gcvg-git@gmane.org; Fri, 28 Apr 2006 00:44:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751736AbWD0WoR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 27 Apr 2006 18:44:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751737AbWD0WoR
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Apr 2006 18:44:17 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:38791 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S1751735AbWD0WoQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Apr 2006 18:44:16 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060427224416.MCSK25666.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 27 Apr 2006 18:44:16 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0604271526140.3701@g5.osdl.org> (Linus Torvalds's
	message of "Thu, 27 Apr 2006 15:29:11 -0700 (PDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19251>

Linus Torvalds <torvalds@osdl.org> writes:

> Right now, if the pack-file is corrupt, it doesn't actually tell us so. It 
> says that it doesn't match the index file. Which is likely wrong - it 
> probably _does_ match the index file, but it's been corrupted.
>
> See the difference?

Makes perfect sense.  Thanks.
