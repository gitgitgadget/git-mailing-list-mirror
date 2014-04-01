From: Mike Hommey <mh@glandium.org>
Subject: Re: fast-import deltas
Date: Tue, 1 Apr 2014 23:18:56 +0900
Message-ID: <20140401141856.GA2497@glandium.org>
References: <20140401102554.GA32231@glandium.org>
 <20140401114502.GA15549@sigill.intra.peff.net>
 <20140401130703.GA1479@glandium.org>
 <20140401131512.GA19321@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Apr 01 16:19:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WUzWy-0005Ue-9O
	for gcvg-git-2@plane.gmane.org; Tue, 01 Apr 2014 16:19:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751449AbaDAOTG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Apr 2014 10:19:06 -0400
Received: from ks3293202.kimsufi.com ([5.135.186.141]:48302 "EHLO
	zenigata.glandium.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751162AbaDAOTF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Apr 2014 10:19:05 -0400
Received: from glandium by zenigata.glandium.org with local (Exim 4.82)
	(envelope-from <glandium@glandium.org>)
	id 1WUzWi-0000fH-Sn; Tue, 01 Apr 2014 23:18:56 +0900
Content-Disposition: inline
In-Reply-To: <20140401131512.GA19321@sigill.intra.peff.net>
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245591>

On Tue, Apr 01, 2014 at 09:15:12AM -0400, Jeff King wrote:
> > It seems to me fast-import keeps a kind of human readable format for its
> > protocol, i wonder if xdelta format would fit the bill. That being said,
> > I also wonder if i shouldn't just try to write a pack on my own...
> 
> The fast-import commands are human readable, but the blob contents are
> included inline. I don't see how sending a binary delta is any worse
> than sending a literal binary blob over the stream.

OTOH, the xdelta format is not exactly straightforward to produce, with
the variable length encoding of integers. Not exactly hard, but when
everything else in fast-import is straightforward, one has to wonder.

Mike
