From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] Keep committer and committer dates
Date: Wed, 04 Jun 2008 10:22:35 -0400 (EDT)
Message-ID: <alpine.LFD.1.10.0806041015270.23581@xanadu.home>
References: <Pine.LNX.4.61.0806031647320.1798@tm8103-a.perex-int.cz>
 <alpine.DEB.1.00.0806032115340.13507@racer.site.net>
 <Pine.LNX.4.61.0806041113520.1798@tm8103-a.perex-int.cz>
 <20080604102906.GA2126@diana.vm.bytemark.co.uk>
 <m3ej7dzc7y.fsf@localhost.localdomain>
 <Pine.LNX.4.61.0806041424140.1798@tm8103-a.perex-int.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 7BIT
Cc: Jakub Narebski <jnareb@gmail.com>,
	=?ISO-8859-15?Q?Karl_Hasselstr=F6m?= <kha@treskal.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Jaroslav Kysela <perex@perex.cz>
X-From: git-owner@vger.kernel.org Wed Jun 04 16:24:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K3ttl-0004w2-KH
	for gcvg-git-2@gmane.org; Wed, 04 Jun 2008 16:23:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752487AbYFDOWl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Jun 2008 10:22:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752422AbYFDOWl
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Jun 2008 10:22:41 -0400
Received: from relais.videotron.ca ([24.201.245.36]:11355 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750845AbYFDOWk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Jun 2008 10:22:40 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0K1X001Q0ZXNBL70@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 04 Jun 2008 10:22:39 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <Pine.LNX.4.61.0806041424140.1798@tm8103-a.perex-int.cz>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83784>

On Wed, 4 Jun 2008, Jaroslav Kysela wrote:

> On Wed, 4 Jun 2008, Jakub Narebski wrote:
> 
> > Karl Hasselstr?m <kha@treskal.com> writes:
> > 
> > > On 2008-06-04 11:16:46 +0200, Jaroslav Kysela wrote:
> > > 
> > > > On Tue, 3 Jun 2008, Johannes Schindelin wrote:
> > > >
> > > > > That feels really funny, given that the guy running git-am _is_
> > > > > the committer, not whoever provided some extra headers to the
> > > > > mailbox.
> > > >
> > > > Yes, the implementatation does not make sense for public patch
> > > > handling, but if you do various things locally with git-rebase or
> > > > git-am (pack picking from another repo), you may consider it useful.
> > > 
> > > But still, you're creating new commits, so they should have your name
> > > on them.
> > 
> > Yes, if you are _creating_ *commits*, then you are *committer*, isn't it?
> 
> I agree with that, but if you just manage patches and you want to keep 
> commit history and change only hash numbers, it's an option. Nothing else. 

Then the person performing that reshuffling _becomes_ the new committer 
for those commits with new hash numbers.  Why would you like to hide 
that fact?

> It's just tool extension and users have to cleverly decide if it's worth 
> to use it or not.

I think this is against the purpose of the committer field to preserve 
it from a commit that was not made by you.  What really really has to be 
preserved is the author field of course.  But attributing commit action 
to someone else than yourself when you are the one reorganizing commits 
is misrepresentation.

> I just used in for my work.

Could you explain what your reason is for doing so?


Nicolas
