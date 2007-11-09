From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [BUG] git-rebase fails when a commit message contains a diff
Date: Fri, 9 Nov 2007 14:18:15 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711091417500.4362@racer.site>
References: <20071109011214.GA5903@diku.dk> <7vlk98xkm3.fsf@gitster.siamese.dyndns.org>
 <7vhcjwxk1s.fsf@gitster.siamese.dyndns.org> <B2BAA0E1-8DA7-417D-AE25-53D8690810ED@zib.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonas Fonseca <fonseca@diku.dk>, git@vger.kernel.org
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Fri Nov 09 15:18:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IqUh0-0003so-1C
	for gcvg-git-2@gmane.org; Fri, 09 Nov 2007 15:18:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754585AbXKIOS0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Nov 2007 09:18:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758271AbXKIOS0
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Nov 2007 09:18:26 -0500
Received: from mail.gmx.net ([213.165.64.20]:39391 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754431AbXKIOS0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Nov 2007 09:18:26 -0500
Received: (qmail invoked by alias); 09 Nov 2007 14:18:24 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp003) with SMTP; 09 Nov 2007 15:18:24 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/3RY92z+X3UfU+RO5igviYHFnANxDq8vEEjQu5yl
	uIsMn8GeDIlfeX
X-X-Sender: gene099@racer.site
In-Reply-To: <B2BAA0E1-8DA7-417D-AE25-53D8690810ED@zib.de>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64186>

Hi,

On Fri, 9 Nov 2007, Steffen Prohaska wrote:

> On Nov 9, 2007, at 2:51 AM, Junio C Hamano wrote:
> 
> > Junio C Hamano <gitster@pobox.com> writes:
> > 
> > > That's a known design limitation of applymbox/mailinfo.  Any
> > > line that looks like a beginning of a patch in e-mail ("^--- ",
> > > "^---$", "^diff -", and "^Index: ") terminates the commit log.
> > 
> > Ok, so that explains the symptom.  What's the next step?
> > 
> >  * The applymbox/mailinfo pair should continue to split the
> >    commit log message at the first such line.  There is no point
> >    breaking established workflow, and people in communities that
> >    exchange patches via e-mail already know to avoid this issue
> >    by indenting quoted diff snippet in the log message,
> >    e.g. 5be507fc.
> 
> I wasn't aware of this.

But there's a really easy workaround: use --merge with git rebase.

Ciao,
Dscho
