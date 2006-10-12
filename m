From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] git-pickaxe: blame rewritten.
Date: Thu, 12 Oct 2006 15:20:08 -0700
Message-ID: <7vmz81kwh3.fsf@assigned-by-dhcp.cox.net>
References: <7v7iz5rk4b.fsf@assigned-by-dhcp.cox.net>
	<20061012193107.44651.qmail@web31805.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 13 00:35:33 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GY8uZ-0001Wm-DO
	for gcvg-git@gmane.org; Fri, 13 Oct 2006 00:20:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751209AbWJLWUL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 Oct 2006 18:20:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751203AbWJLWUL
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Oct 2006 18:20:11 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:33712 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S1751206AbWJLWUJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Oct 2006 18:20:09 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20061012222008.YXJN13992.fed1rmmtao11.cox.net@fed1rmimpo01.cox.net>;
          Thu, 12 Oct 2006 18:20:08 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id ZaKx1V01H1kojtg0000000
	Thu, 12 Oct 2006 18:19:58 -0400
To: Luben Tuikov <ltuikov@yahoo.com>
In-Reply-To: <20061012193107.44651.qmail@web31805.mail.mud.yahoo.com> (Luben
	Tuikov's message of "Thu, 12 Oct 2006 12:31:07 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28809>

Luben Tuikov <ltuikov@yahoo.com> writes:

> Junio, is it possible to also print the "previous" commit?
> I mean, is it tenable to print the commit such that
> a "git-diff C B -- A:file" will give a diff of the block of lines
> we're looking at?

There is no single "previous" in general.  Which side of the
merge would you take?
