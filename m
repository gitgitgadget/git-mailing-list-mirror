From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: merge doesn't remove files
Date: Sat, 3 Feb 2007 22:50:37 -0500
Message-ID: <20070204035037.GB16766@spearce.org>
References: <20070203224819.20131.qmail@b1b53206edee41.315fe32.mid.smarden.org> <7vy7nezr1f.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Gerrit Pape <pape@smarden.org>, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun Feb 04 04:50:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HDYOr-0000bS-A4
	for gcvg-git@gmane.org; Sun, 04 Feb 2007 04:50:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752009AbXBDDuo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 3 Feb 2007 22:50:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752015AbXBDDuo
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Feb 2007 22:50:44 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:50374 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752009AbXBDDun (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Feb 2007 22:50:43 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HDYOZ-0002QD-MA; Sat, 03 Feb 2007 22:50:27 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 1FDA620FBAE; Sat,  3 Feb 2007 22:50:38 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <7vy7nezr1f.fsf@assigned-by-dhcp.cox.net>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38643>

Junio C Hamano <junkio@cox.net> wrote:
> Gerrit Pape <pape@smarden.org> writes:
> 
> > Shouldn't git remove the original file after merging a commit that moved
> > the file away?
> 
> I think this has been fixed quite a while ago --- does not seem
> to reproduce with the current v1.5.0-rc.

Indeed, this commit of mine was supposed to fix it:

  commit 8371234ecaaf6e14fe3f2082a855eff1bbd79ae9
  Author: Shawn Pearce <spearce@spearce.org>
  Date:   Wed Dec 13 05:42:44 2006 -0500

Its in 1.5.0-rc0, but nothing earlier.

-- 
Shawn.
