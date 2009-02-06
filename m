From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] push: Learn to set up branch tracking with '--track'
Date: Fri, 6 Feb 2009 15:54:32 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0902061552320.7377@intel-tinevez-2-302>
References: <alpine.DEB.1.00.0901291438030.3586@pacific.mpi-cbg.de> <20090129223308.GB12871@coredump.intra.peff.net> <20090129231715.GA17399@coredump.intra.peff.net> <alpine.DEB.1.00.0901300127450.3586@pacific.mpi-cbg.de> <20090130050925.GA18809@coredump.intra.peff.net>
 <alpine.DEB.1.00.0901301656290.3586@pacific.mpi-cbg.de> <20090130162258.GA7065@sigill.intra.peff.net> <alpine.DEB.1.00.0901301804030.3586@pacific.mpi-cbg.de> <20090202131611.GB8487@sigio.peff.net> <alpine.DEB.1.00.0902021449370.3586@pacific.mpi-cbg.de>
 <20090206141000.GC18364@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, gitster@pobox.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Feb 06 15:56:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LVS7f-0007ae-Be
	for gcvg-git-2@gmane.org; Fri, 06 Feb 2009 15:56:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753227AbZBFOyg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Feb 2009 09:54:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752938AbZBFOyf
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Feb 2009 09:54:35 -0500
Received: from mail.gmx.net ([213.165.64.20]:42745 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750945AbZBFOyf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Feb 2009 09:54:35 -0500
Received: (qmail invoked by alias); 06 Feb 2009 14:54:32 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp028) with SMTP; 06 Feb 2009 15:54:32 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/hW8UcJ3/hV6Z2o6+HP/YpiEl66zJ/1REKvsXfqi
	uN1ed+XexVF4YM
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <20090206141000.GC18364@coredump.intra.peff.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108724>

Hi,

On Fri, 6 Feb 2009, Jeff King wrote:

> > BTW I always wondered if it would make sense to introduce "git commit 
> > --init" for the first 3 Git commands.  I use them way too often.
> 
> I have noticed that, too, but I think it is because I am constantly
> creating test repos to debug git. Regular users don't have the same
> problem. :)

I do not do that for test repositories, but for untarred 3rd party 
projects, such as zlib.

	$ tar xvf $TAR
	$ cd $DIR
	$ git init
	$ git add .
	$ git commit -m initial
	<start hacking>
	<provide nice patches that everybody envies me for>

Ciao,
Dscho
