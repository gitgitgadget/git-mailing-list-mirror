From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [ANNOUNCE] git-pasky-0.7
Date: Sun, 24 Apr 2005 01:12:41 -0400 (EDT)
Message-ID: <Pine.LNX.4.21.0504240104520.30848-100000@iabervon.org>
References: <20050423220236.26f834ee.pj@sgi.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 24 07:08:00 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DPZLR-0008KT-HY
	for gcvg-git@gmane.org; Sun, 24 Apr 2005 07:07:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262261AbVDXFMh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 24 Apr 2005 01:12:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262262AbVDXFMg
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Apr 2005 01:12:36 -0400
Received: from iabervon.org ([66.92.72.58]:20741 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S262261AbVDXFMe (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 24 Apr 2005 01:12:34 -0400
Received: from barkalow (helo=localhost)
	by iabervon.org with local-esmtp (Exim 2.12 #2)
	id 1DPZQ9-0002Zs-00; Sun, 24 Apr 2005 01:12:41 -0400
To: Paul Jackson <pj@sgi.com>
In-Reply-To: <20050423220236.26f834ee.pj@sgi.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sat, 23 Apr 2005, Paul Jackson wrote:

> I still don't see how to get to the official 2.6.12-rc3:
> 
> 	a2755a80f40e5794ddc20e00f781af9d6320fafb

You've got the current head, which is a couple of days past 2.6.12-rc3. If
you actually want the release version, 

  git seek a2755a80f40e5794ddc20e00f781af9d6320fafb

should get you there, although it will not want to let you commit changes
when you are blatantly not up-to-date.

	-Daniel
*This .sig left intentionally blank*

