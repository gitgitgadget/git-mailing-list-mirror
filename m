From: Julian Phillips <julian@quantumfyre.co.uk>
Subject: Re: git-new-workdir not working right?
Date: Tue, 14 Apr 2009 15:47:58 +0100 (BST)
Message-ID: <alpine.LNX.2.00.0904141540410.29027@reaper.quantumfyre.co.uk>
References: <81bfc67a0904132109k45f09f79s21ce3132ade02001@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
Cc: git@vger.kernel.org
To: Caleb Cushing <xenoterracide@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 14 16:50:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LtjxR-0006ql-2J
	for gcvg-git-2@gmane.org; Tue, 14 Apr 2009 16:49:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755179AbZDNOsT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Apr 2009 10:48:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754768AbZDNOsT
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Apr 2009 10:48:19 -0400
Received: from electron.quantumfyre.co.uk ([87.106.55.16]:38322 "EHLO
	electron.quantumfyre.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754474AbZDNOsT (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 14 Apr 2009 10:48:19 -0400
Received: from neutron.quantumfyre.co.uk (neutron.quantumfyre.co.uk [212.159.54.235])
	by electron.quantumfyre.co.uk (Postfix) with ESMTP id B12731213F4
	for <git@vger.kernel.org>; Tue, 14 Apr 2009 15:48:17 +0100 (BST)
Received: (qmail 940 invoked by uid 103); 14 Apr 2009 15:47:58 +0100
Received: from darkphoton.datavampyre.co.uk by neutron.quantumfyre.co.uk (envelope-from <julian@quantumfyre.co.uk>, uid 201) with qmail-scanner-2.05st 
 (clamdscan: 0.94.2/9228. spamassassin: 3.2.1. perlscan: 2.05st.  
 Clear:RC:1(212.159.54.234):. 
 Processed in 0.026526 secs); 14 Apr 2009 14:47:58 -0000
Received: from darkphoton.datavampyre.co.uk (HELO quantumfyre.force9.co.uk) (212.159.54.234)
  by neutron.quantumfyre.co.uk with SMTP; 14 Apr 2009 15:47:58 +0100
X-X-Sender: jp3@reaper.quantumfyre.co.uk
In-Reply-To: <81bfc67a0904132109k45f09f79s21ce3132ade02001@mail.gmail.com>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 14 Apr 2009, Caleb Cushing wrote:

> before I could do git-new-workdir path/to/repo/.git neworkdirname now
> that doesn't seem to work... I actually had to cd to path/to/repo/.git
> and do git-new-workdir . ../.../neworkdirname to get it to work. it
> was complaining that the .git/ wasn't a git repo.
>
> using git 1.6.2.3

Works fine for me.  Are you sure you didn't have a typo in your 
original git-new-workdir invocation?  If so, could you supply:

  1) the complete output of running git-new-workdir
  2) the output of "git rev-parse --git-dir" run in path/to/repo/.git

Also, you shouldn't need to supply the .git, so "git new-workdir 
path/to/repo newworkdirname" should also work, have you tried that?

-- 
Julian

  ---
Linux is addictive, I'm hooked!
 	-- MaDsen Wikholm's .sig
