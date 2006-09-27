From: Junio C Hamano <junkio@cox.net>
Subject: Re: git and time
Date: Tue, 26 Sep 2006 21:53:44 -0700
Message-ID: <7vy7s5j4fb.fsf@assigned-by-dhcp.cox.net>
References: <20060926233321.GA17084@coredump.intra.peff.net>
	<20060927002745.15344.qmail@web51005.mail.yahoo.com>
	<20060927033459.GA27622@coredump.intra.peff.net>
	<20060926234309.b16aa44e.seanlkml@sympatico.ca>
	<20060927042850.GB9460@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 27 06:53:57 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GSRQb-0001GV-5p
	for gcvg-git@gmane.org; Wed, 27 Sep 2006 06:53:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965094AbWI0Exq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Sep 2006 00:53:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965123AbWI0Exq
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Sep 2006 00:53:46 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:3736 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S965094AbWI0Exp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Sep 2006 00:53:45 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060927045345.TSWN12581.fed1rmmtao02.cox.net@fed1rmimpo01.cox.net>;
          Wed, 27 Sep 2006 00:53:45 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id TGti1V0071kojtg0000000
	Wed, 27 Sep 2006 00:53:42 -0400
To: Shawn Pearce <spearce@spearce.org>
In-Reply-To: <20060927042850.GB9460@spearce.org> (Shawn Pearce's message of
	"Wed, 27 Sep 2006 00:28:50 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27870>

Shawn Pearce <spearce@spearce.org> writes:

> For what its worth I keep meaning to get around to fix receive-pack.c
> but I just haven't done it yet.

I've been futzing around that code because I wanted to make sure
we get the locking right on creation and deletion of refs.  I'll
try to remember when I revisit the code tomorrow.
