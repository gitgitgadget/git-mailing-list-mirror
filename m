From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-mergetool: add support for ediff
Date: Sun, 01 Jul 2007 19:32:59 -0700
Message-ID: <7v1wfr1qn8.fsf@assigned-by-dhcp.cox.net>
References: <11830788163411-git-send-email-sam.vilain@catalyst.net.nz>
	<31e9dd080706281831vbe24597i9b6a5f6f6db6fec8@mail.gmail.com>
	<20070629040328.GG29279@thunk.org> <20070702020401.GD28917@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jason Sewall <jasonsewall@gmail.com>,
	Sam Vilain <sam.vilain@catalyst.net.nz>, git@vger.kernel.org
To: Theodore Tso <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Mon Jul 02 04:33:08 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I5Bit-0004eb-In
	for gcvg-git@gmane.org; Mon, 02 Jul 2007 04:33:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756327AbXGBCdE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 1 Jul 2007 22:33:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755940AbXGBCdD
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Jul 2007 22:33:03 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:43319 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756225AbXGBCdB (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Jul 2007 22:33:01 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070702023300.BEGL6565.fed1rmmtao105.cox.net@fed1rmimpo01.cox.net>;
          Sun, 1 Jul 2007 22:33:00 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id JSYz1X00F1kojtg0000000; Sun, 01 Jul 2007 22:33:00 -0400
In-Reply-To: <20070702020401.GD28917@thunk.org> (Theodore Tso's message of
	"Sun, 1 Jul 2007 22:04:01 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51336>

Theodore Tso <tytso@mit.edu> writes:

> Unfortunately, it's not enough.  Ediff doesn't have an "abort" command
> which returns a non-zero exit status, and when you use the "quit"
> command, it asks you a series of obnoxious questions:
>
> ...
> Alternatively, we could patch around the problem.  The following emacs
> lisp code fixes the ediff issues:

But that would be changing the behaviour globally, and not
limited to the particular session invoked from git-mergetool,
wouldn't it?  If that is the case it would be a hard sell to
Emacs users, especially the ones that keep their Emacs running
forever and have emacsclient as their EDITOR, I would think.
