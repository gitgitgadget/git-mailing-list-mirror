From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: What's cooking in git.git (topics)
Date: Mon, 12 Nov 2007 15:02:37 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711121501500.4362@racer.site>
References: <20071022063222.GS14735@spearce.org> <7vzly84qwf.fsf@gitster.siamese.dyndns.org>
 <7vmytycykt.fsf@gitster.siamese.dyndns.org> <7vr6j6ve90.fsf@gitster.siamese.dyndns.org>
 <7vir4d40sw.fsf@gitster.siamese.dyndns.org> <7vwsso3poo.fsf@gitster.siamese.dyndns.org>
 <Pine.LNX.4.64.0711121203150.4362@racer.site> <087FCF8E-74BF-42EA-B7E2-4622DD0F5F9B@zib.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Mon Nov 12 16:03:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iraoe-0003jj-PT
	for gcvg-git-2@gmane.org; Mon, 12 Nov 2007 16:03:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751086AbXKLPCx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Nov 2007 10:02:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751055AbXKLPCx
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Nov 2007 10:02:53 -0500
Received: from mail.gmx.net ([213.165.64.20]:48029 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750854AbXKLPCw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Nov 2007 10:02:52 -0500
Received: (qmail invoked by alias); 12 Nov 2007 15:02:50 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp035) with SMTP; 12 Nov 2007 16:02:50 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19AhDM8QflAvA+fucypPXE+dgKjINVUlzcIFtU3Jm
	OEZcey6yWxfXDe
X-X-Sender: gene099@racer.site
In-Reply-To: <087FCF8E-74BF-42EA-B7E2-4622DD0F5F9B@zib.de>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64632>

Hi,

On Mon, 12 Nov 2007, Steffen Prohaska wrote:

> On Nov 12, 2007, at 1:21 PM, Johannes Schindelin wrote:
> 
> > > * sp/refspec-match (Sun Nov 11 15:01:48 2007 +0100) 4 commits
> > > - refactor fetch's ref matching to use refname_match()
> > > - push: use same rules as git-rev-parse to resolve refspecs
> > > - add refname_match()
> > > - push: support pushing HEAD to real branch name
> > > 
> > > This changes the semantics slightly but I think it is a move in
> > > the right direction.
> > 
> > We could add a "--matching" option and output a warning when it is not
> > passed.  I would like this pretty soon, and would not be sad if it went
> > into 'next' before this topic.
> 
> Is this the road towards
> 1) "git push --matching" push matching branches.
> 2) "git push --current" push only current branch.
> 3) "git push" report error if the config does not contain a Push line.
>   (after it reported a warning for a while).

AFAIAC yes.  Maybe in two years (that's twice an eternity in git time 
scales):

4) make "git push --current" the default.

> I'd like to see this too. Unfortunately it's unlikely that I'll start 
> working on it before next weekend.
> 
> "--matching" would be a no-op at this time. Only a warning would be printed
> if it is missing. Right?

Right.

Ciao,
Dscho
