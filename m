From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: make test failure with latest master
Date: Sun, 2 Dec 2007 23:41:10 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0712022340250.27959@racer.site>
References: <4752A53E.4030000@gmail.com> <20071202163426.GA29781@coredump.intra.peff.net>
 <47533D75.1090002@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org, gitster@pobox.com
To: A Large Angry SCM <gitzilla@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 03 00:41:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IyyRe-0006xc-6b
	for gcvg-git-2@gmane.org; Mon, 03 Dec 2007 00:41:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751839AbXLBXle (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Dec 2007 18:41:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751842AbXLBXle
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Dec 2007 18:41:34 -0500
Received: from mail.gmx.net ([213.165.64.20]:49291 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751531AbXLBXld (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Dec 2007 18:41:33 -0500
Received: (qmail invoked by alias); 02 Dec 2007 23:41:31 -0000
Received: from unknown (EHLO openvpn-client) [138.251.11.103]
  by mail.gmx.net (mp040) with SMTP; 03 Dec 2007 00:41:31 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19WT1UAxt5WR6FUNSK5kCsN7MOWWv9XoE6GkKoJ0g
	7T2MCOm9Rye7NP
X-X-Sender: gene099@racer.site
In-Reply-To: <47533D75.1090002@gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66838>

Hi,

On Sun, 2 Dec 2007, A Large Angry SCM wrote:

> Jeff King wrote:
> > On Sun, Dec 02, 2007 at 07:29:50AM -0500, A Large Angry SCM wrote:
> > 
> > > With the latest master, 2221a6757161af1905925c405aded9ff470f70d5, "make
> > > test" now fails; last successful "make test" was mid-week sometime with
> > > master d25430. This is on a laptop running Suse 9.3.
> > > 
> > > *** t9600-cvsimport.sh ***
> > > *   ok 1: setup cvsroot
> > > *   ok 2: setup a cvs module
> > > * FAIL 3: import a trivial module
> > > 
> > > 
> > >                 git cvsimport -a -z 0 -C module-git module &&
> > >                 git diff module-cvs/o_fortuna module-git/o_fortuna
> > 
> > Can you please try ./t9600 --verbose? Presumably cvsimport is generating
> > some kind of error message to tell us what's going on.
> 
> Attached is the output of
> 
> 	./t9600-cvsimport.sh --verbose >/tmp/9600_out.txt 2>&1
> 

Unfortunately you attached the interesting part, so I cannot quote it 
here.  Seems that your cvsps does not understand the "-A" option.  So it 
looks like it is too old.

Hth,
Dscho
