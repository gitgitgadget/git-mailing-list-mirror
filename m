From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [ANNOUNCE] pg - A patch porcelain for GIT
Date: Sun, 12 Feb 2006 22:29:03 -0500
Message-ID: <20060213032903.GA32121@spearce.org>
References: <20060210195914.GA1350@spearce.org> <43EFF3D0.4090701@vilain.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Feb 13 04:29:19 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F8UOs-0002uu-2K
	for gcvg-git@gmane.org; Mon, 13 Feb 2006 04:29:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750979AbWBMD3J (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 12 Feb 2006 22:29:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751563AbWBMD3I
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Feb 2006 22:29:08 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:48833 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S1750979AbWBMD3H (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Feb 2006 22:29:07 -0500
Received: from cpe-72-226-60-173.nycap.res.rr.com ([72.226.60.173] helo=asimov.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1F8UOU-0007s8-Gg; Sun, 12 Feb 2006 22:28:54 -0500
Received: by asimov.spearce.org (Postfix, from userid 1000)
	id 9604A20FBA0; Sun, 12 Feb 2006 22:29:03 -0500 (EST)
To: Sam Vilain <sam@vilain.net>
Mail-Followup-To: Sam Vilain <sam@vilain.net>,
	Git Mailing List <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <43EFF3D0.4090701@vilain.net>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16039>

Sam Vilain <sam@vilain.net> wrote:
> Shawn Pearce wrote:
> >I just posted the first public version of pg, a GIT porcelain for
> >managing patches.  Think StGIT, but better in some ways:
> >
> >Feature Summary:
> >- Maximum compatibility with other GIT porcelains.
> >- Simplified command line user interface.
> 
> How do I edit the description of an existing patch using pg?  Perhaps an
> option to pg-push ?

There isn't any description associated with a patch beyond its name
(which can be changed with pg-rename).  Unlike StGIT pg currently
doesn't store a description with each patch.

This is partly because I want pg to extract the comments given to
pg-ci to make the description of the patch during an export with
pg-export - but I haven't written the code to walk back along the
related commits and extract each comment.  On the other hand this
might not be the best description for a patch.  :-)

-- 
Shawn.
