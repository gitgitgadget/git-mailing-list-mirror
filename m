From: Ron Garret <ron1@flownet.com>
Subject: Re: master^ is not a local branch -- huh?!?
Date: Tue, 02 Feb 2010 14:04:22 -0800
Organization: Amalgamated Widgets
Message-ID: <ron1-9204BD.14042202022010@news.gmane.org>
References: <31a97741002010352x1ad27f26ia4d51857bb2d2d4f@mail.gmail.com> <7vpr4o3lg9.fsf@alter.siamese.dyndns.org> <87aavsu9b3.fsf@osv.gnss.ru> <ron1-6F8B85.14520801022010@news.gmane.org> <7vwrywplxz.fsf@alter.siamese.dyndns.org> <ron1-ABA66E.15563101022010@news.gmane.org> <20100202001530.GL9553@machine.or.cz> <ron1-9A9CEA.16452601022010@news.gmane.org> <7vk4uwmp95.fsf@alter.siamese.dyndns.org> <ron1-1E906F.17124201022010@news.gmane.org> <20100202191942.GB9628@fieldses.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 02 23:05:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NcQsD-0007ja-4U
	for gcvg-git-2@lo.gmane.org; Tue, 02 Feb 2010 23:05:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756859Ab0BBWFT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Feb 2010 17:05:19 -0500
Received: from lo.gmane.org ([80.91.229.12]:43706 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756007Ab0BBWFR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Feb 2010 17:05:17 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1NcQry-0007Zl-P6
	for git@vger.kernel.org; Tue, 02 Feb 2010 23:05:14 +0100
Received: from 68-190-211-184.dhcp.gldl.ca.charter.com ([68.190.211.184])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 02 Feb 2010 23:05:14 +0100
Received: from ron1 by 68-190-211-184.dhcp.gldl.ca.charter.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 02 Feb 2010 23:05:14 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 68-190-211-184.dhcp.gldl.ca.charter.com
User-Agent: MT-NewsWatcher/3.5.1 (Intel Mac OS X)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138768>

In article <20100202191942.GB9628@fieldses.org>,
 "J. Bruce Fields" <bfields@fieldses.org> wrote:

> On Mon, Feb 01, 2010 at 05:12:42PM -0800, Ron Garret wrote:
> > In article <7vk4uwmp95.fsf@alter.siamese.dyndns.org>,
> >  Junio C Hamano <gitster@pobox.com> wrote:
> > 
> > > Ron Garret <ron1@flownet.com> writes:
> > > 
> > > > The manual specifically contradicts you, so either you are wrong or the 
> > > > manual is wrong.
> > > 
> > > In case you haven't noticed, Pasky is one of the old timers and he knows 
> > > a
> > > thing or two about the git's world model.
> > 
> > My intent was not to diss Pasky, it was just to point out a disconnect 
> > between what he was saying and what the manual says.  It's quite 
> > possible that the manual is wrong or out of date or just misleading.  
> > But it says what it says.
> > 
> > > And I do not see a contradiction in what the manual describes and "a
> > > branch is a named pointer to a commit" (although "named" can probably be
> > > omitted as "unnamed pointer" is not useful at the UI level).
> > 
> > But that's not what the manual says.  The manual says, "When we need to 
> > be precise, we will use the word "branch" to mean a line of 
> > development..."  Those are the first words in the section entitled 
> > "Understanding history: What is a branch?"  It certainly appears to the 
> > untrained eye that that is intended to be the definition of a branch.
> 
> My memory is that I'd seen the word "branch" used for both meanings (a
> linear piece of history, and a ref under ref/heads/), so figured we
> needed terms for both.
> 
> But then I didn't really use that distinction anywhere.  On a quick skim
> the only instance I can see of the first sense is in
> http://kernel.org/pub/software/scm/git-core/docs/user-manual.html#counting-com
> mits-on-a-branch,
> which could probably be reworded.
> 
> It still may be worth acknowledging the confusion; e.g., something like:
> 
> 	In the above diagram, "A", "B", and "master" are all references
> 	to a point in history.  We call all three "branches".
> 
> 	Informally, the word "branch" is sometimes also used to the
> 	entire line of development leading up to one of these points,
> 	or, more generally, to any individual line of development.  But
> 	when speaking about git, a "branch" (or "branch head") will
> 	always be a reference to a point in history, and in particular a
> 	reference which may be advanced to new commits by future
> 	development.
> 
> Eh, I don't know if that's helpful; maybe that section could just be
> deleted.  Or replaced by a more general discusion of the ref/ namespace.

FWIW, I find the above verbiage to to be very clear, much better than 
what is there now.  You might also add that branches are almost exactly 
the same as tags.  The only difference (AFAIK) is that tags get dragged 
along by commits and resets and tags don't.

rg
