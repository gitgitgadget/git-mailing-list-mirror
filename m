From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 1/4] Remove unnecessary call_depth parameter in merge-recursive.
Date: Sun, 14 Jan 2007 17:44:57 -0500
Message-ID: <20070114224457.GB10888@spearce.org>
References: <20070114052832.GA19113@spearce.org> <20070114193503.GB2378@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 15 19:31:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@m.gmane.org
Received: from main.gmane.org ([80.91.229.2] helo=ciao.gmane.org)
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H6VWO-0000mA-2J
	for gcvg-git@m.gmane.org; Mon, 15 Jan 2007 18:21:24 +0100
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1H6V8K-0003eK-Jt
	for gcvg-git@m.gmane.org; Mon, 15 Jan 2007 17:56:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751692AbXANWpF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 14 Jan 2007 17:45:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751697AbXANWpF
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Jan 2007 17:45:05 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:55581 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751692AbXANWpD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Jan 2007 17:45:03 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1H6E5p-0000qn-N9; Sun, 14 Jan 2007 17:44:49 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 8F5AC20FBAE; Sun, 14 Jan 2007 17:44:57 -0500 (EST)
To: Alex Riesen <raa.lkml@gmail.com>
Content-Disposition: inline
In-Reply-To: <20070114193503.GB2378@steel.home>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36828>

Alex Riesen <fork0@t-online.de> wrote:
> Shawn O. Pearce, Sun, Jan 14, 2007 06:28:33 +0100:
> > Because the output_indent always matches the call_depth value
> > there is no reason to pass around the call_depth to the merge
> > function during each recursive invocation.
> 
> Actually, you removed output_indent, not call_depth.

Yeaaaaa.  That happened because I amended the commit.  The first
version of it kept output_indent and replaced all call_depth with
output_indent.  I was then going to do another patch to rename
output_indent -> call_depth, but I noticed the patch would be
about the same size as that one and would affect the same lines,
so I just amended it.  Then I didn't edit the commit message.

-- 
Shawn.
