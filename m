From: Pete Wyckoff <pw@padd.com>
Subject: Re: git-p4, RCS keywords
Date: Tue, 12 Jul 2011 17:24:04 -0400
Message-ID: <20110712212404.GA12799@arf.padd.com>
References: <4E1BEEBC.8060909@diamand.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>,
	Michael Horowitz <michael.horowitz@ieee.org>
To: Luke Diamand <luke@diamand.org>
X-From: git-owner@vger.kernel.org Tue Jul 12 23:32:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QgkZZ-0005mc-7M
	for gcvg-git-2@lo.gmane.org; Tue, 12 Jul 2011 23:32:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755648Ab1GLVcs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Jul 2011 17:32:48 -0400
Received: from honk.padd.com ([74.3.171.149]:38199 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755119Ab1GLVcr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jul 2011 17:32:47 -0400
X-Greylist: delayed 519 seconds by postgrey-1.27 at vger.kernel.org; Tue, 12 Jul 2011 17:32:47 EDT
Received: from arf.padd.com (unknown [50.52.168.230])
	by honk.padd.com (Postfix) with ESMTPSA id 983021FA1;
	Tue, 12 Jul 2011 14:24:07 -0700 (PDT)
Received: by arf.padd.com (Postfix, from userid 7770)
	id CFB1E31435; Tue, 12 Jul 2011 17:24:04 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <4E1BEEBC.8060909@diamand.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176983>

luke@diamand.org wrote on Tue, 12 Jul 2011 07:50 +0100:
> A bit of an ancient topic now, I'm afraid, but back in May I was
> attempting to find a way to get git-p4 to cope with RCS keyword
> expansion causing merge conflicts.
> 
> http://marc.info/?l=git&m=130492741320889&w=2
> 
> I've given up trying to make this work.
> 
> I had thought that I had a scheme that could plausibly work. git-p4
> detects when a merge would fail. At this point, look for RCS
> keywords in the file, and strip them out. For an edit that's easy,
> for a deletion it's a bit trickier.
> 
> I then discovered that the third way RCS keywords can cause grief is
> if a user copies a file containing expanded RCS keywords into their
> git repo. My scheme then gave some very weird results!
> 
> Maybe this is now the complete list of ways in which RCS keywords
> can mess you up, but I'm not sure. We've got ~9.5k files in our repo
> with RCS keywords. I think it's easier and safer just to go through
> and turn off ktext everywhere. I've actually only seen two or three
> merge conflicts caused by this problem in this time (not sure how
> many commits that is, but it must be in the hundreds).
> 
> I'm not saying it's not possible, just that my approach isn't going to work.
> 
> Who invented RCS keyword expansion anyway? They need a good talking to!

Yeah!  Thanks for the followup; it was an interesting exercise.
We went through the pain of turning off ktext everywhere
possible.  Watch out because it will keep sneaking back in
depending on how people do their integrates.

		-- Pete
