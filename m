From: Julian Phillips <julian@quantumfyre.co.uk>
Subject: Re: [PATCH] Update listingblock monospace fix to support all docbook
 versions
Date: Fri, 20 Jul 2007 23:14:07 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707202309220.16498@reaper.quantumfyre.co.uk>
References: <Pine.LNX.4.64.0707200806540.20056@beast.quantumfyre.co.uk>
 <20070720121153.23352.73276.julian@quantumfyre.co.uk>
 <3A4230BE-5F05-4AE9-AAB3-3B66C30DEF76@silverinsanity.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Junio C Hamano <gitster@pobox.com>,
	Fredrik Tolf <fredrik@dolda2000.com>, git@vger.kernel.org
To: Brian Gernhardt <benji@silverinsanity.com>
X-From: git-owner@vger.kernel.org Sat Jul 21 00:14:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IC0kF-0002dA-ID
	for gcvg-git@gmane.org; Sat, 21 Jul 2007 00:14:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761827AbXGTWON (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Jul 2007 18:14:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761414AbXGTWOL
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Jul 2007 18:14:11 -0400
Received: from electron.quantumfyre.co.uk ([87.106.55.16]:49733 "EHLO
	electron.quantumfyre.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759461AbXGTWOK (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 Jul 2007 18:14:10 -0400
Received: from neutron.quantumfyre.co.uk (neutron.datavampyre.co.uk [212.159.54.235])
	by electron.quantumfyre.co.uk (Postfix) with ESMTP id A5219B0EBC
	for <git@vger.kernel.org>; Fri, 20 Jul 2007 23:14:08 +0100 (BST)
Received: (qmail 27059 invoked by uid 103); 20 Jul 2007 23:14:07 +0100
Received: from 192.168.0.2 by neutron.quantumfyre.co.uk (envelope-from <julian@quantumfyre.co.uk>, uid 201) with qmail-scanner-1.25st 
 (clamdscan: 0.91/3701. spamassassin: 3.2.1. perlscan: 1.25st.  
 Clear:RC:1(192.168.0.2):. 
 Processed in 0.03199 secs); 20 Jul 2007 22:14:07 -0000
Received: from reaper.quantumfyre.co.uk (192.168.0.2)
  by neutron.datavampyre.co.uk with SMTP; 20 Jul 2007 23:14:07 +0100
X-X-Sender: jp3@reaper.quantumfyre.co.uk
In-Reply-To: <3A4230BE-5F05-4AE9-AAB3-3B66C30DEF76@silverinsanity.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53124>

On Fri, 20 Jul 2007, Brian Gernhardt wrote:

>
> On Jul 20, 2007, at 8:06 AM, Julian Phillips wrote:
>
>> +while ($line = <>) {
>> +	$line =~ s/^#GIT#SET#MAN#FONT#/.ft/;
>> +	print $line;
>> +}
>
> Why not use `perl -pe "s/^#GIT#SET#MAN#FONT#/.ft/"` or an equivalent sed 
> command in the Makefile instead of having this as a separate script?

Only because my perl foo is too weak to know the perl form, and I didn't 
know how to get sed to replace unicode characters - which the original 
version of the script did.  I rewrote the script in my lunchbreak after I 
failed to find any better way to solve the problem, and it didn't occur to 
me to move it to sed at that point.

However, given the other issues with docbook xsl 1.72 I think it would 
cleaner to simply say that git doesn't support 1.72.  I wouldn't be 
surprised if other projects weren't taking that approach.

-- 
Julian

  ---
It's computer hardware, of course it's worth having <g>
 	-- Espy on #Debian
