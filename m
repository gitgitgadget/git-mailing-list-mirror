From: Jeff King <peff@peff.net>
Subject: Re: [PATCHv2 03/10] pkt-line: clean up "gentle" reading function
Date: Mon, 18 Feb 2013 05:25:51 -0500
Message-ID: <20130218102551.GN5096@sigill.intra.peff.net>
References: <20130218091203.GB17003@sigill.intra.peff.net>
 <20130218091619.GC5096@sigill.intra.peff.net>
 <20130218101209.GC7049@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 18 11:26:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U7Nvg-0001Jt-MI
	for gcvg-git-2@plane.gmane.org; Mon, 18 Feb 2013 11:26:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757723Ab3BRK0M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Feb 2013 05:26:12 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:51777 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757302Ab3BRKZy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Feb 2013 05:25:54 -0500
Received: (qmail 18426 invoked by uid 107); 18 Feb 2013 10:27:25 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 18 Feb 2013 05:27:25 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 18 Feb 2013 05:25:51 -0500
Content-Disposition: inline
In-Reply-To: <20130218101209.GC7049@elie.Belkin>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216469>

On Mon, Feb 18, 2013 at 02:12:09AM -0800, Jonathan Nieder wrote:

> Jeff King wrote:
> 
> > Originally we had a single function for reading packetized
> > data: packet_read_line. Commit 46284dd grew a more "gentle"
> > form that would return an error instead of dying upon
> > reading a truncated input stream. However:
> 
> In other words:

Hmph. I had originally written a commit message organized more like
yours, then I changed it to try to be more clear. I guess that didn't
work.

But yes, you get the intent exactly.

-Peff
