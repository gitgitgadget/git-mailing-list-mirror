From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Merge git-gui into 1.5.0 ?
Date: Sun, 11 Feb 2007 18:02:04 -0500
Message-ID: <20070211230204.GE31488@spearce.org>
References: <20070211084030.GE2082@spearce.org> <7vwt2oba8s.fsf@assigned-by-dhcp.cox.net> <20070211224158.GA31488@spearce.org> <Pine.LNX.4.63.0702112351270.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Feb 12 00:02:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HGNi1-000378-GB
	for gcvg-git@gmane.org; Mon, 12 Feb 2007 00:02:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932821AbXBKXCK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Feb 2007 18:02:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932915AbXBKXCK
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Feb 2007 18:02:10 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:51994 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932821AbXBKXCJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Feb 2007 18:02:09 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HGNhj-0003VD-WF; Sun, 11 Feb 2007 18:01:56 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 1257120FBAE; Sun, 11 Feb 2007 18:02:04 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0702112351270.22628@wbgn013.biozentrum.uni-wuerzburg.de>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39323>

Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > It may make patching slightly more interesting though, as some
> > users new to git-gui development may generate a patch in git.git
> > (using a/git-gui/git-gui.sh as the path) which then would not apply
> > as-is to the master git-gui development tree.
> 
> In this case, a "-p <n>" option to git-am would make sense, no?

Are you saying we just suddenly found a vaild use for a flag which
nobody (except the original submitter) thought was useful?  ;-)

Yes, clearly a -p<n> on git-am would solve the problem quite nicely.

-- 
Shawn.
