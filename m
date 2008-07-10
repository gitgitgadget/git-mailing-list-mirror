From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: feature request: git-log should accept sth like
 v2.6.26-rc8-227
Date: Fri, 11 Jul 2008 01:47:37 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0807110145500.3279@eeepc-johanness>
References: <200807102057.15063.toralf.foerster@gmx.de> <7vk5ftpnek.fsf@gitster.siamese.dyndns.org> <m3d4lledbn.fsf@localhost.localdomain> <7v8ww9pkv8.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0807110022510.3279@eeepc-johanness>
 <7vk5ftnyhp.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jakub Narebski <jnareb@gmail.com>,
	=?ISO-8859-15?Q?Toralf_F=F6rster?= <toralf.foerster@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 11 01:48:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KH5s3-0002p7-6c
	for gcvg-git-2@gmane.org; Fri, 11 Jul 2008 01:48:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751934AbYGJXrU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jul 2008 19:47:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752089AbYGJXrU
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Jul 2008 19:47:20 -0400
Received: from mail.gmx.net ([213.165.64.20]:43892 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751559AbYGJXrT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jul 2008 19:47:19 -0400
Received: (qmail invoked by alias); 10 Jul 2008 23:47:17 -0000
Received: from 88-107-253-132.dynamic.dsl.as9105.com (EHLO eeepc-johanness.st-andrews.ac.uk) [88.107.253.132]
  by mail.gmx.net (mp049) with SMTP; 11 Jul 2008 01:47:17 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/5j6JP6Jz5Y1vK0BFCxcDgG/69YQDFXnh+kuDAtI
	36r5flubiqrH7e
X-X-Sender: user@eeepc-johanness
In-Reply-To: <7vk5ftnyhp.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.66
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88060>

Hi,

On Thu, 10 Jul 2008, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > On Thu, 10 Jul 2008, Junio C Hamano wrote:
> >
> >> Jakub Narebski <jnareb@gmail.com> writes:
> >> 
> >> > Besides, it would be nice to have some command (git-rev-parse 
> >> > perhaps?) which could take ambiguous commit-ish, and list all commit 
> >> > which matches it.
> >> 
> >> Have fun writing it and send in a patch.
> >
> > Note that this really could be a patch, but not for rev-parse.  Patch 
> > revision.c instead to parse the argument into _all_ matching revisions.
> 
> As Linus pointed out, that is "all _locally_ matching revisions".  It is 
> of dubious value in a distributed environment.

Right.  Judging from some of the conversations on IRC (and even on this 
list), it seems that the word "local" for the reflogs is lost on some, and 
there is no reason to expect otherwise for the currently proposed thing.

So strike my suggestions,
Dscho
