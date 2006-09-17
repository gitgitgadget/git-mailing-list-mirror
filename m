From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] git-repack(1): document --window and --depth
Date: Sun, 17 Sep 2006 14:18:11 -0700
Message-ID: <7vpsdu2nvw.fsf@assigned-by-dhcp.cox.net>
References: <20060917110259.GB1497@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 17 23:18:35 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GP41w-0005De-26
	for gcvg-git@gmane.org; Sun, 17 Sep 2006 23:18:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965109AbWIQVSO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Sep 2006 17:18:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965110AbWIQVSO
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Sep 2006 17:18:14 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:62672 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S965109AbWIQVSN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Sep 2006 17:18:13 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060917211812.URWY6077.fed1rmmtao01.cox.net@fed1rmimpo01.cox.net>;
          Sun, 17 Sep 2006 17:18:12 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id PZHz1V00Z1kojtg0000000
	Sun, 17 Sep 2006 17:18:00 -0400
To: Jonas Fonseca <fonseca@diku.dk>
In-Reply-To: <20060917110259.GB1497@diku.dk> (Jonas Fonseca's message of "Sun,
	17 Sep 2006 13:02:59 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27205>

Jonas Fonseca <fonseca@diku.dk> writes:

> Copy and pasted from git-pack-objects(1).

I've been fighting the urge to do this myself for a few months
now ;-)

$ git log -S--window -- git-repack.sh
commit ccb365047a1081455b767867f0887e7b4334f9d8
Author: Linus Torvalds <torvalds@osdl.org>
Date:   Wed Apr 19 10:05:12 2006 -0700

    Allow "git repack" users to specify repacking window/depth
    
    .. but don't even bother documenting it. I don't think any normal person
    is supposed to ever really care, but it simplifies testing when you want
    to use the "git repack" wrapper rather than forcing you to use the core
    programs (which already do support the window/depth arguments, of course).

I will take your patch; I think it is useful to document this.
Thanks.
