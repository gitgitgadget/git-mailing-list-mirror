From: Julian Phillips <julian@quantumfyre.co.uk>
Subject: Re: GIT and the current -stable
Date: Sun, 15 Apr 2007 01:23:56 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0704150110490.17780@beast.quantumfyre.co.uk>
References: <46206842.80203@gmail.com> <20070414083410.GU6602@sequoia.sous-sol.org>
 <462096AA.3080003@gmail.com> <46216001.3000503@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Chris Wright <chrisw@sous-sol.org>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	Greg KH <greg@kroah.com>, git@vger.kernel.org
To: Rene Herman <rene.herman@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 15 02:24:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HcsXJ-0000Sw-Vm
	for gcvg-git@gmane.org; Sun, 15 Apr 2007 02:24:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753089AbXDOAYA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 14 Apr 2007 20:24:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753191AbXDOAYA
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Apr 2007 20:24:00 -0400
Received: from electron.quantumfyre.co.uk ([87.106.55.16]:40754 "EHLO
	electron.quantumfyre.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753089AbXDOAX7 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 14 Apr 2007 20:23:59 -0400
Received: from neutron.quantumfyre.co.uk (neutron.datavampyre.co.uk [212.159.54.235])
	by electron.quantumfyre.co.uk (Postfix) with ESMTP id B1E37C1F20
	for <git@vger.kernel.org>; Sun, 15 Apr 2007 01:23:57 +0100 (BST)
Received: (qmail 19268 invoked by uid 103); 15 Apr 2007 01:23:23 +0100
Received: from 192.168.0.7 by neutron.quantumfyre.co.uk (envelope-from <julian@quantumfyre.co.uk>, uid 201) with qmail-scanner-1.25st 
 (clamdscan: 0.90/3090. spamassassin: 3.1.8. perlscan: 1.25st.  
 Clear:RC:1(192.168.0.7):. 
 Processed in 0.034133 secs); 15 Apr 2007 00:23:23 -0000
Received: from beast.quantumfyre.co.uk (192.168.0.7)
  by neutron.datavampyre.co.uk with SMTP; 15 Apr 2007 01:23:23 +0100
X-X-Sender: jp3@beast.quantumfyre.co.uk
In-Reply-To: <46216001.3000503@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44474>

On Sun, 15 Apr 2007, Rene Herman wrote:

>
> "v2.6.20.7" seems to be the only tag from the stable branches that's present
>  in this tree?
>
> rene@7ixe4:[...]$ git tag -l | grep "v2\.6\.[[:digit:]]\{1,2\}\."
> v2.6.20.7

Obviously I don't know how Chris created his conglomerated repo, but I 
just made one of my own, and it has all the tags I would expect in it ... 
so it's not an inherent git problem (or not in 1.5.1.1 anyway).

I guess that Chris created his in such a way that the automated tag 
following code didn't trigger? (Or maybe used a really old git?)

(Mine's at http://git.q42.co.uk/w/stable.git if anyone is interested 
enough to want to look at it ...)

It only took me 4 commands to create too (ok, so three of them were bash 
for loops ... and I did do a little bit more to tidy up), I do enjoy using 
flexible tools :D.

-- 
Julian

  ---
Go slowly to the entertainments of thy friends, but quickly to their
misfortunes.
 		-- Chilo
