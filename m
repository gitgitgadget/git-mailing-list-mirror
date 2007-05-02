From: Julian Phillips <julian@quantumfyre.co.uk>
Subject: Re: Git benchmarks at OpenOffice.org wiki
Date: Wed, 2 May 2007 18:11:56 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0705021801120.20300@reaper.quantumfyre.co.uk>
References: <200705012346.14997.jnareb@gmail.com> <200705021158.04481.andyparkins@gmail.com>
 <Pine.LNX.4.64.0705021523290.24218@reaper.quantumfyre.co.uk>
 <200705021630.16792.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>,
	Jan Holesovsky <kendy@suse.cz>
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 02 19:12:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HjINT-0001AK-1B
	for gcvg-git@gmane.org; Wed, 02 May 2007 19:12:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1766826AbXEBRMT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 2 May 2007 13:12:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1766834AbXEBRMS
	(ORCPT <rfc822;git-outgoing>); Wed, 2 May 2007 13:12:18 -0400
Received: from electron.quantumfyre.co.uk ([87.106.55.16]:44644 "EHLO
	electron.quantumfyre.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1766826AbXEBRL6 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 2 May 2007 13:11:58 -0400
Received: from neutron.quantumfyre.co.uk (neutron.datavampyre.co.uk [212.159.54.235])
	by electron.quantumfyre.co.uk (Postfix) with ESMTP id 5ED28103676
	for <git@vger.kernel.org>; Wed,  2 May 2007 18:11:57 +0100 (BST)
Received: (qmail 13338 invoked by uid 103); 2 May 2007 18:10:37 +0100
Received: from 192.168.0.2 by neutron.quantumfyre.co.uk (envelope-from <julian@quantumfyre.co.uk>, uid 201) with qmail-scanner-1.25st 
 (clamdscan: 0.90.2/3190. spamassassin: 3.1.8. perlscan: 1.25st.  
 Clear:RC:1(192.168.0.2):. 
 Processed in 0.036002 secs); 02 May 2007 17:10:37 -0000
Received: from reaper.quantumfyre.co.uk (192.168.0.2)
  by neutron.datavampyre.co.uk with SMTP; 2 May 2007 18:10:37 +0100
X-X-Sender: jp3@reaper.quantumfyre.co.uk
In-Reply-To: <200705021630.16792.andyparkins@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46039>

On Wed, 2 May 2007, Andy Parkins wrote:

> On Wednesday 2007 May 02, Julian Phillips wrote:
>
>> oops, meant 2.7G not 8.5G there ... sorry, was working from memory.
>
> Not a problem.  That fixes one ambiguity:
>  2.7G - 1.3G = 1.4G
> Which is the same as the CVS checkout size.  Both the CVS and git figures are
> now consistent:
>                                CVS      git      SVN
> Size of data on the server     8.5G     1.3G      n/a
> Size of checkout               1.4G     2.7G     1.5G
> Overhead in checkout             0G     1.3G     0.1G

Except that it's 2.8G, I forgot I had switched branch.  I switched to the 
unxsplash branch, and _that_ is 2.7G checked out.

(du -s .) - (du -s .git) = 1.49G

-- 
Julian

  ---
"Consider a spherical bear, in simple harmonic motion..."
 		-- Professor in the UCB physics department
