From: Julian Phillips <julian@quantumfyre.co.uk>
Subject: Re: hosting git on a nfs
Date: Wed, 12 Nov 2008 10:10:03 +0000 (GMT)
Message-ID: <alpine.LNX.2.00.0811121006400.23345@reaper.quantumfyre.co.uk>
References: <200811121029.34841.thomas@koch.ro>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: git@vger.kernel.org, dabe@ymc.ch
To: Thomas Koch <thomas@koch.ro>
X-From: git-owner@vger.kernel.org Wed Nov 12 11:12:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L0Chy-0007mp-5H
	for gcvg-git-2@gmane.org; Wed, 12 Nov 2008 11:12:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751804AbYKLKK4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Nov 2008 05:10:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751795AbYKLKK4
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Nov 2008 05:10:56 -0500
Received: from electron.quantumfyre.co.uk ([87.106.55.16]:53260 "EHLO
	electron.quantumfyre.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751802AbYKLKKz (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 12 Nov 2008 05:10:55 -0500
Received: from neutron.quantumfyre.co.uk (neutron.quantumfyre.co.uk [212.159.54.235])
	by electron.quantumfyre.co.uk (Postfix) with ESMTP id 9758A1A8C04
	for <git@vger.kernel.org>; Wed, 12 Nov 2008 10:10:53 +0000 (GMT)
Received: (qmail 17187 invoked by uid 103); 12 Nov 2008 10:10:03 +0000
Received: from 212.159.54.234 by neutron.quantumfyre.co.uk (envelope-from <julian@quantumfyre.co.uk>, uid 201) with qmail-scanner-1.25st 
 (clamdscan: 0.94/8612. spamassassin: 3.2.1. perlscan: 1.25st.  
 Clear:RC:1(212.159.54.234):. 
 Processed in 0.028287 secs); 12 Nov 2008 10:10:03 -0000
Received: from darkphoton.datavampyre.co.uk (212.159.54.234)
  by neutron.quantumfyre.co.uk with SMTP; 12 Nov 2008 10:10:03 +0000
X-X-Sender: jp3@reaper.quantumfyre.co.uk
In-Reply-To: <200811121029.34841.thomas@koch.ro>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100734>

On Wed, 12 Nov 2008, Thomas Koch wrote:

> Hi,
>
> finally I managed to convince a critical mass of developers (our chief
> dev :-) in our company so that we are starting to migrate to GIT.
>
> The final question is, whether GIT will life peacefully on our cluster
> fileservers. The GIT repository dir (/var/cache/git) should be mounted
> via NFS via PAN on top of DRBD (so I was told).
>
> Are there any known problems with this setup? We're asking, because
> there are problems with SVN on such a setup[1].
>
> [1] http://subversion.tigris.org/faq.html#nfs

I've been running git on NFS for years (though it's only NFS exported 
software RAID), and the only issue I've encountered is that it's not quite 
as blisteringly fast as running git on a local disk.

-- 
Julian

  ---
There's something different about us -- different from people of Europe,
Africa, Asia ... a deep and abiding belief in the Easter Bunny.
 		-- G. Gordon Liddy
