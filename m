From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] better git-submodule status output
Date: Sun, 6 Jul 2008 14:57:00 +0200 (CEST)
Message-ID: <alpine.LSU.1.00.0807061456100.3486@wbgn129.biozentrum.uni-wuerzburg.de>
References: <20080701150119.GE5852@joyeux> <7vhcb3o7q3.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Lars Hjemli <hjemli@gmail.com>, Ping Yin <pkufranky@gmail.com>,
	Mark Levedahl <mlevedahl@gmail.com>, git@vger.kernel.org,
	Sylvain Joyeux <sylvain.joyeux@dfki.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jul 06 14:58:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KFToY-0005aE-KV
	for gcvg-git-2@gmane.org; Sun, 06 Jul 2008 14:58:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755732AbYGFM5F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Jul 2008 08:57:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755782AbYGFM5E
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Jul 2008 08:57:04 -0400
Received: from mail.gmx.net ([213.165.64.20]:51978 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755732AbYGFM5D (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Jul 2008 08:57:03 -0400
Received: (qmail invoked by alias); 06 Jul 2008 12:57:01 -0000
Received: from wbgn128.biozentrum.uni-wuerzburg.de (EHLO wrzx67.rz.uni-wuerzburg.de) [132.187.25.128]
  by mail.gmx.net (mp039) with SMTP; 06 Jul 2008 14:57:01 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+2g3JEYP22d6fSgpP3K+qw7O12nAiaPkAGtp3CWj
	EeN/Hi/6G3jE+3
X-X-Sender: gene099@wbgn129.biozentrum.uni-wuerzburg.de
In-Reply-To: <7vhcb3o7q3.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.5600000000000001
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87527>

Hi,

On Sat, 5 Jul 2008, Junio C Hamano wrote:

> Sylvain Joyeux <sylvain.joyeux@dfki.de> writes:
> 
> > This patch makes the output of git-submodule more useful to handle the
> > management of a repository using multiple submodules. Namely, it
> > displays informations about how the current checked out version relates
> > to the registered one (i.e. direct parent, direct child, "just
> > different", registered revision does not exist), and displays if the
> > submodules contain uncommitted changes.
> >
> > This (among other things) allows to do git-submodule update while
> > knowing exactly what will happen.
> > --
> > Sylvain
> >
> >>>From 16553a9b210a956b0af961d55a9cf06f1b9b8114 Mon Sep 17 00:00:00 2001
> > From: Sylvain Joyeux <sylvain.joyeux@dfki.de>
> > Date: Tue, 1 Jul 2008 16:01:01 +0200
> > Subject: [PATCH] more information in git-submodule status output
> >
> > This commit adds more information in the 'status' output of
> > git-submodule. More specifically, it displays different flags if the
> > submodule and the registered revision are direct parents (> and <,
> > depending on which is the ancestor), if they are not direct parents (+)
> > or if the registered revision cannot be found (i.e. if submodule update
> > would fail, '!')
> >
> > Finally, it shows if the submodule contains uncommitted changes (M flag)
> 
> Which one is the commit message ;-)?

I think it is clear that Sylvain has not read 
Documentation/SubmittingPatches yet.

> People who rely on working submodule support, do you have any feedback 
> on this patch?

Not yet.  Will test/comment when the spurious "fetch" is fixed.

Ciao,
Dscho
