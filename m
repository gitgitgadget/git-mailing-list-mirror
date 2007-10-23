From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: git.el fails on non-git managed files
Date: Tue, 23 Oct 2007 00:31:07 -0400
Message-ID: <20071023043107.GZ14735@spearce.org>
References: <1193077008.471ce910f15c5@imp.free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: racin@free.fr
X-From: git-owner@vger.kernel.org Tue Oct 23 06:31:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IkBQJ-0000gW-Rh
	for gcvg-git-2@gmane.org; Tue, 23 Oct 2007 06:31:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751095AbXJWEbM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Oct 2007 00:31:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751113AbXJWEbM
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Oct 2007 00:31:12 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:39255 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750852AbXJWEbL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Oct 2007 00:31:11 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1IkBQ5-0001Gk-EK; Tue, 23 Oct 2007 00:31:09 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id BF68620FBAE; Tue, 23 Oct 2007 00:31:07 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <1193077008.471ce910f15c5@imp.free.fr>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62085>

racin@free.fr wrote:
> I found the following on the development version of git.el: saving
> non-git-managed files in Emacs threw an error.
> 
> It is due to a simple error in the call to condition-case in a
> recently added function, git-update-save-file.
> 
> I attached the patch for your convenience.

I'm not sure what happened, but I didn't receive a patch with
your email.  Would you mind resending it to the list?  You may
also want to file a bug with your distribution to get the Emacs
bindings included.
 
-- 
Shawn.
