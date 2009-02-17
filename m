From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: disallowing push to currently checked-out branch
Date: Tue, 17 Feb 2009 01:56:29 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0902170154330.10279@pacific.mpi-cbg.de>
References: <7vk57ridyx.fsf@gitster.siamese.dyndns.org> <20090215232013.GA11543@zakalwe.fi> <20090216000443.GB3503@coredump.intra.peff.net> <alpine.DEB.1.10.0902151727330.14911@asgard.lang.hm> <alpine.DEB.1.10.0902151738450.14911@asgard.lang.hm>
 <alpine.LNX.1.00.0902160322530.19665@iabervon.org> <7veixybw7u.fsf@gitster.siamese.dyndns.org> <loom.20090216T101457-231@post.gmane.org> <20090216135812.GA20377@coredump.intra.peff.net> <49999ED6.7010608@gmail.com> <alpine.DEB.1.00.0902161839120.6289@intel-tinevez-2-302>
 <4999BD54.8090805@gmail.com> <alpine.DEB.1.00.0902162103580.6289@intel-tinevez-2-302> <4999FFCE.3060605@gmail.com> <alpine.DEB.1.00.0902170112580.10279@pacific.mpi-cbg.de> <499A07C4.5000908@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Sergio Callegari <sergio.callegari@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 17 01:57:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZEGj-0008Gx-Fe
	for gcvg-git-2@gmane.org; Tue, 17 Feb 2009 01:57:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752014AbZBQAzf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Feb 2009 19:55:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751999AbZBQAze
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Feb 2009 19:55:34 -0500
Received: from mail.gmx.net ([213.165.64.20]:43423 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751964AbZBQAzd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Feb 2009 19:55:33 -0500
Received: (qmail invoked by alias); 17 Feb 2009 00:55:31 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp042) with SMTP; 17 Feb 2009 01:55:31 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX197QTJU/iR7sWwVuImIddHvFESCsX2KCPs4FBTI2z
	vNbpVsiKbZeRO5
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <499A07C4.5000908@gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.67
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110276>

Hi,

On Tue, 17 Feb 2009, Sergio Callegari wrote:

> Let us assume that I am working on branch B and that my worktree is based on
> commit XYZ. Let's also assume that someone pushes behind my shoulders and
> moves the tip of B (or even deletes B alltogether) either in one or in
> multiple pushes.  Is there an easy way so that I can now find out at what
> commit (XYZ) I was before the push(es)?

Nope.  There was code flying around at some stage to record in the index 
what commit it was based on.

I forgot why it was thrown out again; you'll have to look up the 
discussion yourself.

Ciao,
Dscho
