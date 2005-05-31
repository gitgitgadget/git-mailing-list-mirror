From: Nicolas Pitre <nico@cam.org>
Subject: Re: [SCRIPT] cg-rpush & locking
Date: Tue, 31 May 2005 19:16:09 -0400 (EDT)
Message-ID: <Pine.LNX.4.63.0505311914550.6500@localhost.localdomain>
References: <20050531190005.GE18723@atomide.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Matthias Urlichs <smurf@smurf.noris.de>
X-From: git-owner@vger.kernel.org Wed Jun 01 01:14:22 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DdFvP-00011b-VD
	for gcvg-git@gmane.org; Wed, 01 Jun 2005 01:13:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261277AbVEaXQN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 31 May 2005 19:16:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261329AbVEaXQN
	(ORCPT <rfc822;git-outgoing>); Tue, 31 May 2005 19:16:13 -0400
Received: from relais.videotron.ca ([24.201.245.36]:38500 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP id S261277AbVEaXQJ
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 May 2005 19:16:09 -0400
Received: from xanadu.home ([24.200.213.96]) by VL-MO-MR007.ip.videotron.ca
 (iPlanet Messaging Server 5.2 HotFix 1.21 (built Sep  8 2003))
 with ESMTP id <0IHD00CU0NAWOK@VL-MO-MR007.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 31 May 2005 19:16:09 -0400 (EDT)
In-reply-to: <20050531190005.GE18723@atomide.com>
X-X-Sender: nico@localhost.localdomain
To: Tony Lindgren <tony@atomide.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Tue, 31 May 2005, Tony Lindgren wrote:

> Anybody have any better ideas for locking that also works with
> rsync?

Why do you need a lock at all?

Just update your HEAD reference last when you push and get it first when 
you pull.


Nicolas
