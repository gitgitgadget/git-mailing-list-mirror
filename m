From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [EGIT PATCH] Resurrect group filtering options in history view
Date: Thu, 5 Feb 2009 08:14:10 -0800
Message-ID: <20090205161410.GJ26880@spearce.org>
References: <1233787393-21023-1-git-send-email-robin.rosenberg@dewire.com> <1233789799-24333-1-git-send-email-robin.rosenberg@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Thu Feb 05 17:16:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LV6t9-0004gJ-5a
	for gcvg-git-2@gmane.org; Thu, 05 Feb 2009 17:15:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754925AbZBEQOO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Feb 2009 11:14:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753243AbZBEQOM
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Feb 2009 11:14:12 -0500
Received: from george.spearce.org ([209.20.77.23]:41348 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750885AbZBEQOL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Feb 2009 11:14:11 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id 9FBD338210; Thu,  5 Feb 2009 16:14:10 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1233789799-24333-1-git-send-email-robin.rosenberg@dewire.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108575>

Robin Rosenberg <robin.rosenberg@dewire.com> wrote:
> This commit restores the ability to filter on not only the selected
> resource but instead all changes in the same folder, same project
> or same repository. The flag is persistent.
> 
> Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
> ---
> 
> Same thing, not not adding the NON-NLS stuff tof UIIcons and UIText. We
> should use SuppressWarnings for those files.

Looks good, thanks.  :-)
 
>  org.spearce.egit.ui/icons/elcl16/filterfolder.gif  |  Bin 0 -> 153 bytes
>  org.spearce.egit.ui/icons/elcl16/filterproject.gif |  Bin 0 -> 154 bytes
>  org.spearce.egit.ui/icons/elcl16/filterrepo.gif    |  Bin 0 -> 322 bytes
>  .../src/org/spearce/egit/ui/UIIcons.java           |   12 ++
>  .../src/org/spearce/egit/ui/UIText.java            |    9 ++
>  .../egit/ui/internal/history/GitHistoryPage.java   |  113 +++++++++++++++++++-
>  .../src/org/spearce/egit/ui/uitext.properties      |    4 +
>  7 files changed, 134 insertions(+), 4 deletions(-)
>  create mode 100644 org.spearce.egit.ui/icons/elcl16/filterfolder.gif
>  create mode 100644 org.spearce.egit.ui/icons/elcl16/filterproject.gif
>  create mode 100644 org.spearce.egit.ui/icons/elcl16/filterrepo.gif

-- 
Shawn.
