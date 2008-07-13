From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [HACK] t/test-lib.sh HACK: Add -s/--show-hack to test suite.
Date: Sun, 13 Jul 2008 02:25:22 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0807130222320.2995@eeepc-johanness>
References: <1215375751-30853-1-git-send-email-s-beyer@gmx.net> <alpine.DEB.1.00.0807062241040.7342@eeepc-johanness> <20080707140841.GB6726@leksak.fem-net> <alpine.DEB.1.00.0807071540310.18205@racer> <20080712222212.GC22323@leksak.fem-net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Stephan Beyer <s-beyer@gmx.net>
X-From: git-owner@vger.kernel.org Sun Jul 13 02:29:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KHpSh-00085B-Qc
	for gcvg-git-2@gmane.org; Sun, 13 Jul 2008 02:29:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751045AbYGMAY7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Jul 2008 20:24:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751227AbYGMAY7
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Jul 2008 20:24:59 -0400
Received: from mail.gmx.net ([213.165.64.20]:59650 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750972AbYGMAY7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Jul 2008 20:24:59 -0400
Received: (qmail invoked by alias); 13 Jul 2008 00:24:56 -0000
Received: from 88-107-253-132.dynamic.dsl.as9105.com (EHLO eeepc-johanness.st-andrews.ac.uk) [88.107.253.132]
  by mail.gmx.net (mp057) with SMTP; 13 Jul 2008 02:24:56 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18TeqpqFw0Twi3JBJqcK0zdoWvD7Po8C2dVsz1Yzj
	NLFrDhROJ+saoo
X-X-Sender: user@eeepc-johanness
In-Reply-To: <20080712222212.GC22323@leksak.fem-net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.64
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88276>

Hi,

On Sun, 13 Jul 2008, Stephan Beyer wrote:

> Johannes Schindelin wrote:
> 
> > On Mon, 7 Jul 2008, Stephan Beyer wrote:
> > 
> > > > > This option realizes a stupid hack that tries to run the test 
> > > > > cases line by line (separated by &&).
> > > > 
> > > > In what way is that better than "sh -x t????-*.sh"?
> > > 
> > > Your suggestion is more like "./t????-*.sh -v" instead of -s, at 
> > > least on bash and dash here.
> > 
> > No, I meant without "-v".
> 
> Me, too.
> 
> I've written something different: "sh -x" is a great thing and does 
> exactly what it should on simple scripts containing:
> 
> 	foo &&
> 	bar &&
> 	baz
> 
> But for a test case in the git test suite it does not work, unfortunately.

Huh?

When I run "sh -x t*.sh", it lists _every_ command that was executed in 
the script, and even more: it shows me the result, too!  If there was a 
function that was called, it prefixes an additional "+" so that I can 
follow recursion better.

All in all, "sh -x" is a very versatile tool.

As far as I undertood your commit message, your HACK would have done the 
first part: list what commands were executed.  This is less than what "sh 
-x" does.

Please clarify,
Dscho
