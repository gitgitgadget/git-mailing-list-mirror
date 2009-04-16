From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Add the diff option --no-defaults
Date: Thu, 16 Apr 2009 04:34:43 -0400
Message-ID: <20090416083443.GA27399@coredump.intra.peff.net>
References: <20090320194930.GB26934@coredump.intra.peff.net> <1237600853-22815-1-git-send-email-keith@cs.ucla.edu> <alpine.DEB.1.00.0903210415110.10279@pacific.mpi-cbg.de> <alpine.GSO.2.00.0904021647120.16242@kiwi.cs.ucla.edu> <alpine.DEB.1.00.0904091030030.10279@pacific.mpi-cbg.de> <20090409084903.GA18947@coredump.intra.peff.net> <alpine.DEB.1.00.0904091242430.10279@pacific.mpi-cbg.de> <20090410080155.GB32195@coredump.intra.peff.net> <alpine.DEB.1.00.0904140036341.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Keith Cascio <keith@CS.UCLA.EDU>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Apr 16 10:36:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LuN55-0006vI-L0
	for gcvg-git-2@gmane.org; Thu, 16 Apr 2009 10:36:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752098AbZDPIeu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Apr 2009 04:34:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751579AbZDPIeu
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Apr 2009 04:34:50 -0400
Received: from peff.net ([208.65.91.99]:49209 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751383AbZDPIet (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Apr 2009 04:34:49 -0400
Received: (qmail 1199 invoked by uid 107); 16 Apr 2009 08:34:54 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Thu, 16 Apr 2009 04:34:54 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 16 Apr 2009 04:34:43 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0904140036341.10279@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116687>

On Tue, Apr 14, 2009 at 12:37:42AM +0200, Johannes Schindelin wrote:

> >   1. You could loosen (1) above by assuming that --no-defaults will
> >      never appears as the argument to an option, and therefore any time
> >      you find it, it should be respected. Thus your first parse is just
> >      a simple loop looking for the option.
> 
> I go with 1)

This feels very hack-ish to me, but perhaps this is a case of "perfect
is the enemy of the good".

-Peff
