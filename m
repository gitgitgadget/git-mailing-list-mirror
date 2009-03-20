From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: How to commit changes if remote repository changed directory
	structure?
Date: Fri, 20 Mar 2009 18:30:05 -0400
Message-ID: <20090320223005.GA25057@fieldses.org>
References: <22612715.post@talk.nabble.com> <20090320060926.GC27008@coredump.intra.peff.net> <7vljr04qnw.fsf@gitster.siamese.dyndns.org> <20090320071319.GF27008@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, andholt <andholt@gmail.com>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Mar 20 23:31:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LknFd-00072m-8L
	for gcvg-git-2@gmane.org; Fri, 20 Mar 2009 23:31:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753422AbZCTWaN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Mar 2009 18:30:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752988AbZCTWaM
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Mar 2009 18:30:12 -0400
Received: from mail.fieldses.org ([141.211.133.115]:56135 "EHLO
	pickle.fieldses.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751704AbZCTWaL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Mar 2009 18:30:11 -0400
Received: from bfields by pickle.fieldses.org with local (Exim 4.69)
	(envelope-from <bfields@fieldses.org>)
	id 1LknE5-0006Yg-4y; Fri, 20 Mar 2009 18:30:05 -0400
Content-Disposition: inline
In-Reply-To: <20090320071319.GF27008@coredump.intra.peff.net>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114012>

On Fri, Mar 20, 2009 at 03:13:19AM -0400, Jeff King wrote:
> On Fri, Mar 20, 2009 at 12:08:51AM -0700, Junio C Hamano wrote:
> 
> > > First, commit your changes. Then merge the other developer's changes. :)
> > 
> > We should probably point out to new people that "first commit and then
> > worry about merges after your changes are safely committed" is always how
> > people would "go about" anything.
> 
> Yes, absolutely.
> 
> Most of the current documentation focuses on being a reference to
> particular commands or tasks. But this is more of a "philosophy of
> working with git" item. I guess it should go in the user manual
> somewhere. Cc'ing Bruce, who may have some comments.

I agree, that's kind of an odd hold in the user manual.  Maybe it goes
without saying, but it might be useful somewhere in ch. 3, maybe when
introducing commits, something along the lines of: "note all of these
commits are stored only in your local repository, and are visible only
to you.  With some version control systems, "committing" requires
sending the commit to a central server.  With git, you are expected to
do all your work locally and only merge with others' work when
necessary; we'll learn how to do that in <chapter 4>."

And then say something similar again at the start of chapter 4?

--b.
