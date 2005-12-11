From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 0/25] Usage message clean-up
Date: Sat, 10 Dec 2005 18:58:44 -0800
Message-ID: <7vbqzouyor.fsf@assigned-by-dhcp.cox.net>
References: <1134243476675-git-send-email-freku045@student.liu.se>
	<Pine.LNX.4.63.0512102349040.3083@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 11 03:59:57 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ElHQL-0006Ny-5E
	for gcvg-git@gmane.org; Sun, 11 Dec 2005 03:58:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932621AbVLKC6s (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 10 Dec 2005 21:58:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932682AbVLKC6s
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Dec 2005 21:58:48 -0500
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:13563 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S932621AbVLKC6s (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Dec 2005 21:58:48 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051211025655.EYME20050.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 10 Dec 2005 21:56:55 -0500
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13480>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> * -h and --help makes the script die with the usage message.
>
> Good.

Supporting -h and --help are good, but we probably do not want
to exit with non-zero status in such a case.  Not a big deal,
though.

>> * The message is printed to stderr.
>
> Arguable.

One thing I really hate is a program that does more than one
pageful of help message to stderr which forces me to do "blah
>&2 --help | less", but our help messages are short and sweet,
so I feel stderr is OK.

>> * The message is of the form "usage: $0 options"
>
> Not good. We are in a transition to "git whatever" from "git-whatever".

But when the user wishes to look at the manual page, he needs to
say "man git-whatever", so either way you cannot win.  I'm
neutral either way, as long as we are consistent.

> Besides, I have to admit that I am a bit annoyed by 25 mini mails for the 
> same purpose.

I'd appreciate the flexibility of reviewing them indivudually,
especially when some of them seem to change the structure of the
argument parsing loop.
