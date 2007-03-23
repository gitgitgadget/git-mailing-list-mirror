From: Junio C Hamano <junkio@cox.net>
Subject: Re: emacs and git...
Date: Fri, 23 Mar 2007 02:07:06 -0700
Message-ID: <7vtzwcqqf9.fsf@assigned-by-dhcp.cox.net>
References: <38b2ab8a0703220753s67809e87l76ffc57adb725898@mail.gmail.com>
	<86lkhpmftt.fsf@blue.stonehenge.com>
	<38b2ab8a0703230029h7f3faa95u1e2ccb6a9ee4be5e@mail.gmail.com>
	<864poch0xl.fsf@blue.stonehenge.com>
	<38b2ab8a0703230132j64cf0b94x7c210593f3f31387@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Randal L. Schwartz" <merlyn@stonehenge.com>, git@vger.kernel.org
To: "Francis Moreau" <francis.moro@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 23 10:07:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HUfju-00065Y-8Q
	for gcvg-git@gmane.org; Fri, 23 Mar 2007 10:07:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422745AbXCWJHJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 23 Mar 2007 05:07:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422744AbXCWJHJ
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Mar 2007 05:07:09 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:49468 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422747AbXCWJHI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Mar 2007 05:07:08 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070323090707.KIAF22511.fed1rmmtao106.cox.net@fed1rmimpo01.cox.net>;
          Fri, 23 Mar 2007 05:07:07 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id e9761W0051kojtg0000000; Fri, 23 Mar 2007 05:07:07 -0400
In-Reply-To: <38b2ab8a0703230132j64cf0b94x7c210593f3f31387@mail.gmail.com>
	(Francis Moreau's message of "Fri, 23 Mar 2007 09:32:50 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42913>

"Francis Moreau" <francis.moro@gmail.com> writes:

> Can't git make 'cat' the default pager when run on a dumb terminal ?

IIRC, `more` works on a dumb terminal.

But using PAGER=cat is a longstanding and widely used trick
among Emacs old timers, predating the EDITOR=emacsclient, which
is even nicer.  I would highly recommend it.  These two
environment variables make running *everything* in compilation
mode (or shell buffer) so much nicer than otherwise.
