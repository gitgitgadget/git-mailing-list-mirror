From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: master^ is not a local branch -- huh?!?
Date: Wed, 3 Feb 2010 13:27:34 -0500
Message-ID: <20100203182734.GA12551@fieldses.org>
References: <87aavsu9b3.fsf@osv.gnss.ru> <ron1-6F8B85.14520801022010@news.gmane.org> <7vwrywplxz.fsf@alter.siamese.dyndns.org> <ron1-ABA66E.15563101022010@news.gmane.org> <20100202001530.GL9553@machine.or.cz> <ron1-9A9CEA.16452601022010@news.gmane.org> <7vk4uwmp95.fsf@alter.siamese.dyndns.org> <ron1-1E906F.17124201022010@news.gmane.org> <20100202191942.GB9628@fieldses.org> <ron1-9204BD.14042202022010@news.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ron Garret <ron1@flownet.com>
X-From: git-owner@vger.kernel.org Wed Feb 03 19:27:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ncjwy-0006Dg-6k
	for gcvg-git-2@lo.gmane.org; Wed, 03 Feb 2010 19:27:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756619Ab0BCS1Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Feb 2010 13:27:24 -0500
Received: from fieldses.org ([174.143.236.118]:41364 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756191Ab0BCS1X (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Feb 2010 13:27:23 -0500
Received: from bfields by fieldses.org with local (Exim 4.69)
	(envelope-from <bfields@fieldses.org>)
	id 1Ncjws-0003LY-Pi; Wed, 03 Feb 2010 13:27:34 -0500
Content-Disposition: inline
In-Reply-To: <ron1-9204BD.14042202022010@news.gmane.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138857>

On Tue, Feb 02, 2010 at 02:04:22PM -0800, Ron Garret wrote:
> In article <20100202191942.GB9628@fieldses.org>,
>  "J. Bruce Fields" <bfields@fieldses.org> wrote:
> 
> > My memory is that I'd seen the word "branch" used for both meanings (a
> > linear piece of history, and a ref under ref/heads/), so figured we
> > needed terms for both.
> > 
> > But then I didn't really use that distinction anywhere.  On a quick skim
> > the only instance I can see of the first sense is in
> > http://kernel.org/pub/software/scm/git-core/docs/user-manual.html#counting-com
> > mits-on-a-branch,
> > which could probably be reworded.
> > 
> > It still may be worth acknowledging the confusion; e.g., something like:
> > 
> > 	In the above diagram, "A", "B", and "master" are all references
> > 	to a point in history.  We call all three "branches".
> > 
> > 	Informally, the word "branch" is sometimes also used to the
> > 	entire line of development leading up to one of these points,
> > 	or, more generally, to any individual line of development.  But
> > 	when speaking about git, a "branch" (or "branch head") will
> > 	always be a reference to a point in history, and in particular a
> > 	reference which may be advanced to new commits by future
> > 	development.
> > 
> > Eh, I don't know if that's helpful; maybe that section could just be
> > deleted.  Or replaced by a more general discusion of the ref/ namespace.
> 
> FWIW, I find the above verbiage to to be very clear, much better than 
> what is there now.  You might also add that branches are almost exactly 
> the same as tags.  The only difference (AFAIK) is that tags get dragged 
> along by commits and resets and tags don't.

Might also be worth considering whether this:

	http://kernel.org/pub/software/scm/git-core/docs/user-manual.html#how-git-stores-references

or some other general introduction to refs, should be moved to appear
earlier in the manual.

Apologies, though, I can't volunteer for now; if you'd like any of this
to happen, I'd recommend sending Junio patches.  (I'll try to read them
if you cc: me.)

--b.
