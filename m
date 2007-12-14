From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] git-svn: handle our top-level path is deleted and later re-added
Date: Fri, 14 Dec 2007 08:43:28 -0800
Message-ID: <20071214164328.GA5213@hand.yhbt.net>
References: <475C8748.6000005@cryos.net> <20071210104235.GA7521@xp.machine.xx> <20071213164134.GD18433@soma> <20071213181312.GA4441@xp.machine.xx> <20071214163909.GA18300@soma>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Peter Baumann <waste.manager@gmx.de>,
	"Marcus D. Hanwell" <marcus@cryos.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 14 17:43:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J3Ddg-00020j-2R
	for gcvg-git-2@gmane.org; Fri, 14 Dec 2007 17:43:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753752AbXLNQna (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Dec 2007 11:43:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752813AbXLNQna
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Dec 2007 11:43:30 -0500
Received: from hand.yhbt.net ([66.150.188.102]:60296 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752528AbXLNQn3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Dec 2007 11:43:29 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id 28C667DC025;
	Fri, 14 Dec 2007 08:43:29 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20071214163909.GA18300@soma>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68317>

> Subject: [PATCH] git-svn: handle our top-level path is deleted and later re-added

That should read:

Subject: [PATCH] git-svn: handle our top-level path being deleted and later re-added

> ---
>   Peter Baumann <waste.manager@gmx.de> wrote:
>   > On Thu, Dec 13, 2007 at 08:41:34AM -0800, Eric Wong wrote:

>   > > Instead of handling the full delete of everything in r68, I think I'll
>   > > make it so importing r75 will clobber all the stuff in trunk/ we ignored
>   > > deleting in r68 before adding the contents of trunk/ in r75.
>   > > 
>   > 
>   > Sorry, that last sentence I can't parse/understand. But I trust you to do the
>   > right thing.
> 
>   I hope the commit message was a better explanation.  Or the code
>   and test case I've added makes perfect sense :)

My language generation module seems broken these days.

-- 
Eric Wong
