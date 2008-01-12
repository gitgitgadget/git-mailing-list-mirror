From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: valgrind test script integration
Date: Sat, 12 Jan 2008 18:10:30 +0100 (CET)
Message-ID: <alpine.LSU.1.00.0801121808150.8333@wbgn129.biozentrum.uni-wuerzburg.de>
References: <7vsl13wmas.fsf@gitster.siamese.dyndns.org> <200801120926.14307.ismail@pardus.org.tr> <7vejcnwl85.fsf@gitster.siamese.dyndns.org> <200801120947.48602.ismail@pardus.org.tr> <20080112090432.GA6134@coredump.intra.peff.net> <20080112111044.GA24257@coredump.intra.peff.net>
 <20080112113608.GB24589@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Jan 12 18:11:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JDjsz-0002Tj-0L
	for gcvg-git-2@gmane.org; Sat, 12 Jan 2008 18:11:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754626AbYALRKe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Jan 2008 12:10:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754655AbYALRKe
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Jan 2008 12:10:34 -0500
Received: from mail.gmx.net ([213.165.64.20]:54442 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754626AbYALRKd (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Jan 2008 12:10:33 -0500
Received: (qmail invoked by alias); 12 Jan 2008 17:10:31 -0000
Received: from wbgn128.biozentrum.uni-wuerzburg.de (EHLO wrzx67.rz.uni-wuerzburg.de) [132.187.25.128]
  by mail.gmx.net (mp029) with SMTP; 12 Jan 2008 18:10:31 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19XPLZzUi9XtHDpkJJKIWuOZt5tkyrTUoSJmEF2wp
	2x/R26ZW01S3/K
X-X-Sender: gene099@wbgn129.biozentrum.uni-wuerzburg.de
In-Reply-To: <20080112113608.GB24589@coredump.intra.peff.net>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70333>

Hi,

On Sat, 12 Jan 2008, Jeff King wrote:

> On Sat, Jan 12, 2008 at 06:10:44AM -0500, Jeff King wrote:
> 
> >  - We only catch calls to 'git', not 'git-foo' (and in fact for that
> >    reason this doesn't catch the t7300 bug by itself, since that uses
> >    git-clean). A follow-on patch will deal with this.
> 
> And here it is.
> 
> [...]
> 
> Obviously another route would be intercepting git-* calls, as well, but 
> my impression is that we are ultimately heading towards a "git foo is 
> the right way" situation, in which case this cleanup is eventually 
> necessary anyway.

Nevertheless, I think that would be better.

BTW does your first patch cope with scripts properly? (I.e. also valgrind 
the git programs called by the script)

Ciao,
Dscho
