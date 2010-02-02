From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: master^ is not a local branch -- huh?!?
Date: Tue, 2 Feb 2010 14:19:42 -0500
Message-ID: <20100202191942.GB9628@fieldses.org>
References: <31a97741002010352x1ad27f26ia4d51857bb2d2d4f@mail.gmail.com> <7vpr4o3lg9.fsf@alter.siamese.dyndns.org> <87aavsu9b3.fsf@osv.gnss.ru> <ron1-6F8B85.14520801022010@news.gmane.org> <7vwrywplxz.fsf@alter.siamese.dyndns.org> <ron1-ABA66E.15563101022010@news.gmane.org> <20100202001530.GL9553@machine.or.cz> <ron1-9A9CEA.16452601022010@news.gmane.org> <7vk4uwmp95.fsf@alter.siamese.dyndns.org> <ron1-1E906F.17124201022010@news.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ron Garret <ron1@flownet.com>
X-From: git-owner@vger.kernel.org Tue Feb 02 20:19:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NcOHx-00021F-Nb
	for gcvg-git-2@lo.gmane.org; Tue, 02 Feb 2010 20:19:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756988Ab0BBTTe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Feb 2010 14:19:34 -0500
Received: from fieldses.org ([174.143.236.118]:36962 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756946Ab0BBTTd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Feb 2010 14:19:33 -0500
Received: from bfields by fieldses.org with local (Exim 4.69)
	(envelope-from <bfields@fieldses.org>)
	id 1NcOHm-0002mG-BE; Tue, 02 Feb 2010 14:19:42 -0500
Content-Disposition: inline
In-Reply-To: <ron1-1E906F.17124201022010@news.gmane.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138739>

On Mon, Feb 01, 2010 at 05:12:42PM -0800, Ron Garret wrote:
> In article <7vk4uwmp95.fsf@alter.siamese.dyndns.org>,
>  Junio C Hamano <gitster@pobox.com> wrote:
> 
> > Ron Garret <ron1@flownet.com> writes:
> > 
> > > The manual specifically contradicts you, so either you are wrong or the 
> > > manual is wrong.
> > 
> > In case you haven't noticed, Pasky is one of the old timers and he knows a
> > thing or two about the git's world model.
> 
> My intent was not to diss Pasky, it was just to point out a disconnect 
> between what he was saying and what the manual says.  It's quite 
> possible that the manual is wrong or out of date or just misleading.  
> But it says what it says.
> 
> > And I do not see a contradiction in what the manual describes and "a
> > branch is a named pointer to a commit" (although "named" can probably be
> > omitted as "unnamed pointer" is not useful at the UI level).
> 
> But that's not what the manual says.  The manual says, "When we need to 
> be precise, we will use the word "branch" to mean a line of 
> development..."  Those are the first words in the section entitled 
> "Understanding history: What is a branch?"  It certainly appears to the 
> untrained eye that that is intended to be the definition of a branch.

My memory is that I'd seen the word "branch" used for both meanings (a
linear piece of history, and a ref under ref/heads/), so figured we
needed terms for both.

But then I didn't really use that distinction anywhere.  On a quick skim
the only instance I can see of the first sense is in
http://kernel.org/pub/software/scm/git-core/docs/user-manual.html#counting-commits-on-a-branch,
which could probably be reworded.

It still may be worth acknowledging the confusion; e.g., something like:

	In the above diagram, "A", "B", and "master" are all references
	to a point in history.  We call all three "branches".

	Informally, the word "branch" is sometimes also used to the
	entire line of development leading up to one of these points,
	or, more generally, to any individual line of development.  But
	when speaking about git, a "branch" (or "branch head") will
	always be a reference to a point in history, and in particular a
	reference which may be advanced to new commits by future
	development.

Eh, I don't know if that's helpful; maybe that section could just be
deleted.  Or replaced by a more general discusion of the ref/ namespace.

--b.
