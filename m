From: Ron Garret <ron1@flownet.com>
Subject: Re: master^ is not a local branch -- huh?!?
Date: Mon, 01 Feb 2010 16:45:26 -0800
Organization: Amalgamated Widgets
Message-ID: <ron1-9A9CEA.16452601022010@news.gmane.org>
References: <31a97741002010352x1ad27f26ia4d51857bb2d2d4f@mail.gmail.com> <7vpr4o3lg9.fsf@alter.siamese.dyndns.org> <87aavsu9b3.fsf@osv.gnss.ru> <ron1-6F8B85.14520801022010@news.gmane.org> <7vwrywplxz.fsf@alter.siamese.dyndns.org> <ron1-ABA66E.15563101022010@news.gmane.org> <20100202001530.GL9553@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 02 01:47:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nc6vM-0005bB-Rs
	for gcvg-git-2@lo.gmane.org; Tue, 02 Feb 2010 01:47:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751265Ab0BBApx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Feb 2010 19:45:53 -0500
Received: from lo.gmane.org ([80.91.229.12]:35179 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750915Ab0BBApw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Feb 2010 19:45:52 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1Nc6tm-0004aJ-5v
	for git@vger.kernel.org; Tue, 02 Feb 2010 01:45:46 +0100
Received: from 68-190-211-184.dhcp.gldl.ca.charter.com ([68.190.211.184])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 02 Feb 2010 01:45:46 +0100
Received: from ron1 by 68-190-211-184.dhcp.gldl.ca.charter.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 02 Feb 2010 01:45:46 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 68-190-211-184.dhcp.gldl.ca.charter.com
User-Agent: MT-NewsWatcher/3.5.1 (Intel Mac OS X)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138666>

In article <20100202001530.GL9553@machine.or.cz>,
 Petr Baudis <pasky@suse.cz> wrote:

> On Mon, Feb 01, 2010 at 03:56:31PM -0800, Ron Garret wrote:
> > In article <7vwrywplxz.fsf@alter.siamese.dyndns.org>,
> >  Junio C Hamano <gitster@pobox.com> wrote:
> > > Ron Garret <ron1@flownet.com> writes:
> > > > And as long as I'm weighing in, it would also help to prevent confusion 
> > > > if it were made clear that this unnamed branch doesn't actually come 
> > > > into existence unless and until you do a commit.
> > > 
> > > This shows that you are still thinking a branch is a line (or multiple
> > > lines).  It is not.
> > 
> > The git user's guide says it is:
> > 
> > "When we need to be precise, we will use the word "branch" to mean a 
> > line of development..."
> > 
> > But I understand that a branch is not necessarily a line.  In general 
> > it's a DAG.  I get that.
> 
> Again, no. In the most narrow sense, "branch == branch head".

The manual specifically contradicts you, so either you are wrong or the 
manual is wrong.

Don't forget that what is at issue here is not how git works (I'm pretty 
sure everyone is on the same page about that) but how to explain it to 
someone who is not already familiar with it.  So it's important to use 
terminology that is consistent with what the manual says.

> Branch is just a pointer.

No, a branch is not "just" a pointer.  At the very least it's a pointer 
with a name.  The SHA1 hash of a blob is a pointer too.  But it's not a 
branch.  The SHA1 hash of a commit is a pointer too, but if you were to 
consider that a branch then "branch" would simply become synonymous with 
"commit" and the term would lose its utility.

> Which is the reason why your original statement does not
> make sense.

That remains to be seen.  I believe that on the manual's definition of 
"branch" my statement not only makes sense, but is actually correct.

> We could say that the "branch closure" is the DAG of ancestry of the
> commit we point to. We use "branch" in that sense since we have to
> express ourselves in natural language, we are not in a calculus class,
> there is mapping to various real-world and other-VCS concepts in play,
> etc. But in order to use "branch" in the ambiguous sense, you should
> first realize what it means in the _strict_ sense, so that you
> understand the texts correctly and don't reach wrong conclusions or
> create invalid concepts like "branches coming into existence". :-)

I am trying to be as strict as I can according to what is in the 
documentation.

rg
