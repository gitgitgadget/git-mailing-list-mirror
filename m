From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH] Get commits from remote repositories by HTTP
Date: Sat, 16 Apr 2005 18:45:54 -0400 (EDT)
Message-ID: <Pine.LNX.4.21.0504161844040.30848-100000@iabervon.org>
References: <011201c542d5$940bb670$03c8a8c0@kroptech.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Tony Luck <tony.luck@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 17 00:42:23 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DMvzI-0000QW-Cj
	for gcvg-git@gmane.org; Sun, 17 Apr 2005 00:42:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261172AbVDPWpn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 16 Apr 2005 18:45:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261175AbVDPWpn
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Apr 2005 18:45:43 -0400
Received: from iabervon.org ([66.92.72.58]:58374 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S261172AbVDPWpj (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 16 Apr 2005 18:45:39 -0400
Received: from barkalow (helo=localhost)
	by iabervon.org with local-esmtp (Exim 2.12 #2)
	id 1DMw30-0004aX-00; Sat, 16 Apr 2005 18:45:54 -0400
To: Adam Kropelin <akropel1@rochester.rr.com>
In-Reply-To: <011201c542d5$940bb670$03c8a8c0@kroptech.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sat, 16 Apr 2005, Adam Kropelin wrote:

> Tony Luck wrote:
> > Otherwise this looks really nice.  I was going to script something
> > similar using "wget" ... but that would have made zillions of seperate
> > connections.  Not so kind to the server.
> 
> How about building a file list and doing a batch download via 'wget -i 
> /tmp/foo'? A quick test (on my ancient wget-1.7) indicates that it reuses 
> connectionss when successive URLs point to the same server.

You need to look at some of the files before you know what other files to
get. You could do it in waves, but that would be excessively complicated
to code and not the most efficient anyway.

	-Daniel
*This .sig left intentionally blank*

