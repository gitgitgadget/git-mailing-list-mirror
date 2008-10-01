From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [EGIT PATCH 4/8] Align commit text properly in jgit glog
Date: Wed, 1 Oct 2008 07:38:15 -0700
Message-ID: <20081001143815.GV21310@spearce.org>
References: <1222818823-22780-1-git-send-email-robin.rosenberg@dewire.com> <1222818823-22780-2-git-send-email-robin.rosenberg@dewire.com> <1222818823-22780-3-git-send-email-robin.rosenberg@dewire.com> <1222818823-22780-4-git-send-email-robin.rosenberg@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Wed Oct 01 16:40:56 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kl2rN-0007Od-VN
	for gcvg-git-2@gmane.org; Wed, 01 Oct 2008 16:39:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751830AbYJAOiQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Oct 2008 10:38:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752313AbYJAOiQ
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Oct 2008 10:38:16 -0400
Received: from george.spearce.org ([209.20.77.23]:37344 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751537AbYJAOiQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Oct 2008 10:38:16 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id C3DEC3835F; Wed,  1 Oct 2008 14:38:15 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1222818823-22780-4-git-send-email-robin.rosenberg@dewire.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97224>

Robin Rosenberg <robin.rosenberg@dewire.com> wrote:
> Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
> ---
>  .../egit/ui/internal/history/SWTPlotRenderer.java  |    3 ---
>  .../org/spearce/jgit/awtui/AWTPlotRenderer.java    |    7 +++----
>  2 files changed, 3 insertions(+), 7 deletions(-)
> 
> diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/history/SWTPlotRenderer.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/history/SWTPlotRenderer.java
> index a58b3bf..7c286a4 100644
> --- a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/history/SWTPlotRenderer.java
> +++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/history/SWTPlotRenderer.java
> @@ -51,9 +51,6 @@ protected void finalize() throws Throwable {
>  		sys_blue.dispose();
>  		sys_gray.dispose();
>  		sys_darkblue.dispose();
> -		sys_yellow.dispose();
> -		sys_green.dispose();
> -		sys_white.dispose();
>  	}

Can't you squash this hunk to the prior commit, assuming the prior
commit is still a valid change?

-- 
Shawn.
