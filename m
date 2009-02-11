From: Jeff King <peff@peff.net>
Subject: Re: RFC: Flat directory for notes, or fan-out?  Both!
Date: Wed, 11 Feb 2009 15:02:27 -0500
Message-ID: <20090211200227.GA27961@coredump.intra.peff.net>
References: <alpine.DEB.1.00.0902092200170.10279@pacific.mpi-cbg.de> <20090210121833.GC15491@coredump.intra.peff.net> <alpine.DEB.1.00.0902101357140.10279@pacific.mpi-cbg.de> <20090210131029.GC17305@coredump.intra.peff.net> <alpine.DEB.1.00.0902101427490.10279@pacific.mpi-cbg.de> <7vprhqnv0c.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0902101743180.10279@pacific.mpi-cbg.de> <20090210165610.GP30949@spearce.org> <7vocxam96s.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0902102210140.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Feb 11 21:04:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXLJP-0004ev-Jr
	for gcvg-git-2@gmane.org; Wed, 11 Feb 2009 21:04:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755342AbZBKUCc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Feb 2009 15:02:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754884AbZBKUCb
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Feb 2009 15:02:31 -0500
Received: from peff.net ([208.65.91.99]:51451 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750958AbZBKUCb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Feb 2009 15:02:31 -0500
Received: (qmail 1487 invoked by uid 107); 11 Feb 2009 20:02:46 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 11 Feb 2009 15:02:46 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 11 Feb 2009 15:02:27 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0902102210140.10279@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109519>

On Tue, Feb 10, 2009 at 10:10:43PM +0100, Johannes Schindelin wrote:

> > I wonder if we can solve this by introducing a local cache that is a flat
> > file that looks like:
> [...]
> Or we could use an on-disk hashmap.  Oh, wait...

That was my first thought, as well. Maybe your original implementation
wasn't so bad, after all. :)

I searched through the archive to find a list of criticisms, but I
didn't see any. So I guess the problem was just a concern that it might
end up too complex.

-Peff
