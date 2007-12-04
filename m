From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] Reorder msgfmt command-line arguments.
Date: Mon, 3 Dec 2007 21:07:48 -0500
Message-ID: <20071204020748.GZ14735@spearce.org>
References: <20071203012631.GA22450@crustytoothpaste.ath.cx> <Pine.LNX.4.64.0712031034200.27959@racer.site> <20071203170402.GA13712@crustytoothpaste.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: "brian m. carlson" <sandals@crustytoothpaste.ath.cx>
X-From: git-owner@vger.kernel.org Tue Dec 04 03:08:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IzNCn-0001Gc-PU
	for gcvg-git-2@gmane.org; Tue, 04 Dec 2007 03:08:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750914AbXLDCHy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Dec 2007 21:07:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750813AbXLDCHy
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Dec 2007 21:07:54 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:50191 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750818AbXLDCHx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Dec 2007 21:07:53 -0500
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1IzNCF-0004uv-Ny; Mon, 03 Dec 2007 21:07:39 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id DB3E720FBAE; Mon,  3 Dec 2007 21:07:48 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <20071203170402.GA13712@crustytoothpaste.ath.cx>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66992>

"brian m. carlson" <sandals@crustytoothpaste.ath.cx> wrote:
> On Mon, Dec 03, 2007 at 10:35:33AM +0000, Johannes Schindelin wrote:
> >On Mon, 3 Dec 2007, brian m. carlson wrote:
> >
> >>Any program using getopt or getopt_long will stop processing options 
> >>once a non-option argument has been encountered, if POSIXLY_CORRECT is 
> >>set.
...
> >Besides, you probably want to send this as a git-gui patch: based on 
> >git-gui.git, not git.git, and Cc'ed to Shawn Pearce.
> 
> Thanks.  Will do.

Don't bother.  I already did the necesary work to apply this patch
to the git-gui.git tree.  It was small, obviously correct, and easy
to fix up to make it apply to git-gui.git.  Its already pushed out
in my master branch and will be in gitgui-0.9.1.

-- 
Shawn.
