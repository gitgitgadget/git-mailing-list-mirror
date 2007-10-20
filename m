From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] git-cherry-pick: improve description of -x.
Date: Fri, 19 Oct 2007 23:19:17 -0400
Message-ID: <20071020031917.GR14735@spearce.org>
References: <20071019174134.GD9906@ins.uni-bonn.de> <20071019211152.GN3917@planck.djpig.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Frank Lichtenheld <frank@lichtenheld.de>, git@vger.kernel.org
To: Ralf Wildenhues <Ralf.Wildenhues@gmx.de>
X-From: git-owner@vger.kernel.org Sat Oct 20 05:19:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ij4sA-00067S-FM
	for gcvg-git-2@gmane.org; Sat, 20 Oct 2007 05:19:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755868AbXJTDTX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Oct 2007 23:19:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754410AbXJTDTX
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Oct 2007 23:19:23 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:42013 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751296AbXJTDTW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Oct 2007 23:19:22 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1Ij4ri-0003SH-Fr; Fri, 19 Oct 2007 23:19:06 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id B400120FBAE; Fri, 19 Oct 2007 23:19:17 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20071019211152.GN3917@planck.djpig.de>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61779>

Frank Lichtenheld <frank@lichtenheld.de> wrote:
> On Fri, Oct 19, 2007 at 07:41:34PM +0200, Ralf Wildenhues wrote:
> > Further, I am surprised that -x seems to be nonfunctional when the
> > cherry pick introduces a conflict.  Example:
> [...]
> > The prototype commit message now does not contain the
> > | (cherry picked from commit ...).
> > 
> > Is that by design (because there were conflicts) or an omission?
> > In case of the former, maybe the description of -x should mention this.
> 
> git commit currently doesn't know that you commit a cherry-pick. The -c
> only says to use the commit message of the original commit. So this is
> currently by design.

Ralf, can you submit an updated version of this patch that describes
the current behavior better, given the "by design" remark above
from Frank?
 
-- 
Shawn.
