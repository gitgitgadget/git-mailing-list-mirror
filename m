From: Matthias Lederhofer <matled@gmx.net>
Subject: Re: [PATCH] Teach Makefile to respect external variables: CFLAGS and others.
Date: Wed, 13 Jun 2007 09:42:40 +0200
Message-ID: <20070613074240.GA12894@moooo.ath.cx>
References: <20070613054229.GM86872@void.codelabs.ru> <7v4plcgzer.fsf@assigned-by-dhcp.pobox.com> <20070613071514.GP86872@void.codelabs.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Eygene Ryabinkin <rea-git@codelabs.ru>
X-From: git-owner@vger.kernel.org Wed Jun 13 09:42:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HyNV7-0003Lb-C0
	for gcvg-git@gmane.org; Wed, 13 Jun 2007 09:42:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755968AbXFMHmo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 13 Jun 2007 03:42:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755954AbXFMHmo
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jun 2007 03:42:44 -0400
Received: from mail.gmx.net ([213.165.64.20]:52741 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755860AbXFMHmn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jun 2007 03:42:43 -0400
Received: (qmail invoked by alias); 13 Jun 2007 07:42:42 -0000
Received: from pD9EBB4AE.dip0.t-ipconnect.de (EHLO moooo.ath.cx) [217.235.180.174]
  by mail.gmx.net (mp048) with SMTP; 13 Jun 2007 09:42:42 +0200
X-Authenticated: #5358227
X-Provags-ID: V01U2FsdGVkX1+PAvR2+fWPhkwxPVZODk6Fr+nfvqtsvOLWHsP1E2
	BBVvEWjxkp4qBC
Content-Disposition: inline
In-Reply-To: <20070613071514.GP86872@void.codelabs.ru>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50029>

Eygene Ryabinkin <rea-git@codelabs.ru> wrote:
> Junio, Sam, good day.
> 
> Tue, Jun 12, 2007 at 11:07:56PM -0700, Junio C Hamano wrote:
> > I run "make CFLAGS=-O0 -g" all the time.  Also "make CC=echo"
> > seems to "work" as expected ;-).
> > 
> > Care to elaborate what problem you are trying to solve?
> 
> As Sam Ravnborg kindly pointed out, you're using make variables
> and I am trying to give the respect to the environment variables.
> 
> And the real problem is that one (for example, me) can try to
> build Git with the different compiler than CC (gccX or icc, for
> example).  And it is much better for lazy people to do 'export
> CC=whatever' once and then fire make any number of times ;))
> 
> Answering Sam: yes, with my patch it is easier to inherit the
> variables from the environment.  But it is not clear if it is
> good or bad ;))
> 
> But anyway, this patch is only my suggestion, and it can be
> thrown away :)

If you want to fix it for your own checkout of git just put whatever
you like in config.mak.  For example I add -ggdb3 to CFLAGS, set the
prefix variable and add some custom make targets in this file.
