From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Fixing path quoting issues
Date: Thu, 11 Oct 2007 22:31:05 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0710112227000.4174@racer.site>
References: <11920508172434-git-send-email-jon.delStrother@bestbefore.tv>
 <470DC05A.8020209@viscovery.net> <854pgytafi.fsf@lola.goethe.zz>
 <470DCC76.7070809@viscovery.net> <81156EED-7AC0-4C8B-98B1-8338262459A6@bestbefore.tv>
 <470DD3B8.1080809@viscovery.net> <85k5pts796.fsf@lola.goethe.zz>
 <63D5CE5B-51DD-4017-B2E2-2ADC5DCBE849@steelskies.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Jonathan del Strother <maillist@steelskies.com>
X-From: git-owner@vger.kernel.org Thu Oct 11 23:31:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ig5d4-00068e-KR
	for gcvg-git-2@gmane.org; Thu, 11 Oct 2007 23:31:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755930AbXJKVb3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Oct 2007 17:31:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755784AbXJKVb3
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Oct 2007 17:31:29 -0400
Received: from mail.gmx.net ([213.165.64.20]:35597 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754905AbXJKVb2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Oct 2007 17:31:28 -0400
Received: (qmail invoked by alias); 11 Oct 2007 21:31:26 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp045) with SMTP; 11 Oct 2007 23:31:26 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18UL8EIZR4U7yOhiGkcOs3GSjdvkJn0+16Q2J4S3x
	fTQ8ozQn2cqsrt
X-X-Sender: gene099@racer.site
In-Reply-To: <63D5CE5B-51DD-4017-B2E2-2ADC5DCBE849@steelskies.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60640>

Hi,

On Thu, 11 Oct 2007, Jonathan del Strother wrote:

> On 11 Oct 2007, at 21:53, David Kastrup wrote:
> 
> > Johannes Sixt <j.sixt@viscovery.net> writes:
> > 
> > > Jonathan del Strother schrieb:
> > > > How are you going to test that git works on paths with spaces if the
> > > > test suite doesn't run there?
> > > 
> > > By writing a specific test?
> > 
> > This is going to be much less thorough.  And it does no harm if the 
> > test scripts demonstrate defensive programming.

We do not have _extensive_ tests.  We want to do some coding in addition 
to waiting for our machines to finish the test.  D'oh.

> I would also point out that most tests have already been written to 
> handle this case - ones that don't quote their paths are in the 
> minority.

That might very well be the case, and your goal is laudable.  However, I 
have to agree that most devs (indeed, since you are the first to try to 
fix it, _all_ except for you) do not care that deeply about spaces in the 
path, and having a _single_ test for this would be the logical solution.

I mean, we do not force our main developers to run the most obscure setups 
all the time just to make sure that it runs fine.  Otherwise none of us 
could run Linux, but a couple would be coerced into running Windows, for 
example.

Ciao,
Dscho
