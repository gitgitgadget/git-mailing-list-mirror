From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Move all dashed form git commands to libexecdir
Date: Fri, 30 Nov 2007 23:17:47 -0500
Message-ID: <20071201041747.GC30725@coredump.intra.peff.net>
References: <20071130003512.GB11683@coredump.intra.peff.net> <7vzlwwsgkp.fsf@gitster.siamese.dyndns.org> <20071130005852.GA12224@coredump.intra.peff.net> <alpine.LFD.0.99999.0711292004340.9605@xanadu.home> <20071130011748.GC11683@coredump.intra.peff.net> <474FB938.3040209@op5.se> <20071130150948.GA22095@coredump.intra.peff.net> <7vve7jqz92.fsf@gitster.siamese.dyndns.org> <20071130212500.GB25946@coredump.intra.peff.net> <7vbq9b87jb.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andreas Ericsson <ae@op5.se>, Nicolas Pitre <nico@cam.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Jan Hudec <bulb@ucw.cz>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Dec 01 05:18:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IyJnt-0006bf-Hq
	for gcvg-git-2@gmane.org; Sat, 01 Dec 2007 05:18:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755217AbXLAERu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Nov 2007 23:17:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755305AbXLAERu
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Nov 2007 23:17:50 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4655 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755064AbXLAERt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Nov 2007 23:17:49 -0500
Received: (qmail 13866 invoked by uid 111); 1 Dec 2007 04:17:48 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Fri, 30 Nov 2007 23:17:48 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 30 Nov 2007 23:17:47 -0500
Content-Disposition: inline
In-Reply-To: <7vbq9b87jb.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66696>

On Fri, Nov 30, 2007 at 06:37:12PM -0800, Junio C Hamano wrote:

> side does not have such a program anywhere).  So my preference at this
> point is to move things out of PATH first (without removing the
> hardlinks), deal with possible fallout from that move.
> 
> And after things stablize, discuss to either remove the hardlinks from
> all installations, or to keep them in all installations.  I do not think
> "it's this way here but that way there" is a good thing in general.

I think that it is a sensible course of action.

-Peff
