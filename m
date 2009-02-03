From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] t3411: Fix test 1 for case-insensitive file systems
Date: Tue, 3 Feb 2009 18:18:50 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0902031817260.6573@intel-tinevez-2-302>
References: <1233244816-67565-1-git-send-email-benji@silverinsanity.com> <7vocxqf2sf.fsf@gitster.siamese.dyndns.org> <673CE949-5DF9-4970-A739-AA09FCD26D24@silverinsanity.com> <1E104E1B-BFCC-4CFC-9D53-CE89299C9600@silverinsanity.com>
 <alpine.DEB.1.00.0902031752230.6573@intel-tinevez-2-302> <2D4586A6-ADAC-4B6E-8B42-2CBD76E0304C@silverinsanity.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: Brian Gernhardt <benji@silverinsanity.com>
X-From: git-owner@vger.kernel.org Tue Feb 03 18:20:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUOwh-0000lA-As
	for gcvg-git-2@gmane.org; Tue, 03 Feb 2009 18:20:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752142AbZBCRS7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Feb 2009 12:18:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751907AbZBCRS6
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Feb 2009 12:18:58 -0500
Received: from mail.gmx.net ([213.165.64.20]:47393 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752095AbZBCRS5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Feb 2009 12:18:57 -0500
Received: (qmail invoked by alias); 03 Feb 2009 17:18:51 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp006) with SMTP; 03 Feb 2009 18:18:51 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/9P85y1n79J8dhV3TTj+GumWMMc2m7XrqnDhj0hO
	7qeCJVlYwb5is0
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <2D4586A6-ADAC-4B6E-8B42-2CBD76E0304C@silverinsanity.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.64
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108221>

Hi,

On Tue, 3 Feb 2009, Brian Gernhardt wrote:

> 
> On Feb 3, 2009, at 11:53 AM, Johannes Schindelin wrote:
> 
> >On Tue, 3 Feb 2009, Brian Gernhardt wrote:
> >
> > >This change appears to have been forgotten, but does fix the problems 
> > >I was having.  Junio, can this make it into the official repo instead 
> > >of floating around in my local?  I'd send in a patch, but it was your 
> > >code and I don't want to take credit for it.
> >
> >Top-poster!
> 
> Well, yes.  I wasn't replying to anything in the e-mail, I just wanted to
> bring it back to attention.

You did, in fact, refer a little bit to the content of the thread you were 
replying to.

> >Besides, I think that my latest comment still stands there: testing is not
> >good enough, code inspection is required if something expects the file
> >names as they used to be.
> 
> As far as I can tell, no test relies on the auto-generated name of the test
> file.  In fact, only t3411 uses that feature at all and it only performs
> operations on commits.  All other uses of test_commit give a filename (even
> though many of them don't appear to use the file).

You did not look far.

Ciao,
Dscho
