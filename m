From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/2 v2] valgrind: ignore ldso errors
Date: Wed, 21 Jan 2009 21:51:05 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901212150131.3586@pacific.mpi-cbg.de>
References: <alpine.DEB.1.00.0901201447290.5159@intel-tinevez-2-302> <20090120141932.GB10688@sigill.intra.peff.net> <alpine.DEB.1.00.0901201545570.5159@intel-tinevez-2-302> <20090120232439.GA17746@coredump.intra.peff.net> <alpine.DEB.1.00.0901210105470.19014@racer>
 <20090121001551.GB18169@coredump.intra.peff.net> <alpine.DEB.1.00.0901210119510.19014@racer> <20090121003739.GA18373@coredump.intra.peff.net> <alpine.DEB.1.00.0901210216440.19014@racer> <alpine.DEB.1.00.0901210236320.19014@racer>
 <20090121190921.GC21686@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jan 21 21:52:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LPk44-0007JC-O7
	for gcvg-git-2@gmane.org; Wed, 21 Jan 2009 21:52:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753868AbZAUUvH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Jan 2009 15:51:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753812AbZAUUvG
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Jan 2009 15:51:06 -0500
Received: from mail.gmx.net ([213.165.64.20]:48129 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753546AbZAUUvF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Jan 2009 15:51:05 -0500
Received: (qmail invoked by alias); 21 Jan 2009 20:50:57 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp032) with SMTP; 21 Jan 2009 21:50:57 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/QUuUgBDPQmkJpW43IsC8UGQL3iiv/q00Guu84Z8
	c8p+76OYKb/INf
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <20090121190921.GC21686@coredump.intra.peff.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: -0.07000000000000001
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106666>

Hi,

On Wed, 21 Jan 2009, Jeff King wrote:

> On Wed, Jan 21, 2009 at 02:36:40AM +0100, Johannes Schindelin wrote:
> 
> > 	Only change vs v1: adds Addr4 suppression, so that ld.so "errors"
> > 	are ignored on 32-bit, too.
> 
> I don't think it is wrong to add the extra suppression, but out of
> curiosity, did you actually trigger it?

Yes.  I wouldn't have touched the file if I hadn't triggered it.

Ciao,
Dscho
