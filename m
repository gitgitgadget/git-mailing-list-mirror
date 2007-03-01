From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [EGIT PATCH 6/9] Add branch and StGit patch to decorator
Date: Wed, 28 Feb 2007 22:59:10 -0500
Message-ID: <20070301035909.GA8103@spearce.org>
References: <20070228222355.12021.13029.stgit@lathund.dewire.com> <20070228222637.12021.63285.stgit@lathund.dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Thu Mar 01 04:59:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMcRp-0002Ds-EG
	for gcvg-git@gmane.org; Thu, 01 Mar 2007 04:59:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751942AbXCAD7P (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 28 Feb 2007 22:59:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751992AbXCAD7P
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Feb 2007 22:59:15 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:47581 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751942AbXCAD7O (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Feb 2007 22:59:14 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HMcRY-0004Gj-FZ; Wed, 28 Feb 2007 22:59:00 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 8CFF620FBAE; Wed, 28 Feb 2007 22:59:10 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <20070228222637.12021.63285.stgit@lathund.dewire.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41034>

Robin Rosenberg <robin.rosenberg@dewire.com> wrote:
> +	public String getPatch() throws IOException {
> +		final File ptr = new File(getDirectory(),"patches/"+getBranch()+"/current");
> +		final BufferedReader br = new BufferedReader(new FileReader(ptr));
> +		final String line = br.readLine();
> +		return line;
> +	}

Last time I checked leaking a file descriptor was a bad idea.
I fixed it (in both methods) when I applied the patch.

Your whole series is now pushed. Thanks for the cleanups.

-- 
Shawn.
