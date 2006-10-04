From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] gitweb: make leftmost column of blame less cluttered.
Date: Tue, 03 Oct 2006 19:26:05 -0700
Message-ID: <7virj0lsua.fsf@assigned-by-dhcp.cox.net>
References: <20061003192018.GR2871@admingilde.org>
	<20061003194551.70537.qmail@web31809.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Martin Waitz <tali@admingilde.org>
X-From: git-owner@vger.kernel.org Wed Oct 04 04:27:03 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GUwTE-0006zv-RD
	for gcvg-git@gmane.org; Wed, 04 Oct 2006 04:26:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030719AbWJDC0J (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 Oct 2006 22:26:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030724AbWJDC0J
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Oct 2006 22:26:09 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:48590 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S1030719AbWJDC0G (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Oct 2006 22:26:06 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20061004022606.JPMX26416.fed1rmmtao12.cox.net@fed1rmimpo01.cox.net>;
          Tue, 3 Oct 2006 22:26:06 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id W2Rz1V00f1kojtg0000000
	Tue, 03 Oct 2006 22:26:00 -0400
To: ltuikov@yahoo.com
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28312>

Luben Tuikov <ltuikov@yahoo.com> writes:

>> Then you don't need to worry about repeating the commit id,
>> and perhaps it is not even needed any more?

I am contradicting myself but I personally like what Pasky runs
at http://repo.or.cz/ too, although it goes to the other extreme
to spend more space for line-by-line annotation ;-)

> I like Junio's first patch on the subject with the only
> objection that the "chunk" can be 100s of 1000s of lines
> if the file is too big and there had never been any changes
> since the initial commit.
>
> I like the fact that the "data part" of blame is text, and
> that the commit-8 is on the left, and color-chunked.  Sometimes
> people simply _remember_ a number of commit-8's and thus the
> layout of blame is intentional, since they can look to the left
> and recognize a commit-8...

It is not only the initial commit.  A substantial rewrite and
new development also has the same issue.

I think you are also contradicting yourself by saying that
people would recognize a commit-8, and at the same time you do
not like the chunk code that makes sure you do not get too few
of them.  If people _do_ recognize commit-8 (I seriously doubt
that), then wouldn't it help to make sure you have them on every
couple-dozen lines so that the user would see the familiar one
even when scrolled?
