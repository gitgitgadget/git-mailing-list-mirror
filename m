From: Julian Phillips <julian@quantumfyre.co.uk>
Subject: Re: How can I access remote branches in a cloned repository on my
 local machine?
Date: Sat, 20 Oct 2007 14:56:57 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0710201455540.8248@beast.quantumfyre.co.uk>
References: <05B1B470-1C86-40E6-9E33-968809414537@atlasocean.com>
 <Pine.LNX.4.64.0710201449340.8248@beast.quantumfyre.co.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: git@vger.kernel.org
To: Erich Ocean <erich@atlasocean.com>
X-From: git-owner@vger.kernel.org Sat Oct 20 15:57:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IjEpC-0000mp-4v
	for gcvg-git-2@gmane.org; Sat, 20 Oct 2007 15:57:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755108AbXJTN47 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Oct 2007 09:56:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754956AbXJTN47
	(ORCPT <rfc822;git-outgoing>); Sat, 20 Oct 2007 09:56:59 -0400
Received: from electron.quantumfyre.co.uk ([87.106.55.16]:37725 "EHLO
	electron.quantumfyre.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754360AbXJTN47 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 20 Oct 2007 09:56:59 -0400
Received: from neutron.quantumfyre.co.uk (neutron.datavampyre.co.uk [212.159.54.235])
	by electron.quantumfyre.co.uk (Postfix) with ESMTP id D49E16C5AD
	for <git@vger.kernel.org>; Sat, 20 Oct 2007 14:56:57 +0100 (BST)
Received: (qmail 25235 invoked by uid 103); 20 Oct 2007 14:56:57 +0100
Received: from 192.168.0.7 by neutron.quantumfyre.co.uk (envelope-from <julian@quantumfyre.co.uk>, uid 201) with qmail-scanner-1.25st 
 (clamdscan: 0.91.2/4545. spamassassin: 3.2.1. perlscan: 1.25st.  
 Clear:RC:1(192.168.0.7):. 
 Processed in 0.02964 secs); 20 Oct 2007 13:56:57 -0000
Received: from beast.quantumfyre.co.uk (192.168.0.7)
  by neutron.datavampyre.co.uk with SMTP; 20 Oct 2007 14:56:57 +0100
X-X-Sender: jp3@beast.quantumfyre.co.uk
In-Reply-To: <Pine.LNX.4.64.0710201449340.8248@beast.quantumfyre.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61836>

On Sat, 20 Oct 2007, Julian Phillips wrote:

>>  The problem is, when I clone git@git.1kstudios.lan:dev, the various
>>  <username>/master's aren't there. I have tried a bunch of different ways,
>>  but they all give me errors. For example:
>
> The default fetch refspec doesn't include the remotes - after all, you 
> normally don't want the origin for your origin ...
>
>>  How can I access remote branches in a cloned repository on my local
>>  machine?
>
> Try something like:
>
> git config remote.origin.fetch +refs/remotes/*:+refs/remotes/*

sorry, that should have been:
git config remote.origin.fetch +refs/remotes/*:refs/remotes/*

> git fetch

-- 
Julian

  ---
"The National Association of Theater Concessionaires reported that in
1986, 60% of all candy sold in movie theaters was sold to Roger Ebert."
 		-- D. Letterman
