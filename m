From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Symbolic link documentation
Date: Thu, 20 Sep 2007 15:16:51 -0400
Message-ID: <20070920191651.GW3099@spearce.org>
References: <70952A932255A2489522275A628B97C3052E98EB@xmb-sjc-233.amer.cisco.com> <Pine.LNX.4.64.0709201819340.28395@racer.site> <20070920172736.GU3099@spearce.org> <70952A932255A2489522275A628B97C3052E993B@xmb-sjc-233.amer.cisco.com> <20070920181100.GV3099@spearce.org> <70952A932255A2489522275A628B97C3052E99F9@xmb-sjc-233.amer.cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: "Matt Seitz (matseitz)" <matseitz@cisco.com>
X-From: git-owner@vger.kernel.org Thu Sep 20 21:17:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IYRWH-0003Fb-RN
	for gcvg-git-2@gmane.org; Thu, 20 Sep 2007 21:17:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752929AbXITTQ4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Sep 2007 15:16:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752310AbXITTQ4
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Sep 2007 15:16:56 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:54535 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751892AbXITTQ4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Sep 2007 15:16:56 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1IYRW1-0005G0-Ef; Thu, 20 Sep 2007 15:16:45 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id CF4BF20FBAE; Thu, 20 Sep 2007 15:16:51 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <70952A932255A2489522275A628B97C3052E99F9@xmb-sjc-233.amer.cisco.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58799>

"Matt Seitz (matseitz)" <matseitz@cisco.com> wrote:
> From: spearce@spearce.org [mailto:spearce@spearce.org] 
> > 
> > So Git handles symlinks in the working tree *without* 
> > dereferencing them.  
> 
> Thanks.  Is there a recommended procedure for tracking changes when the
> symlink target is outside the working tree?

Move the link target so its inside the working tree?

Git won't step outside of the working tree to look for or to record
changes.  Its outside.  We don't track things outside of the part
of the world you've asked us to track.

-- 
Shawn.
