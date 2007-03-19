From: Raimund Bauer <ray007@gmx.net>
Subject: RE: [wishlist] graphical diff
Date: Mon, 19 Mar 2007 17:44:04 +0100
Message-ID: <1174322644.5639.17.camel@localhost>
References: <001001c769fe$af8f4400$0b0aa8c0@abf.local>
	 <Pine.LNX.4.63.0703191359380.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: 'Robin Rosenberg' <robin.rosenberg.lists@dewire.com>,
	'git' <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Mar 19 17:44:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HTKy2-0008CO-Ip
	for gcvg-git@gmane.org; Mon, 19 Mar 2007 17:44:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751558AbXCSQoJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Mar 2007 12:44:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030299AbXCSQoJ
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Mar 2007 12:44:09 -0400
Received: from mail.gmx.net ([213.165.64.20]:33368 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751596AbXCSQoH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Mar 2007 12:44:07 -0400
Received: (qmail invoked by alias); 19 Mar 2007 16:44:06 -0000
Received: from p5498AE42.dip0.t-ipconnect.de (EHLO [192.168.178.22]) [84.152.174.66]
  by mail.gmx.net (mp045) with SMTP; 19 Mar 2007 17:44:06 +0100
X-Authenticated: #20693823
X-Provags-ID: V01U2FsdGVkX18H2SNNLYgH6f+yuR7kbfFbfOiQc6/OeNGt0Ebavl
	qIeeFHkyV4ondU
In-Reply-To: <Pine.LNX.4.63.0703191359380.22628@wbgn013.biozentrum.uni-wuerzburg.de>
X-Mailer: Evolution 2.8.1 
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42641>

Hi,

On Mon, 2007-03-19 at 14:00 +0100, Johannes Schindelin wrote:
> > Maybe with a git.gui config option (like merge.tool)?
> > Or by specifying on the commandline:
> > 
> > git diff --gui=<my-gui-differ> ...
> > 
> > And <my-gui-differ> = xxdiff | kompare | tkdiff | ...
> 
> Have you actually looked at the patch I sent? It is more logical to say 
> "git -p=<bla> diff ..." when the option "-p" (without "=") already exists.

I have, and I can't see your patch doing what I want.
Sorry if I haven't made myself clear what I want, but I was thinking
about a shortcut for something like the following example sequence:

$ git show v1.4.0:git.c > git.c.v1.4.0
$ git show v1.4.4:git.c > git.c.v1.4.4
$ tkdiff git.c.v1.4.0 git.c.v1.4.4
$ rm git.c.v1.4.0 git.c.v1.4.4

Replace tkdiff with the differ of your choice.

At least for comparing 2 single blobs that behavior should be well
defined. For comparing multiple blobs, checking them out in 2 separate
directories and starting the differ with the directories could work, but
I'm more after the single-file case for now ... and that's also the one
that should be easy to start from gitk.

If there's a way to do that by setting the pager I'll be happy to do
so ;-)

> Ciao,
> Dscho

-- 
best regards

  Ray
