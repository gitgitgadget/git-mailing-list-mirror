From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: building git in a separate directory
Date: Mon, 8 Jan 2007 22:37:52 -0500
Message-ID: <20070109033752.GD1904@spearce.org>
References: <7c737f300701081930t755d9e61h581e421ecf7ab465@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 09 04:38:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H47oJ-0001bO-3K
	for gcvg-git@gmane.org; Tue, 09 Jan 2007 04:38:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750783AbXAIDh5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 8 Jan 2007 22:37:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750854AbXAIDh5
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Jan 2007 22:37:57 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:48670 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750783AbXAIDh4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Jan 2007 22:37:56 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1H47nz-0000Tn-9H; Mon, 08 Jan 2007 22:37:43 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id E79F320FBAE; Mon,  8 Jan 2007 22:37:52 -0500 (EST)
To: Alexy Khrabrov <deliverable@gmail.com>
Content-Disposition: inline
In-Reply-To: <7c737f300701081930t755d9e61h581e421ecf7ab465@mail.gmail.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36304>

Alexy Khrabrov <deliverable@gmail.com> wrote:
> Tried to build git 1.4.4.1 away from the source directory -- said
> 
> make configure
> 
> -- which made a configure, switched to a separate build/ directory,
> invoked that/../configure -- which ran fine, except produced no
> Makefile!
> 
> What's the way to build git outside from the source directory?

I'm no sure that's supported right now.  Someone tried to submit
patches for it but I don't think they were applied.  The configure
script is really just a way to create a personal config.mak, which is
the "real" way to configure Git prior to compiling it with Makefile.

-- 
Shawn.
