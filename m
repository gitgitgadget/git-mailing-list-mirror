From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-mergetool: add support for ediff
Date: Sun, 01 Jul 2007 21:49:10 -0700
Message-ID: <7vr6nrz9yx.fsf@assigned-by-dhcp.cox.net>
References: <11830788163411-git-send-email-sam.vilain@catalyst.net.nz>
	<31e9dd080706281831vbe24597i9b6a5f6f6db6fec8@mail.gmail.com>
	<20070629040328.GG29279@thunk.org> <20070702020401.GD28917@thunk.org>
	<7v1wfr1qn8.fsf@assigned-by-dhcp.cox.net>
	<20070702030521.GA4798@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jason Sewall <jasonsewall@gmail.com>,
	Sam Vilain <sam.vilain@catalyst.net.nz>, git@vger.kernel.org
To: Theodore Tso <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Mon Jul 02 06:49:26 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I5Dqo-0002IJ-6y
	for gcvg-git@gmane.org; Mon, 02 Jul 2007 06:49:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752362AbXGBEtO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 2 Jul 2007 00:49:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752390AbXGBEtN
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Jul 2007 00:49:13 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:49757 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752362AbXGBEtM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jul 2007 00:49:12 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070702044912.TBYH22777.fed1rmmtao107.cox.net@fed1rmimpo01.cox.net>;
          Mon, 2 Jul 2007 00:49:12 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id JUpA1X0021kojtg0000000; Mon, 02 Jul 2007 00:49:10 -0400
In-Reply-To: <20070702030521.GA4798@thunk.org> (Theodore Tso's message of
	"Sun, 1 Jul 2007 23:05:21 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51343>

Theodore Tso <tytso@mit.edu> writes:

> One thing that did cross my mind is that we could put code which
> patched ediff.el and emerge.el in /usr/share/git/lisp/... and then
> passed called emacs with something like this "emacs -l
> $sharedir/lisp/ediff-patches.el ...".  But this implies packaging
> emacs lisp files with git, and I'm not at ALL sure we want to go
> there. ...

I hope not.

> ...  Personally, I still like kdiff3 as my personal favorite
> mergetool, and given that emacs starts up pretty fast these days, I've
> given up on emacsclient, but I know there are certainly people who use
> them.

The reason I personally use emacsclient is not about the
start-up delay, but with the access to existing buffers,
keyboard macros, Gnus buffers, ... IOW the access to the
"session" while editing.  I suspect people with long running
Emacs session use emacsclient for that reason.
