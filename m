From: Junio C Hamano <gitster@pobox.com>
Subject: Re: being nice to patch(1)
Date: Mon, 02 Jul 2007 21:00:14 -0700
Message-ID: <7vhcomuofl.fsf@assigned-by-dhcp.cox.net>
References: <20070702125450.28228edd.akpm@linux-foundation.org>
	<alpine.LFD.0.98.0707021409510.9434@woody.linux-foundation.org>
	<20070702142557.eba61ccd.akpm@linux-foundation.org>
	<alpine.LFD.0.98.0707021436300.9434@woody.linux-foundation.org>
	<20070702145601.a0dcef0f.akpm@linux-foundation.org>
	<alpine.LFD.0.98.0707021713200.9434@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andrew Morton <akpm@linux-foundation.org>, git@vger.kernel.org,
	quilt-dev@nongnu.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Jul 03 06:00:22 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I5ZYr-0004Xo-0m
	for gcvg-git@gmane.org; Tue, 03 Jul 2007 06:00:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750710AbXGCEAS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 Jul 2007 00:00:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750700AbXGCEAS
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Jul 2007 00:00:18 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:47208 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750698AbXGCEAQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jul 2007 00:00:16 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070703040014.UJU1257.fed1rmmtao104.cox.net@fed1rmimpo01.cox.net>;
          Tue, 3 Jul 2007 00:00:14 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id Js0E1X00C1kojtg0000000; Tue, 03 Jul 2007 00:00:15 -0400
In-Reply-To: <alpine.LFD.0.98.0707021713200.9434@woody.linux-foundation.org>
	(Linus Torvalds's message of "Mon, 2 Jul 2007 17:28:41 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51448>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> So I would suggest that in quilt and other systems, you either:
>
>  - strip all headers manually
>
>  - forget about "patch", and use "git-apply" instead that does things 
>    right and doesn't screw up like this (and can do rename diffs etc too).
>
> I guess the second choice generally isn't an option, but dammit, 
> "git-apply" really is the better program here.

Why not?  git-apply works outside of a git repo ;-)
