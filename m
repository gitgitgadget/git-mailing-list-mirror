From: Julian Phillips <julian@quantumfyre.co.uk>
Subject: Re: How to figure out what 'git push' would do?
Date: Sun, 5 Aug 2007 18:45:41 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0708051839510.12656@beast.quantumfyre.co.uk>
References: <267CDD46-549B-4BFE-B993-80CD1CFE75D8@zib.de> <20070805173340.GA3159@steel.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Steffen Prohaska <prohaska@zib.de>,
	Git Mailing List <git@vger.kernel.org>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 05 19:45:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHkAw-0004Kb-IG
	for gcvg-git@gmane.org; Sun, 05 Aug 2007 19:45:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752074AbXHERpo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 5 Aug 2007 13:45:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751825AbXHERpo
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Aug 2007 13:45:44 -0400
Received: from electron.quantumfyre.co.uk ([87.106.55.16]:32992 "EHLO
	electron.quantumfyre.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751782AbXHERpn (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 5 Aug 2007 13:45:43 -0400
Received: from neutron.quantumfyre.co.uk (neutron.datavampyre.co.uk [212.159.54.235])
	by electron.quantumfyre.co.uk (Postfix) with ESMTP id 82ADBB8D7E
	for <git@vger.kernel.org>; Sun,  5 Aug 2007 18:45:42 +0100 (BST)
Received: (qmail 29499 invoked by uid 103); 5 Aug 2007 18:45:42 +0100
Received: from 192.168.0.7 by neutron.quantumfyre.co.uk (envelope-from <julian@quantumfyre.co.uk>, uid 201) with qmail-scanner-1.25st 
 (clamdscan: 0.91/3855. spamassassin: 3.2.1. perlscan: 1.25st.  
 Clear:RC:1(192.168.0.7):. 
 Processed in 0.042302 secs); 05 Aug 2007 17:45:42 -0000
Received: from beast.quantumfyre.co.uk (192.168.0.7)
  by neutron.datavampyre.co.uk with SMTP; 5 Aug 2007 18:45:41 +0100
X-X-Sender: jp3@beast.quantumfyre.co.uk
In-Reply-To: <20070805173340.GA3159@steel.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55046>

On Sun, 5 Aug 2007, Alex Riesen wrote:

> Steffen Prohaska, Sun, Aug 05, 2007 13:37:34 +0200:
>> How can I check what a 'git push' would do, without
>> actually doing it?
>>
>> Is there something like 'git push --dry-run', similar
>> to 'rsync --dry-run'?
>
> No. It is often safe to just do git-push, unless you have naive
> developers doing pull every time some ref in your shared repo changes
> *and* expecting the result to compile (typical for CVS way of work).
> git-push will not overwrite anything, it always only forwards history.

Not strictly true.  You _can_ push out non fastforward changes, unless you 
have receive.denyNonFastforwards in the repote repo - so you may well be 
able to push out something that is completely unrelated to the last commit 
the ref pointed to.

-- 
Julian

  ---
You never get a second chance to make a first impression.
