From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: master^ is not a local branch -- huh?!?
Date: Mon, 01 Feb 2010 23:05:20 -0500 (EST)
Message-ID: <alpine.LFD.2.00.1002012253260.1681@xanadu.home>
References: <31a97741002010352x1ad27f26ia4d51857bb2d2d4f@mail.gmail.com>
 <7vpr4o3lg9.fsf@alter.siamese.dyndns.org> <87aavsu9b3.fsf@osv.gnss.ru>
 <ron1-6F8B85.14520801022010@news.gmane.org>
 <7vwrywplxz.fsf@alter.siamese.dyndns.org>
 <ron1-ABA66E.15563101022010@news.gmane.org>
 <20100202001530.GL9553@machine.or.cz>
 <ron1-9A9CEA.16452601022010@news.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Ron Garret <ron1@flownet.com>
X-From: git-owner@vger.kernel.org Tue Feb 02 05:05:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NcA1E-0004gd-QY
	for gcvg-git-2@lo.gmane.org; Tue, 02 Feb 2010 05:05:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752418Ab0BBEFX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Feb 2010 23:05:23 -0500
Received: from relais.videotron.ca ([24.201.245.36]:11171 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751690Ab0BBEFW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Feb 2010 23:05:22 -0500
Received: from xanadu.home ([66.130.28.92]) by VL-MH-MR003.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0KX700L944OW4G42@VL-MH-MR003.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 01 Feb 2010 23:05:21 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <ron1-9A9CEA.16452601022010@news.gmane.org>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138674>

On Mon, 1 Feb 2010, Ron Garret wrote:

> In article <20100202001530.GL9553@machine.or.cz>,
>  Petr Baudis <pasky@suse.cz> wrote:
> 
> > On Mon, Feb 01, 2010 at 03:56:31PM -0800, Ron Garret wrote:
> > > In article <7vwrywplxz.fsf@alter.siamese.dyndns.org>,
> > >  Junio C Hamano <gitster@pobox.com> wrote:
> > > > Ron Garret <ron1@flownet.com> writes:
> > > > > And as long as I'm weighing in, it would also help to prevent confusion 
> > > > > if it were made clear that this unnamed branch doesn't actually come 
> > > > > into existence unless and until you do a commit.
> > > > 
> > > > This shows that you are still thinking a branch is a line (or multiple
> > > > lines).  It is not.
> > > 
> > > The git user's guide says it is:
> > > 
> > > "When we need to be precise, we will use the word "branch" to mean a 
> > > line of development..."
> > > 
> > > But I understand that a branch is not necessarily a line.  In general 
> > > it's a DAG.  I get that.
> > 
> > Again, no. In the most narrow sense, "branch == branch head".
> 
> The manual specifically contradicts you, so either you are wrong or the 
> manual is wrong.

In that case it's most probably the manual which is wrong.

> Don't forget that what is at issue here is not how git works (I'm pretty 
> sure everyone is on the same page about that) but how to explain it to 
> someone who is not already familiar with it.  So it's important to use 
> terminology that is consistent with what the manual says.

Or rather that the manual has to be debugged and be brought in sync with 
reality.  All the people who had their hands dirty with the code usually 
hang here, and what they say has precedence with whatever is in the 
manual.

It is good of course that you bring those issues to our attention.  but 
it is more likely that the manual needs fixing than anything else.


Nicolas
