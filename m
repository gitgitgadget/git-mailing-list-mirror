From: Paul Eggert <eggert@CS.UCLA.EDU>
Subject: Re: being nice to patch(1)
Date: Tue, 03 Jul 2007 13:55:02 -0700
Message-ID: <87zm2dxl5l.fsf@penguin.cs.ucla.edu>
References: <20070702125450.28228edd.akpm@linux-foundation.org>
	<alpine.LFD.0.98.0707021409510.9434@woody.linux-foundation.org>
	<20070702142557.eba61ccd.akpm@linux-foundation.org>
	<alpine.LFD.0.98.0707021436300.9434@woody.linux-foundation.org>
	<20070702145601.a0dcef0f.akpm@linux-foundation.org>
	<alpine.LFD.0.98.0707021713200.9434@woody.linux-foundation.org>
	<7vhcomuofl.fsf@assigned-by-dhcp.cox.net>
	<alpine.LFD.0.98.0707022114000.9434@woody.linux-foundation.org>
	<Pine.LNX.4.64.0707031303130.4071@racer.site>
	<4d8e3fd30707030521k6cb3129dy9193344e9e1eccf7@mail.gmail.com>
	<20070703183947.GE5322@thunk.org>
	<alpine.LFD.0.98.0707031159580.9434@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Theodore Tso <tytso@mit.edu>,
	Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>, quilt-dev@nongnu.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Jul 03 23:10:25 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I5pdg-0006ny-7d
	for gcvg-git@gmane.org; Tue, 03 Jul 2007 23:10:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754251AbXGCVKP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 Jul 2007 17:10:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754042AbXGCVKO
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Jul 2007 17:10:14 -0400
Received: from Kiwi.CS.UCLA.EDU ([131.179.128.19]:62074 "EHLO kiwi.cs.ucla.edu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752974AbXGCVKM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jul 2007 17:10:12 -0400
X-Greylist: delayed 893 seconds by postgrey-1.27 at vger.kernel.org; Tue, 03 Jul 2007 17:10:12 EDT
Received: from penguin.cs.ucla.edu (Penguin.CS.UCLA.EDU [131.179.64.200])
	by kiwi.cs.ucla.edu (8.13.8+Sun/8.13.8/UCLACS-6.0) with ESMTP id l63Kt2rQ000320;
	Tue, 3 Jul 2007 13:55:02 -0700 (PDT)
Received: from eggert by penguin.cs.ucla.edu with local (Exim 4.63)
	(envelope-from <eggert@cs.ucla.edu>)
	id 1I5pOo-0006Ni-Gk; Tue, 03 Jul 2007 13:55:02 -0700
In-Reply-To: <alpine.LFD.0.98.0707031159580.9434@woody.linux-foundation.org>
	(Linus Torvalds's message of "Tue, 3 Jul 2007 12:48:31 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51534>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> Anyway, I tried to look at the patch sources, but I had to stop. That 
> whole "intuit_diff_type()" function is probably designed as an initiation 
> rite for any patch programmers, and to make sure that you have to be 
> really serious about wanting to send patches before you can become part of 
> the "in crowd". It's "mental hazing".

You should have seen it in the good old days when Larry Wall wrote it.
It was at least -- at least! -- 10% worse.

> In this case, the improvement would be to simply ignore indented patches 
> (preferably by default, but at least have the option to do so).

I agree.  POSIX has tied our hands to some extent, though, since it
_requires_ patch to accept indented patches by default.  It's too late
to fix this in the current POSIX go-round, but we can fix it in the
next.  And in the mean time we can add an option, I suppose defaulting
to not stripping indentation unless POSIXLY_CORRECT is set.  That
would be fine with me.

I'll add it to my list of things to do.
