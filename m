From: Jeff King <peff@peff.net>
Subject: Re: clone breaks replace
Date: Tue, 11 Jan 2011 14:51:07 -0500
Message-ID: <20110111195107.GA18714@sigill.intra.peff.net>
References: <4D262D68.2050804@cfl.rr.com>
 <4D2C7611.6060204@cfl.rr.com>
 <20110111173922.GB1833@sigill.intra.peff.net>
 <201101112048.57326.j6t@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Phillip Susi <psusi@cfl.rr.com>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Christian Couder <chriscool@tuxfamily.org>,
	Stephen Bash <bash@genarts.com>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Tue Jan 11 20:51:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PckFk-0001ka-Ry
	for gcvg-git-2@lo.gmane.org; Tue, 11 Jan 2011 20:51:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932671Ab1AKTvM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Jan 2011 14:51:12 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:42382 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932622Ab1AKTvL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Jan 2011 14:51:11 -0500
Received: (qmail 15750 invoked by uid 111); 11 Jan 2011 19:51:10 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Tue, 11 Jan 2011 19:51:10 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 11 Jan 2011 14:51:07 -0500
Content-Disposition: inline
In-Reply-To: <201101112048.57326.j6t@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164984>

On Tue, Jan 11, 2011 at 08:48:57PM +0100, Johannes Sixt wrote:

> On Dienstag, 11. Januar 2011, Jeff King wrote:
> > On Tue, Jan 11, 2011 at 10:24:01AM -0500, Phillip Susi wrote:
> > > Yes, either a new branch or separate historical repository could be
> > > published to pull the original history from, or git would need to pass
> > > the --no-replace-objects flag to git-upload-pack on the server, causing
> > > it to ignore the replace and send the original history.
> >
> > AFAIK, git can't pass --no-replace-objects to the server over git:// (or
> > smart http). You would need a protocol extension.
> 
> Why would you have to? git-upload-pack never looks at replacement objects.

I think you missed the first part of this discussion. Phillip is
proposing that it should, and I am arguing against it.

-Peff
