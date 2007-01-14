From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 4/4] Display a progress meter during merge-recursive.
Date: Sun, 14 Jan 2007 17:50:32 -0500
Message-ID: <20070114225031.GC10888@spearce.org>
References: <d352c8adb1ec1c4e74b33d51d397d5756b82ceac.1168752482.git.spearce@spearce.org> <20070114052858.GD19113@spearce.org> <Pine.LNX.4.63.0701141404160.22628@wbgn013.biozentrum.uni-wuerzburg.de> <7vwt3pfmph.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 15 20:09:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@m.gmane.org
Received: from main.gmane.org ([80.91.229.2] helo=ciao.gmane.org)
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H6W2D-0000KC-Hd
	for gcvg-git@m.gmane.org; Mon, 15 Jan 2007 18:54:17 +0100
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1H6V8L-0003eK-MQ
	for gcvg-git@m.gmane.org; Mon, 15 Jan 2007 17:56:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751694AbXANWui (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 14 Jan 2007 17:50:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751698AbXANWuh
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Jan 2007 17:50:37 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:55747 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751694AbXANWuh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Jan 2007 17:50:37 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1H6EBE-00013o-8D; Sun, 14 Jan 2007 17:50:24 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 2B27120FBAE; Sun, 14 Jan 2007 17:50:32 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vwt3pfmph.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36865>

Junio C Hamano <junkio@cox.net> wrote:
> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > this is a nice idea, but I think you lack a "if (!isatty(1)) do_progress = 
> > 0;" somewhere.
> 
> Very true.  Something like this?

Ack'd.  I see its already in next.  Thanks for the cleanup.

-- 
Shawn.
