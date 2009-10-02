From: Julian Phillips <julian@quantumfyre.co.uk>
Subject: Re: Figuring out which patches have been applied
Date: Fri, 2 Oct 2009 19:45:53 +0100 (BST)
Message-ID: <alpine.LNX.2.00.0910021944040.28646@reaper.quantumfyre.co.uk>
References: <9e4733910910020736n539f4331nfd61175b275c7d28@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Git Mailing List <git@vger.kernel.org>
To: Jon Smirl <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 02 20:51:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MtnEQ-0000Rl-Bv
	for gcvg-git-2@lo.gmane.org; Fri, 02 Oct 2009 20:51:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753861AbZJBSvp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Oct 2009 14:51:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753060AbZJBSvp
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Oct 2009 14:51:45 -0400
Received: from electron.quantumfyre.co.uk ([87.106.55.16]:60402 "EHLO
	electron.quantumfyre.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752803AbZJBSvo (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 2 Oct 2009 14:51:44 -0400
Received: from neutron.quantumfyre.co.uk (neutron.quantumfyre.co.uk [212.159.54.235])
	by electron.quantumfyre.co.uk (Postfix) with ESMTP id 0A90D349C36
	for <git@vger.kernel.org>; Fri,  2 Oct 2009 19:51:47 +0100 (BST)
Received: (qmail 31320 invoked by uid 103); 2 Oct 2009 19:45:53 +0100
Received: from reaper.quantumfyre.co.uk by neutron.quantumfyre.co.uk (envelope-from <julian@quantumfyre.co.uk>, uid 201) with qmail-scanner-2.05st 
 (clamdscan: 0.95.2/9861. spamassassin: 3.2.1. perlscan: 2.05st.  
 Clear:RC:1(212.159.54.234):. 
 Processed in 0.024933 secs); 02 Oct 2009 18:45:53 -0000
Received: from reaper.quantumfyre.co.uk (212.159.54.234)
  by neutron.quantumfyre.co.uk with SMTP; 2 Oct 2009 19:45:53 +0100
X-X-Sender: jp3@reaper.quantumfyre.co.uk
In-Reply-To: <9e4733910910020736n539f4331nfd61175b275c7d28@mail.gmail.com>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129453>

On Fri, 2 Oct 2009, Jon Smirl wrote:

> I have a stack of 100 patches against 2.6.30. A lot of these got
> merged between 2.6.30-32.  How can I tell which ones have been
> applied?
>
> It doesn't work to check if patch A has been applied to 2.6.32. Other
> patches may have been applied on top of patch A obscuring it.
>
> Once solution would be to rebase the patch stack forward one commit at
> a time. That solves the problem of later patches obscuring patch A. Is
> there a better way to do this?

Have you tried using git-cherry?  I belive that it was intended for this 
purpose?

-- 
Julian

  ---
Progress might have been all right once, but it's gone on too long.
 		-- Ogden Nash
