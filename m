From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Application to install man pages.
Date: Thu, 18 Oct 2007 21:16:41 -0400
Message-ID: <20071019011640.GS14735@spearce.org>
References: <428b865e0710181159i7a12f2b7y22619f0eaf36d2c1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Evan Carroll <me@evancarroll.com>
X-From: git-owner@vger.kernel.org Fri Oct 19 03:16:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IigTw-0007ep-Pk
	for gcvg-git-2@gmane.org; Fri, 19 Oct 2007 03:16:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754218AbXJSBQq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Oct 2007 21:16:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754579AbXJSBQp
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Oct 2007 21:16:45 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:41045 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753672AbXJSBQp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Oct 2007 21:16:45 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1IigTU-0003Kc-Pu; Thu, 18 Oct 2007 21:16:28 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id A6BDA20FBAE; Thu, 18 Oct 2007 21:16:41 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <428b865e0710181159i7a12f2b7y22619f0eaf36d2c1@mail.gmail.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61590>

Evan Carroll <me@evancarroll.com> wrote:
> This is a one liner but might help for simply a quick install of the
> git manpages.
...
> +#/bin/sh
> + cp -R --copy-contents ./man* /usr/local/man
> -- 

Isn't this covered by the "make -C Documentation quick-install"?
Which is what "make quick-install-doc" does in the top level Makefile.

-- 
Shawn.
