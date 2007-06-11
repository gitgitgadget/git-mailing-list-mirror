From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Problem with a push
Date: Mon, 11 Jun 2007 16:49:35 -0700
Message-ID: <7vhcpenjao.fsf@assigned-by-dhcp.pobox.com>
References: <Pine.LNX.4.64.0706111632050.4406@www.mintpixels.com>
	<alpine.LFD.0.98.0706111556160.14121@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: plexq@plexq.com, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Jun 12 01:49:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hxtdo-0004fR-Ge
	for gcvg-git@gmane.org; Tue, 12 Jun 2007 01:49:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753030AbXFKXth (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 11 Jun 2007 19:49:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753288AbXFKXth
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Jun 2007 19:49:37 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:58293 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753030AbXFKXtg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jun 2007 19:49:36 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070611234935.RJDO3133.fed1rmmtao102.cox.net@fed1rmimpo01.cox.net>;
          Mon, 11 Jun 2007 19:49:35 -0400
Received: from assigned-by-dhcp.pobox.com ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id APpb1X0061kojtg0000000; Mon, 11 Jun 2007 19:49:35 -0400
In-Reply-To: <alpine.LFD.0.98.0706111556160.14121@woody.linux-foundation.org>
	(Linus Torvalds's message of "Mon, 11 Jun 2007 16:03:53 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49902>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> What was the command line?  In particular, was this a "git push --all" or 
> something? I think we should make sure that we do *not* push remotes by 
> default (and if you really *really* want to push remotes, you'd have to 
> specify them explicitly).

I suspect that people (probably rightfully) just say "git push"
without saying anything else, and the so-useful-for-old-timers
default "matching refs" behaviour bites them when they do so.

If you create a non-bare clone, clone from that, and then try to
push from the second generation clone to the first generation
non-bare clone, surely there will be "matching" remotes/origin/,
except that they are not really matching X-<.
