From: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Subject: Re: [PATCH 3/3] Allow whole-tree operations to be started from a subdirectory
Date: Sun, 14 Jan 2007 01:39:25 +0100
Message-ID: <200701140139.26120.Josef.Weidendorfer@gmx.de>
References: <7v8xg9x8uu.fsf@assigned-by-dhcp.cox.net> <200701140111.20671.Josef.Weidendorfer@gmx.de> <20070114002152.GA18277@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>,
	Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 14 01:39:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H5tPM-0006xQ-GC
	for gcvg-git@gmane.org; Sun, 14 Jan 2007 01:39:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750869AbXANAje (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 13 Jan 2007 19:39:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750899AbXANAje
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Jan 2007 19:39:34 -0500
Received: from mail.gmx.net ([213.165.64.20]:48255 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750869AbXANAjd (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Jan 2007 19:39:33 -0500
Received: (qmail invoked by alias); 14 Jan 2007 00:39:32 -0000
Received: from p5496ACD6.dip0.t-ipconnect.de (EHLO noname) [84.150.172.214]
  by mail.gmx.net (mp017) with SMTP; 14 Jan 2007 01:39:32 +0100
X-Authenticated: #352111
To: "Shawn O. Pearce" <spearce@spearce.org>
User-Agent: KMail/1.9.5
In-Reply-To: <20070114002152.GA18277@spearce.org>
Content-Disposition: inline
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36784>

On Sunday 14 January 2007 01:21, Shawn O. Pearce wrote:
> Josef Weidendorfer <Josef.Weidendorfer@gmx.de> wrote:
> > The wish to allow git-fetch from subdirectories is the
> > inconvenience to have to cd up, and later down. This is
> > avoided by running "git --top fetch", and theses people
> > should be happy.
> 
> But not only that, git-fetch *never* alters the working directory.

Ah, typo.
s/fetch/merge/ (or pull, rebase, ...)

Josef
