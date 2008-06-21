From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] git-gui: Fix accidental staged state toggle when clicking top pixel row
Date: Fri, 20 Jun 2008 23:21:32 -0400
Message-ID: <20080621032132.GW11793@spearce.org>
References: <1213973895-10264-1-git-send-email-richard.quirk@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Richard Quirk <richard.quirk@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 21 05:23:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K9tgw-00018g-CI
	for gcvg-git-2@gmane.org; Sat, 21 Jun 2008 05:23:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753410AbYFUDVg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Jun 2008 23:21:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753802AbYFUDVg
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Jun 2008 23:21:36 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:35137 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751576AbYFUDVf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jun 2008 23:21:35 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.69)
	(envelope-from <spearce@spearce.org>)
	id 1K9tfF-00053u-QE; Fri, 20 Jun 2008 23:21:21 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 80C2A20FBAE; Fri, 20 Jun 2008 23:21:32 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <1213973895-10264-1-git-send-email-richard.quirk@gmail.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85689>

Richard Quirk <richard.quirk@gmail.com> wrote:
> If a text widget is asked the index at x,y with y == 0 or y == 1 it will
> always return 1.0 as the nearest index, regardless of the x position.
> 
> This means that clicking the top 2 pixels of the Unstaged/Staged Changes
> lists caused the state of the file there to be toggled. This patch
> checks that the pixel clicked is greater than 1, so there is less chance
> of accidentally staging or unstaging changes.

Thanks.  Its in my master branch now.

-- 
Shawn.
