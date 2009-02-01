From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [EGIT PATCH] Resurrect group filtering options in history pane
Date: Sun, 1 Feb 2009 14:39:20 -0800
Message-ID: <20090201223920.GQ26880@spearce.org>
References: <1233520578-10453-1-git-send-email-robin.rosenberg@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Sun Feb 01 23:40:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LTkzf-0007lk-1h
	for gcvg-git-2@gmane.org; Sun, 01 Feb 2009 23:40:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752969AbZBAWjV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Feb 2009 17:39:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752410AbZBAWjV
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Feb 2009 17:39:21 -0500
Received: from george.spearce.org ([209.20.77.23]:51478 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752137AbZBAWjU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Feb 2009 17:39:20 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id 1B77638210; Sun,  1 Feb 2009 22:39:20 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1233520578-10453-1-git-send-email-robin.rosenberg@dewire.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108017>

Robin Rosenberg <robin.rosenberg@dewire.com> wrote:
> This commit restores the ability to filter on not only the selected
> resource but instead all changes in the same folder, same project
> or same repository. The filtering levels supported are Resource (no button
> pessed), Folder, Project and Repository. Only the highest level has any
> effect. The flags are persistent between eclipse sessions in the same
> workspace.

Shouldn't these filtering flag buttons be exclusive buttons,
in the sense that only one can be depressed at a time, or none
are depressed?

I managed to depress R,P,F by doing it in the opposite order (push
F, then P, then R) and I have no clue what that should really mean
when looking at the history.

Also, the R/P/F labels are a bit too similar.  I know its what we
had before, but these are blending too much to me visually and I
keep reading the F as though it were a misdrawn R or P, like the
box isn't big enough for it.  Which actually has me thinking that
with the proportional width font on my workbench the F is using a
narrower button box than the R or P, which looks funny.

> diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/history/GitHistoryPage.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/history/GitHistoryPage.java
> index d718cd7..4e95df4 100644
> --- a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/history/GitHistoryPage.java
> +++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/history/GitHistoryPage.java
> @@ -96,7 +96,7 @@
>  
>  	/**
>  	 * Determine if the input can be shown in this viewer.
> -	 * 
> +	 *
>  	 * @param object
>  	 *            an object that is hopefully of type ResourceList or IResource,
>  	 *            but may be anything (including null).

Unnecessary re-formatting hunk.  Please discard from the patch.

-- 
Shawn.
