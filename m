From: Thien-Thi Nguyen <ttn@gnuvola.org>
Subject: Re: git-cherries
Date: Fri, 02 Mar 2012 12:19:42 +0100
Message-ID: <87ehtb8d2p.fsf@gnuvola.org>
References: <874nucee98.fsf@gnuvola.org>
	<20120227192746.GC1600@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Mar 02 12:20:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S3QXh-0004HT-Ik
	for gcvg-git-2@plane.gmane.org; Fri, 02 Mar 2012 12:20:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932323Ab2CBLUx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Mar 2012 06:20:53 -0500
Received: from smtp207.alice.it ([82.57.200.103]:45531 "EHLO smtp207.alice.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932308Ab2CBLUw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Mar 2012 06:20:52 -0500
Received: from ambire (79.51.120.27) by smtp207.alice.it (8.6.023.02)
        id 4F05A66506C1CB5A; Fri, 2 Mar 2012 12:20:45 +0100
Received: from ttn by ambire with local (Exim 4.72)
	(envelope-from <ttn@gnuvola.org>)
	id 1S3QWU-0001Mh-7D; Fri, 02 Mar 2012 12:19:42 +0100
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.92 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192029>

() Jeff King <peff@peff.net>
() Mon, 27 Feb 2012 14:27:46 -0500

   So if I understand correctly, this just creates a series of commits, one
   per hunk, of what's in your working tree. And the commit messages won't
   be useful, so this is really about recording the work somewhere so that
   you can pick it out later using "git cherry-pick --no-commit", make a
   real commit from some subset of the cherries, and then throw away the
   cherries?

   I think you could do this more simply by putting everything in a single
   throw-away commit, then using "git checkout -p $throwaway" to pick the
   individual cherries from the single commit. You don't grab the commit
   message from $throwaway as you might with cherry-pick, but by definition
   it's not a very good commit message anyway.

Cool; "git checkout -p" was what i was missing.  Thanks for the tip!
