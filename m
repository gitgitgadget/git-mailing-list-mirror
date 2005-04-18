From: Sanjoy Mahajan <sanjoy@mrao.cam.ac.uk>
Subject: Re: [PATCH] Pretty-print date in 'git log'
Date: Mon, 18 Apr 2005 20:57:11 +0100
Message-ID: <E1DNcMp-0006sk-00@skye.ra.phy.cam.ac.uk>
References: <1113850922.23938.54.camel@orca.madrabbit.org>
Cc: David Woodhouse <dwmw2@infradead.org>, git@vger.kernel.org,
	Petr Baudis <pasky@ucw.cz>
X-From: git-owner@vger.kernel.org Mon Apr 18 21:54:22 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNcJR-0005xO-UY
	for gcvg-git@gmane.org; Mon, 18 Apr 2005 21:53:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262189AbVDRT5a (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 18 Apr 2005 15:57:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262190AbVDRT5a
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Apr 2005 15:57:30 -0400
Received: from mraos.ra.phy.cam.ac.uk ([131.111.48.8]:32925 "EHLO
	mraos.ra.phy.cam.ac.uk") by vger.kernel.org with ESMTP
	id S262189AbVDRT5U (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Apr 2005 15:57:20 -0400
Received: from skye.ra.phy.cam.ac.uk ([131.111.48.158] ident=mail)
	by mraos.ra.phy.cam.ac.uk with esmtp (Exim 4.43)
	id 1DNcMq-0006CQ-0p; Mon, 18 Apr 2005 20:57:12 +0100
Received: from sanjoy by skye.ra.phy.cam.ac.uk with local (Exim 3.35 #1)
	id 1DNcMp-0006sk-00; Mon, 18 Apr 2005 20:57:11 +0100
To: Ray Lee <ray-lk@madrabbit.org>
In-Reply-To: Your message of "Mon, 18 Apr 2005 12:02:02 PDT."
             <1113850922.23938.54.camel@orca.madrabbit.org> 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

> ray:~/work/home$ date -ud 'jan 1, 1970 + 1111111111 seconds'
> Fri Mar 18 01:58:31 UTC 2005
> ray:~/work/home$ date -ud 'jan 1, 1970 + 1111111111 seconds + 0800'
> Fri Mar 18 09:58:31 UTC 2005

I sent David a short script to do almost that, except that mine needed
to negate the timezone whereas yours elegantly changes +0800 to + 0800

In your 2nd example, you'll need 'sed' to replace UTC (or +0000 if
using -R) in the output by +0800, because the 1111111111 is the UTC
seconds, so the actual time is Fri Mar 18 01:58:31 UTC 2005 (as given
by your first example).

-Sanjoy
