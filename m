From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: How to set git commit timestamp
Date: Mon, 7 May 2007 21:57:02 -0400
Message-ID: <20070508015702.GE11311@spearce.org>
References: <Pine.LNX.4.64.0705061759210.8165@bianca.dialin.t-online.de> <200705062151.40261.robin.rosenberg.lists@dewire.com> <20070508013833.GB11311@spearce.org> <f1ol0d$tcd$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 08 03:57:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HlEwx-0005vT-4g
	for gcvg-git@gmane.org; Tue, 08 May 2007 03:57:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966599AbXEHB5I (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 7 May 2007 21:57:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754334AbXEHB5I
	(ORCPT <rfc822;git-outgoing>); Mon, 7 May 2007 21:57:08 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:51512 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753640AbXEHB5G (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 May 2007 21:57:06 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HlEwf-0002bU-46; Mon, 07 May 2007 21:56:53 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 0541E20FBAE; Mon,  7 May 2007 21:57:02 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <f1ol0d$tcd$1@sea.gmane.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46513>

Jakub Narebski <jnareb@gmail.com> wrote:
> By the way, is there fast-import version of git-quiltimport?

No, and I don't think its easy.  Isn't a quilt patchstack stored
as a series of patch files?  So "importing" it into Git requires
applying the patch to the base tree, then writing that base tree
to the ODB.  fast-import doesn't know how to run git-apply, though
Junio and I did kick it around (generally) a few months ago on #git.

-- 
Shawn.
