From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Expand the rename(2) workaround in mingw to cover case
 change in filename
Date: Tue, 9 Jun 2009 00:00:51 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0906082359320.26154@pacific.mpi-cbg.de>
References: <20090608203248.GA22972@blimp.localdomain> <alpine.DEB.1.00.0906082355350.26154@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Johannes Sixt <j.sixt@viscovery.net>,
	Dmitry Potapov <dpotapov@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 09 00:00:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MDmss-0008BR-Qo
	for gcvg-git-2@gmane.org; Tue, 09 Jun 2009 00:00:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754593AbZFHV7y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Jun 2009 17:59:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753288AbZFHV7y
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Jun 2009 17:59:54 -0400
Received: from mail.gmx.net ([213.165.64.20]:43548 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753221AbZFHV7x (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Jun 2009 17:59:53 -0400
Received: (qmail invoked by alias); 08 Jun 2009 21:59:54 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp066) with SMTP; 08 Jun 2009 23:59:54 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/kqQVgAbfk2aeyZSENi8JATHQegfzQ002HKDswMg
	OMcaalfq41desB
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <alpine.DEB.1.00.0906082355350.26154@pacific.mpi-cbg.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.64
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121119>

Hi,

On Mon, 8 Jun 2009, Johannes Schindelin wrote:

> On Mon, 8 Jun 2009, Alex Riesen wrote:
> 
> > Windows, being a case-confused operating system, sometimes has
> > problems renaming directory entries with only change in the case
> > of their characters. Try to work the problem around by using an
> > intermediate file.
> > 
> > ---
> > 
> > NOT TESTED. Can't. My Windows broke again. Not even compile-tested.
> 
> Yes, that is pretty easy to see as you first used pold/pnew and then 
> src/dst.
> 
> I minimally fixed up your patch (it now uses strbuf), and added a 
> test-case.

I probably should have mentioned that you can see it here:

http://repo.or.cz/w/git/mingw/4msysgit.git?a=shortlog;h=refs/heads/work/rename

Ciao,
Dscho
