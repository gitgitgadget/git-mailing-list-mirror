From: Nicolas Pitre <nico@cam.org>
Subject: Re: Figured out how to get Mozilla into git
Date: Thu, 08 Jun 2006 22:56:53 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0606082253430.19403@localhost.localdomain>
References: <9e4733910606081917l11354e49q25f0c4aea40618ea@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jun 09 04:57:26 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FoXBc-000431-0r
	for gcvg-git@gmane.org; Fri, 09 Jun 2006 04:57:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751378AbWFIC47 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Jun 2006 22:56:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751381AbWFIC47
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Jun 2006 22:56:59 -0400
Received: from relais.videotron.ca ([24.201.245.36]:51260 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP
	id S1751378AbWFIC46 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Jun 2006 22:56:58 -0400
Received: from xanadu.home ([74.56.108.184]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0J0K00K4QO6TGAC0@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 08 Jun 2006 22:56:53 -0400 (EDT)
In-reply-to: <9e4733910606081917l11354e49q25f0c4aea40618ea@mail.gmail.com>
X-X-Sender: nico@localhost.localdomain
To: Jon Smirl <jonsmirl@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21522>

On Thu, 8 Jun 2006, Jon Smirl wrote:

> I was able to import Mozilla into SVN without problem, it just occured
> to me to then import the SVN repository in git. The import has been
> running a few hours now and it is up to the year 2000 (starts in
> 1998). Since I haven't hit any errors yet it will probably finish ok.
> I should have the results in the morning. I wonder how long it will
> take to start gitk on a 10GB repository.

Before you do so consider repacking the repository with 

  git-repack -a -f -d && git-prune-packed


Nicolas
