From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: VCS comparison table
Date: Fri, 20 Oct 2006 11:33:23 -0400
Message-ID: <20061020153323.GA12886@fieldses.org>
References: <45357411.20500@utoronto.ca> <200610180246.18758.jnareb@gmail.com> <45357CC3.4040507@utoronto.ca> <Pine.LNX.4.64.0610172014250.3962@g5.osdl.org> <4536EC93.9050305@utoronto.ca> <87lkncev90.wl%cworth@cworth.org> <453792A8.1010700@utoronto.ca> <8764eg2qaa.wl%cworth@cworth.org> <20061019171409.GA31671@fieldses.org> <20061020143111.GB17497@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Carl Worth <cworth@cworth.org>,
	Aaron Bentley <aaron.bentley@utoronto.ca>,
	Linus Torvalds <torvalds@osdl.org>,
	Jakub Narebski <jnareb@gmail.com>,
	Andreas Ericsson <ae@op5.se>, bazaar-ng@lists.canonical.com,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 20 17:34:21 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GawO5-0003hK-1d
	for gcvg-git@gmane.org; Fri, 20 Oct 2006 17:34:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946265AbWJTPdc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Oct 2006 11:33:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946374AbWJTPdc
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Oct 2006 11:33:32 -0400
Received: from mail.fieldses.org ([66.93.2.214]:47818 "EHLO
	pickle.fieldses.org") by vger.kernel.org with ESMTP
	id S1946265AbWJTPdb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Oct 2006 11:33:31 -0400
Received: from bfields by pickle.fieldses.org with local (Exim 4.63)
	(envelope-from <bfields@fieldses.org>)
	id 1GawN9-0003vq-7u; Fri, 20 Oct 2006 11:33:23 -0400
To: Jeff King <peff@peff.net>
Content-Disposition: inline
In-Reply-To: <20061020143111.GB17497@coredump.intra.peff.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29489>

On Fri, Oct 20, 2006 at 10:31:11AM -0400, Jeff King wrote:
> On Thu, Oct 19, 2006 at 01:14:09PM -0400, J. Bruce Fields wrote:
> > So in this case you can certainly lose the launch codes.  But you have
> > forever granted everyone a way to determine whether a given guess at the
> > launch codes is correct.  (Again, assuming some stuff about SHA1).
> 
> In what sense? Yes, you can make a guess if you have stored the SHA1
> that contained the launch codes. But the point is that that particular
> SHA1 is no longer part of the repository.

Well, I thought the discussion was about what meaning references have
after branches were modified or removed.  In which case the interesting
situation is one where an object is gone but someone somewhere still
holds a reference (because the SHA1 was mentioned in a bug report or an
email or whatever).

> Keeping that SHA1 is no easier than just keeping the launch codes in
> the first place.

Could be.

Anyway, the important difference between the SHA1 references and small
integers is that there's no aliasing in the former case.  Which is
important--I'd rather have a reference to nothing than a reference to
the wrong thing....

--b.
