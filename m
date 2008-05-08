From: Julian Phillips <julian@quantumfyre.co.uk>
Subject: Re: help with git usage
Date: Thu, 8 May 2008 01:16:26 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0805080112580.6421@kaos.quantumfyre.co.uk>
References: <200804291738.m3THc2hC030601@rs40.luxsci.com>
 <alpine.LNX.1.00.0804291354070.19665@iabervon.org> <m3tzhjokox.fsf@localhost.localdomain>
 <200805072242.m47Mg1o0015578@rs40.luxsci.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Jakub Narebski <jnareb@gmail.com>,
	Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org
To: Daniel Quinlan <danq@brtt.com>
X-From: git-owner@vger.kernel.org Thu May 08 15:34:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ju6Fv-0004uF-Dm
	for gcvg-git-2@gmane.org; Thu, 08 May 2008 15:33:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752717AbYEHNcp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 May 2008 09:32:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752939AbYEHNcp
	(ORCPT <rfc822;git-outgoing>); Thu, 8 May 2008 09:32:45 -0400
Received: from electron.quantumfyre.co.uk ([87.106.55.16]:34829 "EHLO
	electron.quantumfyre.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751645AbYEHNco (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 8 May 2008 09:32:44 -0400
Received: from neutron.quantumfyre.co.uk (neutron.quantumfyre.co.uk [212.159.54.235])
	by electron.quantumfyre.co.uk (Postfix) with ESMTP id BFCE514FE81
	for <git@vger.kernel.org>; Thu,  8 May 2008 01:18:04 +0100 (BST)
Received: (qmail 18343 invoked by uid 103); 8 May 2008 01:16:26 +0100
Received: from 192.168.0.4 by neutron.quantumfyre.co.uk (envelope-from <julian@quantumfyre.co.uk>, uid 201) with qmail-scanner-1.25st 
 (clamdscan: 0.92.1/7043. spamassassin: 3.2.1. perlscan: 1.25st.  
 Clear:RC:1(192.168.0.4):. 
 Processed in 0.026923 secs); 08 May 2008 00:16:26 -0000
Received: from elfhelm.quantumfyre.co.uk (HELO kaos.quantumfyre.co.uk) (192.168.0.4)
  by neutron.quantumfyre.co.uk with SMTP; 8 May 2008 01:16:26 +0100
X-X-Sender: jp3@kaos.quantumfyre.co.uk
In-Reply-To: <200805072242.m47Mg1o0015578@rs40.luxsci.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81526>

On Wed, 7 May 2008, Daniel Quinlan wrote:

> I'm looking for a way to embed some identifying information about 
> version
> into compiled programs.  I hasten to add that I am not looking to 
> expand RCS-like
> tags.  Unlike CVS/RCS, git provides a single value that characterizes 
> the whole
> distribution, at least if everything is committed.  So, something like 
> "git log | head -1 | awk '{print $2}'"
> probably provides a value which I can embed into executables and 
> libraries, tying
> them to a particular source configuration.  I'm just curious if 
> there's a better approach
> to getting the commit hash.

something like "git show-ref -s HEAD" perhaps?

-- 
Julian

  ---
The Kennedy Constant:
 	Don't get mad -- get even.
