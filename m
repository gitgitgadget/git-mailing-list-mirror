From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] git-mv.perl: use stderr for error output and cleanup
Date: Sat, 07 Jan 2006 13:04:46 -0800
Message-ID: <7v7j9bg369.fsf@assigned-by-dhcp.cox.net>
References: <81b0412b0601050349s6bec1a36jc410fd315fbbc4c@mail.gmail.com>
	<7vek3lq8wu.fsf@assigned-by-dhcp.cox.net>
	<86wthd7ypx.fsf@blue.stonehenge.com>
	<20060107102820.GB5536@steel.home>
	<86sls0498w.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 07 22:04:56 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EvLF6-0000pK-K9
	for gcvg-git@gmane.org; Sat, 07 Jan 2006 22:04:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030574AbWAGVEu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 7 Jan 2006 16:04:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030575AbWAGVEt
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Jan 2006 16:04:49 -0500
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:55506 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S1030574AbWAGVEt (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Jan 2006 16:04:49 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060107210336.EFPL20441.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 7 Jan 2006 16:03:36 -0500
To: merlyn@stonehenge.com (Randal L. Schwartz)
In-Reply-To: <86sls0498w.fsf@blue.stonehenge.com> (Randal L. Schwartz's
	message of "07 Jan 2006 02:34:23 -0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14275>

merlyn@stonehenge.com (Randal L. Schwartz) writes:

>>> Being as I'm a *bit* familiar with Perl, I'd write that as:
>>> 
>>> print H "$_\0" for @deletedfiles;
>
> ...  It was added for Perl 5.5, first released on 22 July 1998.

BTW, I never understood the usefulness of Statement Modifiers.
Even reading the examples in perlsyn.pod:

    print "Basset hounds got long ears" if length $ear >= 10;
    go_outside() and play() unless $is_raining;

seeing "do these things" upfront and then realize "ah, but that
is done only when this holds true", interrupts the flow of
understanding while reading a program by somebody else [*1*].
It is worse if the Statement Modifier is a loop control.

(flamebait) Compound Statements take BLOCK and people who want
to do a one-liner could not do so without braces.  I've always
thought Statement Modifies as a lame workaround for that
problem.

[Footnote]

*1* This is true even for me; my mother language is Japanese,
which tends to hang negation at the tail of the sentence, and
double negation is not unusual.  This makes it impossible to
know what a sentence states before reading it to the end, so I
am used to that "coming back to the main part after reading
through the sentence", but I do not welcome that when I am
reading programs.
