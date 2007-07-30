From: Jeff King <peff@peff.net>
Subject: Re: merge time
Date: Mon, 30 Jul 2007 04:31:56 -0400
Message-ID: <20070730083156.GA3150@coredump.intra.peff.net>
References: <241612.78983.qm@web51007.mail.re2.yahoo.com> <alpine.LFD.0.999.0707291914451.3442@woody.linux-foundation.org> <6FE9FFD6-B5D7-4E1D-A4E8-B6D0E9517503@zib.de> <7vbqdumlo1.fsf@assigned-by-dhcp.cox.net> <E49A2B0B-DAA3-4A03-925D-D3D113F907F1@zib.de> <20070730074937.GT20052@spearce.org> <577C7529-4C3C-40D4-B86A-8B3CE888C997@zib.de> <20070730081439.GA907@coredump.intra.peff.net> <7vhcnml2no.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Steffen Prohaska <prohaska@zib.de>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Matthew L Foster <mfoster167@yahoo.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 30 10:32:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IFQft-0006Do-5x
	for gcvg-git@gmane.org; Mon, 30 Jul 2007 10:32:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759578AbXG3IcA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 30 Jul 2007 04:32:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759537AbXG3IcA
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Jul 2007 04:32:00 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4375 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759374AbXG3Ib7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jul 2007 04:31:59 -0400
Received: (qmail 10973 invoked from network); 30 Jul 2007 08:31:59 -0000
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by peff.net with (DHE-RSA-AES128-SHA encrypted) SMTP; 30 Jul 2007 08:31:59 -0000
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 30 Jul 2007 04:31:56 -0400
Content-Disposition: inline
In-Reply-To: <7vhcnml2no.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54205>

On Mon, Jul 30, 2007 at 01:24:43AM -0700, Junio C Hamano wrote:

> But it is not hard.  If it is a fast forward in reality but you
> are marking it as a real merge by creating a merge commit, then:

Of course, I was not thinking right. I was considering the difficulty of
invoking the merge machinery, but of course by definition for a
fast-forward you don't have to.

> when other is a fast forward of HEAD would do:
> 
> 	git commit-tree other^{tree} -p HEAD -p other

Yes, that makes sense.

-Peff
