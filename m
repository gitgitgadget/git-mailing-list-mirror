From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [JGIT PATCH 0/3] Request for help: graph-based UI
Date: Sat, 25 Jul 2009 13:59:36 -0700
Message-ID: <20090725205936.GF11191@spearce.org>
References: <cover.1247408350u.git.johannes.schindelin@gmx.de> <200907212140.32520.robin.rosenberg@dewire.com> <ed88cb980907251354o3c5e9007t4de328d0c4cdea52@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Robin Rosenberg <robin.rosenberg@dewire.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	git@vger.kernel.org
To: Douglas Campos <douglas@theros.info>
X-From: git-owner@vger.kernel.org Sat Jul 25 22:59:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MUoLI-00022U-MD
	for gcvg-git-2@gmane.org; Sat, 25 Jul 2009 22:59:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752620AbZGYU7g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Jul 2009 16:59:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752618AbZGYU7g
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Jul 2009 16:59:36 -0400
Received: from george.spearce.org ([209.20.77.23]:45143 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752414AbZGYU7g (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Jul 2009 16:59:36 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id BD1DD381FD; Sat, 25 Jul 2009 20:59:36 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <ed88cb980907251354o3c5e9007t4de328d0c4cdea52@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124069>

Douglas Campos <douglas@theros.info> wrote:
> Just a question.. all graphic things that we implement in swing aren't
> usable inside eclipse with swt-awt bridge?

They should be usuable inside the SWT-AWT bridge, but that bridge
is really dicey to get working right sometimes.  I had a lot of
trouble with it at my prior day-job and am happy I no longer have
to deal with it.

For the most part, SWT and AWT are similar enough in their rendering
that its possible to build most of a layout algorithm to be rendering
API agnostic, and then permit implementation of AWT and SWT backends.
But that still is duplicated effort, vs. straightforward code reuse.

-- 
Shawn.
