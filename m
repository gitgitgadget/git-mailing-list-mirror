From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git push (mis ?)behavior
Date: Fri, 28 Sep 2007 14:31:56 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0709281429380.28395@racer.site>
References: <20070927130447.GH10289@artemis.corp> <7v3awzvrpr.fsf@gitster.siamese.dyndns.org>
 <9D61974D-E08D-49F6-9C88-6BE446D53C74@zib.de> <7vodfnqndc.fsf@gitster.siamese.dyndns.org>
 <9019207B-77A5-4595-8499-807DA0460EF0@zib.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Pierre Habouzit <madcoder@debian.org>, git@vger.kernel.org
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Fri Sep 28 15:33:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IbFy0-0007jL-Tw
	for gcvg-git-2@gmane.org; Fri, 28 Sep 2007 15:33:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753851AbXI1NdI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Sep 2007 09:33:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753884AbXI1NdG
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Sep 2007 09:33:06 -0400
Received: from mail.gmx.net ([213.165.64.20]:47152 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752311AbXI1NdF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Sep 2007 09:33:05 -0400
Received: (qmail invoked by alias); 28 Sep 2007 13:33:03 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp010) with SMTP; 28 Sep 2007 15:33:03 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+aqbYh+vqaZcrQSmoeaegUQTwtIpJsAkYC2AhSaP
	wKbFE76sxxflx0
X-X-Sender: gene099@racer.site
In-Reply-To: <9019207B-77A5-4595-8499-807DA0460EF0@zib.de>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59393>

Hi,

On Fri, 28 Sep 2007, Steffen Prohaska wrote:

> On Sep 28, 2007, at 9:07 AM, Junio C Hamano wrote:
> 
> > Steffen Prohaska <prohaska@zib.de> writes:
> > 
> > > When "remote.<name>.push" is set I'd expect "git push" to
> > > choose only the 'right' remote.<name>.push lines, that is
> > > the lines that have the current branch as the local ref.
> > 
> > That would break the existing setup so it would not fly as a
> > default, although it could be added as an option.
> 
> Do you mean 'not now' or never, i.e. not in git 1.6?

If it changes behaviour, and there might be people relying on the old 
behaviour, we have to deprecate the old behaviour first.  With a nice 
warning so that people have a chance to adapt their setups.  And then, 
after a decent grace period, we can change it.

> What does 'break the existing setup' means? Pushing all branches that 
> are configured in "remote.<name>.push" could be done by "git push 
> <name>". This would be in the line with the idea that "git push" should 
> only operate on the current branch and operations involving other local 
> refs should be explicitly stated.

People have scripts and aliases to help them go through the day.  If one 
of those scripts or aliases stop working, that is called "break the 
existing setup".  ;-)

Ciao,
Dscho
