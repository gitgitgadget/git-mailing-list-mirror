From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: [PATCH] provide advance warning of some future pack default
	changes
Date: Mon, 17 Dec 2007 16:57:09 -0500
Message-ID: <20071217215709.GH13515@fieldses.org>
References: <alpine.LFD.0.999999.0712141724260.8467@xanadu.home> <20071214223957.GC7300@mail.oracle.com> <alpine.LFD.0.999999.0712141744460.8467@xanadu.home> <20071215004230.GF7300@mail.oracle.com> <alpine.LFD.0.999999.0712142114400.8467@xanadu.home> <20071217200920.GB19816@mail.oracle.com> <alpine.LFD.0.999999.0712171517320.8467@xanadu.home> <20071217211317.GC19816@mail.oracle.com> <20071217213049.GG13515@fieldses.org> <alpine.LFD.0.999999.0712171646230.8467@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Joel Becker <Joel.Becker@oracle.com>,
	Jakub Narebski <jnareb@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Mon Dec 17 22:58:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4NzF-000553-AT
	for gcvg-git-2@gmane.org; Mon, 17 Dec 2007 22:58:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763657AbXLQV6Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Dec 2007 16:58:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764093AbXLQV6P
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Dec 2007 16:58:15 -0500
Received: from mail.fieldses.org ([66.93.2.214]:60511 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1763657AbXLQV6M (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Dec 2007 16:58:12 -0500
Received: from bfields by fieldses.org with local (Exim 4.68)
	(envelope-from <bfields@fieldses.org>)
	id 1J4NxV-0008RJ-Q2; Mon, 17 Dec 2007 16:57:09 -0500
Content-Disposition: inline
In-Reply-To: <alpine.LFD.0.999999.0712171646230.8467@xanadu.home>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68634>

On Mon, Dec 17, 2007 at 04:52:16PM -0500, Nicolas Pitre wrote:
> On Mon, 17 Dec 2007, J. Bruce Fields wrote:
> 
> > By the way, just as a data point: I do keep some git repositories on
> > NFS, and access them from multiple machines with different git versions
> > (not on purpose--it's just that the machines don't all run the same
> > distro, so it'd be extra work to give them all the same version).  I
> > don't use anything older than 1.5.0.  If the repository became unusable
> > on one of those machines without warning it'd be annoying.
> 
> What the v1.5.5 release notes will say is that you'll have to set 
> pack.indexversion=1 to remain compatible with pre-1.5.2 Git versions.  

Is there any reason not to make pack.indexversion=1 the default (for
preexisting repositories at the very least) and suggest in the release
notes that people set something else if they want the features the new
version provides?

--b.

> And even if you forget about it then there'll be a simple way to regain 
> compatibility after the facts.
