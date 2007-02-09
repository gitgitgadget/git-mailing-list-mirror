From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: git log filtering
Date: Thu, 8 Feb 2007 19:23:44 -0500
Message-ID: <20070209002344.GF1556@spearce.org>
References: <Pine.LNX.4.64.0702070856190.8424@woody.linux-foundation.org> <Pine.LNX.4.63.0702071822430.22628@wbgn013.biozentrum.uni-wuerzburg.de> <7v64ad7l12.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0702071257490.8424@woody.linux-foundation.org> <7vps8l65fh.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0702071334060.8424@woody.linux-foundation.org> <20070208061654.GA8813@coredump.intra.peff.net> <Pine.LNX.4.63.0702081905570.22628@wbgn013.biozentrum.uni-wuerzburg.de> <20070208223336.GA9422@coredump.intra.peff.net> <Pine.LNX.4.63.0702090115180.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Feb 09 01:26:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HFJao-0004nt-A8
	for gcvg-git@gmane.org; Fri, 09 Feb 2007 01:26:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423029AbXBIAYG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Feb 2007 19:24:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423057AbXBIAYG
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Feb 2007 19:24:06 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:41545 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423029AbXBIAXt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Feb 2007 19:23:49 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HFJY9-00045v-3q; Thu, 08 Feb 2007 19:23:37 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 4D96820FBAE; Thu,  8 Feb 2007 19:23:45 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0702090115180.22628@wbgn013.biozentrum.uni-wuerzburg.de>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39139>

Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> We included libxdiff _exactly_ to ensure consistency between different git 
> installations (remember, diff behaves quite differently on different 
> platforms, and even GNU diff behaves differently depending on which 
> version you use).

pcre is covered by the BSD license.  Can we ship it with git, like
we ship libxdiff?  I want to say Apache ships with pcre, but they
use the Apache License so it might be easier for them to do so.

-- 
Shawn.
