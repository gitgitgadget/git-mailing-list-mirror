From: Jeff King <peff@peff.net>
Subject: Re: [RFC/PATCH] commit-tree: bump MAX_PARENTS to 128
Date: Tue, 27 Feb 2007 03:19:33 -0500
Message-ID: <20070227081933.GA13021@coredump.intra.peff.net>
References: <20070226121557.GA18114@coredump.intra.peff.net> <20070226143142.GA1390@spearce.org> <Pine.LNX.4.63.0702261736570.22628@wbgn013.biozentrum.uni-wuerzburg.de> <7vr6scj9qt.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Feb 27 09:19:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HLxYi-0006T7-L8
	for gcvg-git@gmane.org; Tue, 27 Feb 2007 09:19:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751497AbXB0ITi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Feb 2007 03:19:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932096AbXB0ITi
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Feb 2007 03:19:38 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2930 "HELO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751553AbXB0ITh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Feb 2007 03:19:37 -0500
Received: (qmail 12508 invoked from network); 27 Feb 2007 03:19:49 -0500
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by 66-23-211-5.clients.speedfactory.net with SMTP; 27 Feb 2007 03:19:49 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 27 Feb 2007 03:19:33 -0500
Content-Disposition: inline
In-Reply-To: <7vr6scj9qt.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40700>

On Tue, Feb 27, 2007 at 12:16:42AM -0800, Junio C Hamano wrote:

> But as Shawn pointed out, Octopus makes bisect less (much less)
> efficient for the end users, I tend to think the current 16 is
> already insanely large.

Did you look at my "why I need a huge octopus" description? Is there a
better way to do it? Should I simply do a bunch of pair-wise merges?
I'll almost certainly never bisect it, but the octopus "looks right" in
gitk (though I have to admit, it's really not _that_ big a deal -- it's
almost more readable to look at pairwise merges anyway).

-Peff
