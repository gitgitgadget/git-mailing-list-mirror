From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [EGIT PATCH 2/8] Move AWTPlotRenderer to its own file.
Date: Wed, 1 Oct 2008 07:32:29 -0700
Message-ID: <20081001143229.GT21310@spearce.org>
References: <1222818823-22780-1-git-send-email-robin.rosenberg@dewire.com> <1222818823-22780-2-git-send-email-robin.rosenberg@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Wed Oct 01 16:36:17 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kl2lt-0004gP-Re
	for gcvg-git-2@gmane.org; Wed, 01 Oct 2008 16:33:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752145AbYJAOca (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Oct 2008 10:32:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752124AbYJAOca
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Oct 2008 10:32:30 -0400
Received: from george.spearce.org ([209.20.77.23]:47713 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751999AbYJAOca (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Oct 2008 10:32:30 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 6AF0E3835F; Wed,  1 Oct 2008 14:32:29 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1222818823-22780-2-git-send-email-robin.rosenberg@dewire.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97222>

Robin Rosenberg <robin.rosenberg@dewire.com> wrote:
> This is mostly a convenience issue as it allows the
> use of the JVM hotswap feature while debugging.
> 
> Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
> ---
>  .../org/spearce/jgit/awtui/AWTPlotRenderer.java    |  104 ++++++++++++++++++++
>  .../org/spearce/jgit/awtui/CommitGraphPane.java    |   92 -----------------
>  2 files changed, 104 insertions(+), 92 deletions(-)
>  create mode 100644 org.spearce.jgit/src/org/spearce/jgit/awtui/AWTPlotRenderer.java
> 
> diff --git a/org.spearce.jgit/src/org/spearce/jgit/awtui/AWTPlotRenderer.java b/org.spearce.jgit/src/org/spearce/jgit/awtui/AWTPlotRenderer.java
> new file mode 100644
> index 0000000..a9933a4
> --- /dev/null
> +++ b/org.spearce.jgit/src/org/spearce/jgit/awtui/AWTPlotRenderer.java
> @@ -0,0 +1,104 @@
> +/**
> + * 
> + */
> +package org.spearce.jgit.awtui;

Missing copyright from the old sources.  Please carry over the
existing copyright header.

-- 
Shawn.
