From: Ron Garret <ron1@flownet.com>
Subject: Re: master^ is not a local branch -- huh?!?
Date: Mon, 01 Feb 2010 21:23:12 -0800
Organization: Amalgamated Widgets
Message-ID: <ron1-0A5B25.21231201022010@news.gmane.org>
References: <31a97741002010352x1ad27f26ia4d51857bb2d2d4f@mail.gmail.com> <7vpr4o3lg9.fsf@alter.siamese.dyndns.org> <87aavsu9b3.fsf@osv.gnss.ru> <ron1-6F8B85.14520801022010@news.gmane.org> <7vwrywplxz.fsf@alter.siamese.dyndns.org> <ron1-ABA66E.15563101022010@news.gmane.org> <20100202001530.GL9553@machine.or.cz> <ron1-9A9CEA.16452601022010@news.gmane.org> <alpine.LFD.2.00.1002012253260.1681@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 02 06:23:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NcBEm-0004vt-QL
	for gcvg-git-2@lo.gmane.org; Tue, 02 Feb 2010 06:23:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751176Ab0BBFXg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Feb 2010 00:23:36 -0500
Received: from lo.gmane.org ([80.91.229.12]:49895 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750761Ab0BBFXf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Feb 2010 00:23:35 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1NcBEb-0004re-8T
	for git@vger.kernel.org; Tue, 02 Feb 2010 06:23:33 +0100
Received: from 68-190-211-184.dhcp.gldl.ca.charter.com ([68.190.211.184])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 02 Feb 2010 06:23:33 +0100
Received: from ron1 by 68-190-211-184.dhcp.gldl.ca.charter.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 02 Feb 2010 06:23:33 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 68-190-211-184.dhcp.gldl.ca.charter.com
User-Agent: MT-NewsWatcher/3.5.1 (Intel Mac OS X)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138678>

In article <alpine.LFD.2.00.1002012253260.1681@xanadu.home>,
 Nicolas Pitre <nico@fluxnic.net> wrote:

> On Mon, 1 Feb 2010, Ron Garret wrote:
> 
> > In article <20100202001530.GL9553@machine.or.cz>,
> >  Petr Baudis <pasky@suse.cz> wrote:
> > 
> > > On Mon, Feb 01, 2010 at 03:56:31PM -0800, Ron Garret wrote:
> > > > In article <7vwrywplxz.fsf@alter.siamese.dyndns.org>,
> > > >  Junio C Hamano <gitster@pobox.com> wrote:
> > > > > Ron Garret <ron1@flownet.com> writes:
> > > > > > And as long as I'm weighing in, it would also help to prevent 
> > > > > > confusion 
> > > > > > if it were made clear that this unnamed branch doesn't actually 
> > > > > > come 
> > > > > > into existence unless and until you do a commit.
> > > > > 
> > > > > This shows that you are still thinking a branch is a line (or 
> > > > > multiple
> > > > > lines).  It is not.
> > > > 
> > > > The git user's guide says it is:
> > > > 
> > > > "When we need to be precise, we will use the word "branch" to mean a 
> > > > line of development..."
> > > > 
> > > > But I understand that a branch is not necessarily a line.  In general 
> > > > it's a DAG.  I get that.
> > > 
> > > Again, no. In the most narrow sense, "branch == branch head".
> > 
> > The manual specifically contradicts you, so either you are wrong or the 
> > manual is wrong.
> 
> In that case it's most probably the manual which is wrong.

OK.  That happens.

> > Don't forget that what is at issue here is not how git works (I'm pretty 
> > sure everyone is on the same page about that) but how to explain it to 
> > someone who is not already familiar with it.  So it's important to use 
> > terminology that is consistent with what the manual says.
> 
> Or rather that the manual has to be debugged and be brought in sync with 
> reality.

Sure.  I'm agnostic about how this synchronization happens.  But I think 
it's important that it happen, otherwise a lot of people will remain 
confused, and that would be a shame.

> All the people who had their hands dirty with the code usually 
> hang here, and what they say has precedence with whatever is in the 
> manual.

Yes, but what they say still ought to pass some basic tests of utility.  
For example, a definition of "branch" that makes it effectively 
synonymous with "commit" is probably not useful.

> It is good of course that you bring those issues to our attention.  but 
> it is more likely that the manual needs fixing than anything else.

That's fine.  My only aim here is to raise the issue.

By the way, if you (plural) think it would be helpful I'd be happy to 
take a stab at rewriting this part of the manual.  Writing docs is a 
drag, but it would probably be a useful exercise for me.

rg
