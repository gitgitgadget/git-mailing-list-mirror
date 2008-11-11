From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [EGIT PATCH 6/7] Add tags to the graphical history display.
Date: Tue, 11 Nov 2008 10:28:16 -0800
Message-ID: <20081111182816.GQ2932@spearce.org>
References: <1226095664-13759-1-git-send-email-robin.rosenberg@dewire.com> <1226095664-13759-2-git-send-email-robin.rosenberg@dewire.com> <1226095664-13759-3-git-send-email-robin.rosenberg@dewire.com> <1226095664-13759-4-git-send-email-robin.rosenberg@dewire.com> <1226095664-13759-5-git-send-email-robin.rosenberg@dewire.com> <1226095664-13759-6-git-send-email-robin.rosenberg@dewire.com> <1226095664-13759-7-git-send-email-robin.rosenberg@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Tue Nov 11 19:29:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KzxzZ-0004lk-Qa
	for gcvg-git-2@gmane.org; Tue, 11 Nov 2008 19:29:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754416AbYKKS2R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Nov 2008 13:28:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754387AbYKKS2R
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Nov 2008 13:28:17 -0500
Received: from george.spearce.org ([209.20.77.23]:38623 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754307AbYKKS2Q (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Nov 2008 13:28:16 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id 1CC3A381FF; Tue, 11 Nov 2008 18:28:16 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1226095664-13759-7-git-send-email-robin.rosenberg@dewire.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100668>

Robin Rosenberg <robin.rosenberg@dewire.com> wrote:
> @@ -92,7 +104,64 @@ protected void drawText(final String msg, final int x, final int y) {
>  		g.drawString(msg, cellX + x, cellY + texty, true);
>  	}

My SWTPlotRenderer doesn't have this context line.  Am I missing
a patch in the series?
  
> +	@Override
> +	protected int drawLabel(int x, int y, Ref ref) {

-- 
Shawn.
