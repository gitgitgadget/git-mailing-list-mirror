From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 19/19] gitweb: Remove creating directory for temporary files
Date: Fri, 25 Aug 2006 22:13:50 -0700
Message-ID: <7vejv43wq9.fsf@assigned-by-dhcp.cox.net>
References: <200608240015.15071.jnareb@gmail.com>
	<200608252135.27894.jnareb@gmail.com>
	<e5bfff550608251433o36713ee1na5544992320b5845@mail.gmail.com>
	<7vveog45ff.fsf@assigned-by-dhcp.cox.net>
	<e5bfff550608252144p2d234a7cnf2ca2922c98d921b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 26 07:13:53 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GGqUQ-0003wq-KD
	for gcvg-git@gmane.org; Sat, 26 Aug 2006 07:13:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964795AbWHZFNf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 26 Aug 2006 01:13:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964807AbWHZFNf
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Aug 2006 01:13:35 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:55976 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S964795AbWHZFNf (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Aug 2006 01:13:35 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060826051334.TCJO12581.fed1rmmtao02.cox.net@fed1rmimpo02.cox.net>;
          Sat, 26 Aug 2006 01:13:34 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
	by fed1rmimpo02.cox.net with bizsmtp
	id EVDa1V00A4Noztg0000000
	Sat, 26 Aug 2006 01:13:34 -0400
To: "Marco Costalba" <mcostalba@gmail.com>
In-Reply-To: <e5bfff550608252144p2d234a7cnf2ca2922c98d921b@mail.gmail.com>
	(Marco Costalba's message of "Sat, 26 Aug 2006 06:44:44 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26029>

"Marco Costalba" <mcostalba@gmail.com> writes:

>> > - Original code lines, ie. imported at the beginning and never
>> > modified, perhaps it is better to view without commit number, this
>> > could obfuscate the view and in any case is not an accurate info
>> > because the line was not modified during initial patch.
>>
>> That holds only true for very young projects, or ones that were
>> perfect from the beginning and did not see much action ;-).
>
> Or also for projects like Linux ;-)
>
> See blame output of something like kernel/dma.c or also kernel/exit.c,
> not exactly the most unknown files around.

Actually Linux git archive _is_ a special, odd-ball case.  Their
initial commit (2.6.12-rc2) contains all the fruits from their
10 years of evolution without git.

People with long history stored in some SCM tend to want to
migrate their history and then switch, and I expect that to be
the norm, especially with the progress Mozilla import team is
making with the CVS interface.
