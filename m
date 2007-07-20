From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] Internationalization of git-gui
Date: Fri, 20 Jul 2007 01:04:56 -0400
Message-ID: <20070720050455.GN32566@spearce.org>
References: <622391.43998.qm@web38909.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Christian Stimming <stimming@tuhh.de>, git@vger.kernel.org,
	Paul Mackerras <paulus@samba.org>
To: Brett Schwarz <brett_schwarz@yahoo.com>
X-From: git-owner@vger.kernel.org Fri Jul 20 07:05:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IBkg1-0007rb-8K
	for gcvg-git@gmane.org; Fri, 20 Jul 2007 07:05:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750982AbXGTFFE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Jul 2007 01:05:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750986AbXGTFFD
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Jul 2007 01:05:03 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:49527 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750975AbXGTFFB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jul 2007 01:05:01 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.66)
	(envelope-from <spearce@spearce.org>)
	id 1IBkfh-0001fw-V1; Fri, 20 Jul 2007 01:04:58 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 7BA2520FBAE; Fri, 20 Jul 2007 01:04:56 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <622391.43998.qm@web38909.mail.mud.yahoo.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53052>

Brett Schwarz <brett_schwarz@yahoo.com> wrote:
> This is a good idea. However, I assume the _ proc is just sugar. It
> might be better to follow a more "standard" way for this, and just
> import the msgcat namespace, and then you can just use [mc]. For
> example:
> 
> package require msgcat
> namespace import ::msgcat::*
>   .
>   .
>   .
> .mbar add cascade -label [mc Repository] -menu .mbar.repository

Not just better, I'd prefer it.  The proc name "_" is cute but
is just too darn short.  I would much prefer to use "mc" and just
say that "mc" in all of git-gui's namespaces is reserved for the
message catalog, much as "cb" is already reserved for setting up
callbacks for Tcl/Tk event handlers.

-- 
Shawn.
