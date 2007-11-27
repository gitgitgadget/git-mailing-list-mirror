From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: What's cooking in git.git (topics)
Date: Tue, 27 Nov 2007 16:54:18 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711271652070.27959@racer.site>
References: <200711270622.lAR6MFXQ010010@mi0.bluebottle.com>
 <Pine.LNX.4.64.0711271109130.27959@racer.site> <alpine.LFD.0.99999.0711270917580.9605@xanadu.home>
 <20071127150829.GB3853@fieldses.org> <alpine.LFD.0.99999.0711271013310.9605@xanadu.home>
 <20071127153411.GA11731@fieldses.org> <alpine.LFD.0.99999.0711271047590.9605@xanadu.home>
 <20071127164243.GE11731@fieldses.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Nicolas Pitre <nico@cam.org>,
	=?utf-8?B?44KJ44GE44GX44Gq44Gq44GT?= <nanako3@bluebottle.com>,
	Andreas Ericsson <ae@op5.se>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: "J. Bruce Fields" <bfields@fieldses.org>
X-From: git-owner@vger.kernel.org Tue Nov 27 17:55:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ix3ia-0005yQ-Hd
	for gcvg-git-2@gmane.org; Tue, 27 Nov 2007 17:55:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756961AbXK0Qy0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Nov 2007 11:54:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756212AbXK0QyZ
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Nov 2007 11:54:25 -0500
Received: from mail.gmx.net ([213.165.64.20]:53384 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756876AbXK0QyZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Nov 2007 11:54:25 -0500
Received: (qmail invoked by alias); 27 Nov 2007 16:54:23 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp033) with SMTP; 27 Nov 2007 17:54:23 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/YW6J06vnYk75WvJbaudLoc90J+YrtvwhVTiCYqI
	qkLiGCZbg0EMBY
X-X-Sender: gene099@racer.site
In-Reply-To: <20071127164243.GE11731@fieldses.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66241>

Hi,

On Tue, 27 Nov 2007, J. Bruce Fields wrote:

> If we really want a fetch+rebase script, OK, but call it something other 
> than pull.

Why?  pull = fetch + merge only because that was the originally envisioned 
way to pull remote changes into your local working tree.  However, I do 
not see why we should be married to pull being a fetch and a merge for 
eternity.

Ciao,
Dscho
