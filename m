From: Julian Phillips <julian@quantumfyre.co.uk>
Subject: Re: git clone problem through HTTP
Date: Fri, 20 Apr 2007 12:48:04 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0704201245330.10595@reaper.quantumfyre.co.uk>
References: <6d6a94c50704200015p65dc4a8dn4abd8aaed35b9521@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: git@vger.kernel.org
To: Aubrey Li <aubreylee@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 20 13:48:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Herb1-0008TV-Jl
	for gcvg-git@gmane.org; Fri, 20 Apr 2007 13:48:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992533AbXDTLsI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Apr 2007 07:48:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992564AbXDTLsI
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Apr 2007 07:48:08 -0400
Received: from electron.quantumfyre.co.uk ([87.106.55.16]:40354 "EHLO
	electron.quantumfyre.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S2992533AbXDTLsH (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 Apr 2007 07:48:07 -0400
Received: from neutron.quantumfyre.co.uk (neutron.datavampyre.co.uk [212.159.54.235])
	by electron.quantumfyre.co.uk (Postfix) with ESMTP id A4ADDC64B0
	for <git@vger.kernel.org>; Fri, 20 Apr 2007 12:48:05 +0100 (BST)
Received: (qmail 17518 invoked by uid 103); 20 Apr 2007 12:47:17 +0100
Received: from 192.168.0.2 by neutron.quantumfyre.co.uk (envelope-from <julian@quantumfyre.co.uk>, uid 201) with qmail-scanner-1.25st 
 (clamdscan: 0.90.2/3135. spamassassin: 3.1.8. perlscan: 1.25st.  
 Clear:RC:1(192.168.0.2):. 
 Processed in 0.045476 secs); 20 Apr 2007 11:47:17 -0000
Received: from reaper.quantumfyre.co.uk (192.168.0.2)
  by neutron.datavampyre.co.uk with SMTP; 20 Apr 2007 12:47:17 +0100
X-X-Sender: jp3@reaper.quantumfyre.co.uk
In-Reply-To: <6d6a94c50704200015p65dc4a8dn4abd8aaed35b9521@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45093>

On Fri, 20 Apr 2007, Aubrey Li wrote:

> I'm behind of a firewall on which the git port is not permitted, so I
> can only use http protocol. Unfortunately, I can't clone linus' git
> tree at all.

Linus packs his refs, which means that currently you can't clone using 
http, with any version of git.

Try http://repo.or.cz/r/linux-2.6.git/ instead?  This appears to be a 
straight clone, but without packed refs.

-- 
Julian

  ---
Go out and tell a lie that will make the whole family proud of you.
 		-- Cadmus, to Pentheus, in "The Bacchae" by Euripides
