From: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Subject: Re: [PATCH] Fix for rpm creation
Date: Thu, 16 Feb 2006 16:59:39 +0100
Message-ID: <200602161659.39173.Josef.Weidendorfer@gmx.de>
References: <20060216135100.GR31278@pasky.or.cz> <200602161633.44399.Josef.Weidendorfer@gmx.de> <20060216154320.GT31278@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 16 17:00:05 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F9lXp-0004V0-8G
	for gcvg-git@gmane.org; Thu, 16 Feb 2006 16:59:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932302AbWBPP7q (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 16 Feb 2006 10:59:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932304AbWBPP7q
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Feb 2006 10:59:46 -0500
Received: from tuminfo2.informatik.tu-muenchen.de ([131.159.0.81]:14774 "EHLO
	tuminfo2.informatik.tu-muenchen.de") by vger.kernel.org with ESMTP
	id S932302AbWBPP7p (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Feb 2006 10:59:45 -0500
Received: from dhcp-3s-57.lrr.in.tum.de (dhcp-3s-57.lrr.in.tum.de [131.159.35.57])
	by mail.in.tum.de (Postfix) with ESMTP id EC8F62337;
	Thu, 16 Feb 2006 16:59:39 +0100 (MET)
To: Petr Baudis <pasky@suse.cz>
User-Agent: KMail/1.9.1
In-Reply-To: <20060216154320.GT31278@pasky.or.cz>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new/sophie/sophos at mailrelay1.informatik.tu-muenchen.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16308>

On Thursday 16 February 2006 16:43, Petr Baudis wrote:
> > Another thing:
> > "cg-switch origin" currently refuses to switch to the branch.
> > Wouldn't it be better to handle this like "cg-seek origin"?
> 
> Well, it depends on what you expect this to actually do. If you really
> want to just seek to whichever is the current origin commit, that's very
> different from what cg-switch does - you want cg-seek and cg-switch
> doing the same thing when it does something totally different from the
> user POV otherwise would be very confusing.

I just used it to check if you already fixed this issue yourself.
I known I should have used cg-seek, but I thought cg-switch should
allow me to do the same - I did not need to remember where I come
from.

So perhaps it would be good to hint the user to cg-seek in this
error message?

Josef
