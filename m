From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: [RFC] Managing projects - advanced Git tutorial/walkthrough
Date: Sat, 6 May 2006 21:34:56 -0400
Message-ID: <20060507013455.GB5709@fieldses.org>
References: <e3hnjg$k9f$1@sea.gmane.org> <7v64kisyow.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 07 03:35:01 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FcYAn-0005pD-6v
	for gcvg-git@gmane.org; Sun, 07 May 2006 03:35:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932103AbWEGBe6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 6 May 2006 21:34:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751180AbWEGBe6
	(ORCPT <rfc822;git-outgoing>); Sat, 6 May 2006 21:34:58 -0400
Received: from mail.fieldses.org ([66.93.2.214]:25521 "EHLO
	pickle.fieldses.org") by vger.kernel.org with ESMTP
	id S1751176AbWEGBe6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 May 2006 21:34:58 -0400
Received: from bfields by pickle.fieldses.org with local (Exim 4.61)
	(envelope-from <bfields@fieldses.org>)
	id 1FcYAi-0001nA-5j; Sat, 06 May 2006 21:34:56 -0400
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7v64kisyow.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19688>

On Sat, May 06, 2006 at 01:09:03PM -0700, Junio C Hamano wrote:
>  - Understanding git as an end user.  Currently, this is
>    included in the global map git(7) documentation.  It might
>    make sense to separate it out.  This should talk about
>    concepts like blobs/trees/commits/trust/index without going
>    into lowlevel details of the implementation.  The stress
>    should be on what they are for, not operationally but
>    philosophically.  What's currently in README would be
>    suitable for this part, with some additional topics:

Yeah, I actually made a start at a sequel to tutorial.txt, with the goal
that after reading the sequel a user would have encountered the main
concepts necessary to read any of the man pages--mainly the object
database and the index file.  My work so far is in the
"advanced-tutorial" branch of

	git://linux-nfs.org/~bfields/exports/git.git

but it needs some cleaning up.

I was hoping I'd be able to replace some of the README or
core-tutorial.txt in the process, but the latter has a lot of
git-hacker-only detail in it, and the former is a bit more verbose and
has some motivation (explaining why stuff was designed the way it was)
that is nice but maybe not necessary for a minimal tutorial.

--b.
