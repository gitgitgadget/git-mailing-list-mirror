From: Jeff King <peff@peff.net>
Subject: Re: merge time
Date: Mon, 30 Jul 2007 04:41:38 -0400
Message-ID: <20070730084138.GA4100@coredump.intra.peff.net>
References: <alpine.LFD.0.999.0707291914451.3442@woody.linux-foundation.org> <6FE9FFD6-B5D7-4E1D-A4E8-B6D0E9517503@zib.de> <7vbqdumlo1.fsf@assigned-by-dhcp.cox.net> <E49A2B0B-DAA3-4A03-925D-D3D113F907F1@zib.de> <20070730074937.GT20052@spearce.org> <577C7529-4C3C-40D4-B86A-8B3CE888C997@zib.de> <20070730081439.GA907@coredump.intra.peff.net> <E1575DD6-AC8C-49FD-A765-801A19E1FA73@zib.de> <20070730083223.GB3150@coredump.intra.peff.net> <Pine.LNX.4.64.0707300133210.6478@asgard.lang.hm>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Steffen Prohaska <prohaska@zib.de>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Matthew L Foster <mfoster167@yahoo.com>, git@vger.kernel.org
To: david@lang.hm
X-From: git-owner@vger.kernel.org Mon Jul 30 10:41:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IFQoy-0008MK-CI
	for gcvg-git@gmane.org; Mon, 30 Jul 2007 10:41:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760045AbXG3Ill (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 30 Jul 2007 04:41:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758849AbXG3Ill
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Jul 2007 04:41:41 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1930 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759299AbXG3Ill (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jul 2007 04:41:41 -0400
Received: (qmail 11179 invoked from network); 30 Jul 2007 08:41:41 -0000
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by peff.net with (DHE-RSA-AES128-SHA encrypted) SMTP; 30 Jul 2007 08:41:41 -0000
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 30 Jul 2007 04:41:38 -0400
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0707300133210.6478@asgard.lang.hm>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54209>

On Mon, Jul 30, 2007 at 01:34:55AM -0700, david@lang.hm wrote:

> yes, but this entire thread was an attempt to avoid browsing the history and 
> instead figure out the relationships between commits by dates. so the people 
> wanting this don't care how ugly it makes the history (but since they want 
> to do this in other people's repositories this won't work for them either)

I think we drifted a bit from that with Steffen's original message...

If you followed a strict policy of always merging topics to a "base"
branch as your first parent, then never allowing fast forwards should
allow a very easy-to-read history in gitk. The left-most line of commits
would simply be a record of topics getting merged in, and would never
contain any "non-base" commits.

-Peff
