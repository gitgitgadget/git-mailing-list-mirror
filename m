From: bdowning@lavos.net (Brian Downing)
Subject: Re: [PATCH] git-gui: Handle git versions of the form n.n.n.GIT
Date: Tue, 17 Jul 2007 16:40:12 -0500
Message-ID: <20070717214011.GU19073@lavos.net>
References: <Pine.LNX.4.64.0707171244080.13359@reaper.quantumfyre.co.uk> <20070717212103.11950.10363.julian@quantumfyre.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Julian Phillips <julian@quantumfyre.co.uk>
X-From: git-owner@vger.kernel.org Tue Jul 17 23:40:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IAumW-0000px-6X
	for gcvg-git@gmane.org; Tue, 17 Jul 2007 23:40:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756867AbXGQVk0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Jul 2007 17:40:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754512AbXGQVkZ
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Jul 2007 17:40:25 -0400
Received: from gateway.insightbb.com ([74.128.0.19]:27307 "EHLO
	asav04.insightbb.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758078AbXGQVkX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jul 2007 17:40:23 -0400
Received: from 74-134-246-243.dhcp.insightbb.com (HELO mail.lavos.net) ([74.134.246.243])
  by asav04.insightbb.com with ESMTP; 17 Jul 2007 17:40:22 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AjMzAJTTnEZKhvbzRmdsb2JhbACHLogMAQEBNQ
Received: by mail.lavos.net (Postfix, from userid 1000)
	id 471FD309F32; Tue, 17 Jul 2007 16:40:13 -0500 (CDT)
Content-Disposition: inline
In-Reply-To: <20070717212103.11950.10363.julian@quantumfyre.co.uk>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52803>

On Tue, Jul 17, 2007 at 10:14:06PM +0100, Julian Phillips wrote:
> The git-gui version check doesn't handle versions of the form
> n.n.n.GIT which you can get by installing from an tarball produced by
> git-archive.
> 
> Without this change you get an error of the form:
> 'Error in startup script: expected version number but got "1.5.3.GIT"'

Can we handle versions with '-dirty' at the end as well, or is this
ill-advised?  For some reason when I build my hacked-up personal debian
packages it usually winds up:

:; git --version
git version 1.5.3.GIT-dirty

and I haven't bothered to find out why.

-bcd
