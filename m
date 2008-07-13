From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 2/2 (for GIT-GUI)] git-gui: MERGE_RR lives in .git/
	directly with newer Git versions
Date: Sun, 13 Jul 2008 01:16:23 +0000
Message-ID: <20080713011623.GC31050@spearce.org>
References: <87skufmjg4.fsf@Astalo.kon.iki.fi> <alpine.DEB.1.00.0807121553120.8950@racer> <alpine.DEB.1.00.0807121556480.8950@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Kalle Olavi Niemitalo <kon@iki.fi>, git@vger.kernel.org,
	gitster@pobox.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Jul 13 03:17:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KHqDM-0001yJ-VG
	for gcvg-git-2@gmane.org; Sun, 13 Jul 2008 03:17:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752131AbYGMBQY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Jul 2008 21:16:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752279AbYGMBQY
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Jul 2008 21:16:24 -0400
Received: from george.spearce.org ([209.20.77.23]:38765 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751648AbYGMBQX (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Jul 2008 21:16:23 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 7AFFD382A6; Sun, 13 Jul 2008 01:16:23 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0807121556480.8950@racer>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88280>

Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> 
> Now that MERGE_RR was moved out of .git/rr-cache/, we have to delete
> it somewhere else.  Just in case somebody wants to use a newer git-gui
> with an older Git, the file .git/rr-cache/MERGE_RR is removed, too (if
> it exists).
> 
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>

Ack, I can pull this into git-gui.git.  But I want to make sure
Junio is going to take 1/2 into git.git.


>  git-gui/lib/merge.tcl |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/lib/merge.tcl b/lib/merge.tcl
> index cc26b07..5c01875 100644
> --- a/lib/merge.tcl
> +++ b/lib/merge.tcl
> @@ -257,6 +257,7 @@ proc _reset_wait {fd} {
>  
>  		catch {file delete [gitdir MERGE_HEAD]}
>  		catch {file delete [gitdir rr-cache MERGE_RR]}
> +		catch {file delete [gitdir MERGE_RR]}
>  		catch {file delete [gitdir SQUASH_MSG]}
>  		catch {file delete [gitdir MERGE_MSG]}
>  		catch {file delete [gitdir GITGUI_MSG]}
> -- 

-- 
Shawn.
