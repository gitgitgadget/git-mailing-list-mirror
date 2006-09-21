From: Nicolas Pitre <nico@cam.org>
Subject: Re: Git user survey and `git pull`
Date: Thu, 21 Sep 2006 13:02:12 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0609211259340.2627@xanadu.home>
References: <20060921162401.GD3934@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 21 19:10:06 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GQRwM-0005QH-8D
	for gcvg-git@gmane.org; Thu, 21 Sep 2006 19:02:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751348AbWIURCP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Sep 2006 13:02:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751351AbWIURCO
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Sep 2006 13:02:14 -0400
Received: from relais.videotron.ca ([24.201.245.36]:40771 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP
	id S1751348AbWIURCO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Sep 2006 13:02:14 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0J5Y00D3DCNPGXR0@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 21 Sep 2006 13:02:13 -0400 (EDT)
In-reply-to: <20060921162401.GD3934@spearce.org>
X-X-Sender: nico@xanadu.home
To: Shawn Pearce <spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27493>

On Thu, 21 Sep 2006, Shawn Pearce wrote:

> I think its probably too late to change the UI[*1*] but I think
> it is definately an issue for folks learning Git.  Calling push
> push, fetch fetch and fetch+merge pull is probably a design flaw.
> IMHO it probably should have been something like:
> 
>   Current            Shoulda Been
>   ---------------    ----------------
>   git-push           git-push
>   git-fetch          git-pull
>   git-pull . foo     git-merge foo
>   git-pull           git-pull --merge
>   git-merge          git-merge-driver
> 
> in other words pull does the download and doesn't automatically
> start a merge unless --merge was also given and git-merge is a
> cleaner wrapper around the Grand Unified Merge Driver that makes
> it easier to start a merge.

I must say that I second this.  Although I'm rather familiar with GIT I 
still feel unconfortable with the current naming and behavior.


Nicolas
