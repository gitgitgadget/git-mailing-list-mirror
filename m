From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Question: next, master and pu branches
Date: Fri, 2 Feb 2007 01:57:35 -0500
Message-ID: <20070202065735.GA20832@spearce.org>
References: <200702021142.08975.litvinov2004@gmail.com> <20070202060030.GA20442@spearce.org> <200702021254.44992.litvinov2004@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Alexander Litvinov <litvinov2004@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 02 07:57:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HCsMj-0001jJ-IF
	for gcvg-git@gmane.org; Fri, 02 Feb 2007 07:57:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423161AbXBBG5m (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Feb 2007 01:57:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423164AbXBBG5m
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Feb 2007 01:57:42 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:39634 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423161AbXBBG5m (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Feb 2007 01:57:42 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HCsMd-0005ra-Ru; Fri, 02 Feb 2007 01:57:39 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 9FB5A20FBAE; Fri,  2 Feb 2007 01:57:35 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <200702021254.44992.litvinov2004@gmail.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38466>

Alexander Litvinov <litvinov2004@gmail.com> wrote:
> > You can let git-rerere help you to manage conflicts which might
> > reoccur during merges.  If you create the .git/rr-cache directory
> > then git-commit and git-merge will automatically use git-rerere to
> > help you.
> 
> Yes git-rerere is a black magic tool, but it works :-)
> Byt he way, why git-pull (or possible git-merge) does not commit the merge 
> result after conflict was fixed by git-rerere ?

No, it doesn't.  That way you can review the result of the merge
first and verify its indeed correct.

-- 
Shawn.
