From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH/RFC] builtin-checkout: suggest creating local branch when
 appropriate to do so
Date: Wed, 14 Oct 2009 01:16:45 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0910140108110.4985@pacific.mpi-cbg.de>
References: <0016e68fd0123a175304754694b4@google.com> <200910122340.13366.trast@student.ethz.ch> <7vr5t89qiw.fsf@alter.siamese.dyndns.org> <200910130836.57011.trast@student.ethz.ch> <7vljjf226t.fsf@alter.siamese.dyndns.org> <alpine.LNX.2.00.0910131358000.32515@iabervon.org>
 <7vljjfuibr.fsf@alter.siamese.dyndns.org> <alpine.LNX.2.00.0910131654270.32515@iabervon.org> <20091013215751.GA12603@coredump.intra.peff.net> <7vhbu2syi6.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jeff King <peff@peff.net>, Daniel Barkalow <barkalow@iabervon.org>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Thomas Rast <trast@student.ethz.ch>, Euguess@gmail.com,
	Mikael Magnusson <mikachu@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Jay Soffian <jaysoffian@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 14 01:22:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MxqhI-0007Rv-VL
	for gcvg-git-2@lo.gmane.org; Wed, 14 Oct 2009 01:22:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760884AbZJMXOy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Oct 2009 19:14:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760822AbZJMXOy
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Oct 2009 19:14:54 -0400
Received: from mail.gmx.net ([213.165.64.20]:47259 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1759765AbZJMXOx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Oct 2009 19:14:53 -0400
Received: (qmail invoked by alias); 13 Oct 2009 23:14:06 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp072) with SMTP; 14 Oct 2009 01:14:06 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+RVB1KNZORxBbWJ20V4f0AKWiEWI7KejJu415cgB
	JVwo9MPi13SpUx
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <7vhbu2syi6.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.5600000000000001
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130229>

Hi,

On Tue, 13 Oct 2009, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > On Tue, Oct 13, 2009 at 05:31:46PM -0400, Daniel Barkalow wrote:
> >
> >> I personally think that the real issue is that our "detached HEAD" message 
> >> is still too scary, and what we really want is to issue the scary message 
> >> when using "git commit" to move a detached HEAD from what was checked out 
> >> to a new commit.
> >
> > This has been discussed before (I happen to agree with you, but you
> > probably want to address other comments in the thread):
> >
> >   http://thread.gmane.org/gmane.comp.version-control.git/38201/focus=38213
> 
> I just re-read the discussion again (thanks for a useful pointers).  I
> mostly agree with everything said in the thread and obviously agree with
> its conclusion, but one thing I noticed that everybody (who _was_ a git
> expert) in the thread was assuming bothered me somewhat.

We can of course continue to this public wanking session in our nice 
little circle here on git@vger, fully aware that real users will not dare 
to interrupt us.

In the alternative, we can go out into the world (you know, that thing 
behind the computer screen?) and ask somebody who has _not_ been exposed 
to Git for _4 years_ (like most of you!) just how hard it is to work with 
Git.

Let me tell you this from my experience: the least likely answer is "the 
messages are too scary".  Invariably, the answer I get is "it is totally 
unintuitive".  Often followed by "I tell Git to do something 
straight-forward, and it refuses to do it."

Maybe we should just admit that we are no user interface designers, so one 
cannot expect miracles from us in that respect.  And first and foremost, 
we should not pretend to ourselves that we are good at user interfaces, 
because we have a track record of sucking in that area.  Big time.

Ciao,
Dscho

P.S.: As somebody mentioned already, it is time to fix the tools, not our 
users.
