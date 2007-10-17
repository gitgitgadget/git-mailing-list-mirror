From: Frank Lichtenheld <frank@lichtenheld.de>
Subject: Re: [PATCH] Use exit 1 instead of die when req_Root fails.
Date: Wed, 17 Oct 2007 21:06:46 +0200
Message-ID: <20071017190646.GC9041@planck.djpig.de>
References: <20071017140547.GA21691@Hermes.cust.hotspot.t-mobile.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, spearce@spearce.org
To: Brian Gernhardt <benji@silverinsanity.com>
X-From: git-owner@vger.kernel.org Wed Oct 17 21:07:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IiEEy-0000Y0-BP
	for gcvg-git-2@gmane.org; Wed, 17 Oct 2007 21:07:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762150AbXJQTHA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Oct 2007 15:07:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932684AbXJQTG7
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Oct 2007 15:06:59 -0400
Received: from planck.djpig.de ([85.10.192.180]:3300 "EHLO planck.djpig.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762150AbXJQTG5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Oct 2007 15:06:57 -0400
Received: from localhost (localhost [127.0.0.1])
	by planck.djpig.de (Postfix) with ESMTP id B737888231;
	Wed, 17 Oct 2007 21:06:55 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at planck.djpig.de
Received: from planck.djpig.de ([127.0.0.1])
	by localhost (planck.djpig.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ebW74ydJLxS5; Wed, 17 Oct 2007 21:06:46 +0200 (CEST)
Received: by planck.djpig.de (Postfix, from userid 1000)
	id C587A88232; Wed, 17 Oct 2007 21:06:46 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20071017140547.GA21691@Hermes.cust.hotspot.t-mobile.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61410>

On Wed, Oct 17, 2007 at 10:05:47AM -0400, Brian Gernhardt wrote:
> This was causing test failures because die was exiting 255.
> 
> Signed-off-by: Brian Gernhardt <benji@silverinsanity.com>
> ---
> 
>  Shawn, I sent this in a couple weeks ago but it looks like it never
>  made it into your repo.  It fixes test failures on my machine that have
>  been plauging me for months.

I have this in my repo and will submit this with the other git-cvsserver
changes. I was just waiting for either Junio to return or someone else
stepping up.

Gruesse,
-- 
Frank Lichtenheld <frank@lichtenheld.de>
www: http://www.djpig.de/
