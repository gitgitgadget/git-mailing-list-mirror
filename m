From: linux@horizon.com
Subject: Re: [PATCH] Use printf rather than echo -n.
Date: 8 Dec 2005 03:02:01 -0500
Message-ID: <20051208080201.11372.qmail@science.horizon.com>
X-From: git-owner@vger.kernel.org Thu Dec 08 09:04:50 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EkGkA-0006qK-KT
	for gcvg-git@gmane.org; Thu, 08 Dec 2005 09:03:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750709AbVLHICF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Dec 2005 03:02:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750740AbVLHICE
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Dec 2005 03:02:04 -0500
Received: from science.horizon.com ([192.35.100.1]:61758 "HELO
	science.horizon.com") by vger.kernel.org with SMTP id S1750709AbVLHICD
	(ORCPT <rfc822;git@vger.kernel.org>); Thu, 8 Dec 2005 03:02:03 -0500
Received: (qmail 11373 invoked by uid 1000); 8 Dec 2005 03:02:01 -0500
To: ejr@EECS.Berkeley.EDU, git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13363>

I know it's pointless, but continuing the rant...

> On AIX, there is no -n option to the system's echo.

What the F***?  "echo -n" was added in 7th edition:
http://minnie.tuhs.org/UnixTree/V7/usr/src/cmd/echo.c.html
(It's not in 6th edition:
http://minnie.tuhs.org/UnixTree/V6/usr/source/s1/echo.c.html)

Now, I realize that AIX is derived from UCLA Locus, which branched
off from the Bell Labs source before 7th ed., but you'd think in the
intervening twenty-seven years someone would have had slightly more brains
than a pithed frog and have thought to add the 7th edition features?
